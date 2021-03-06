/*import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'main.dart';

import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:fluttertoast/fluttertoast.dart';



// ignore: must_be_immutable, camel_case_types
class slotshow extends StatefulWidget{
  String slotno;
  String username;
  slotshow({Key key, this.slotno, this.username}) : super (key: key);

  @override
  _slotshow createState() => _slotshow();
}

// ignore: camel_case_types
class _slotshow extends State<slotshow> with WidgetsBindingObserver{

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("APP_STATE: $state");

    if(state == AppLifecycleState.resumed){
      Navigator.pushReplacement(
          context, MaterialPageRoute(
          builder: (context) => MyHomePage()));
    }else if(state == AppLifecycleState.inactive){
      // app is inactive
    }else if(state == AppLifecycleState.paused){
      // user quit our app temporally
    }
  }

Future<String> initstate() async {
      QuerySnapshot querySnapshot = await Firestore.instance.collection(
        'ParkingDB')
        .where('Email', isEqualTo: '${widget.username}')
        .getDocuments();
    var doc = querySnapshot.documents;

    if (doc[0]['Slot_no'] != null) {
      await Future.delayed(Duration(seconds: 2));
      String v = "Hello\t" + doc[0]['Email'] + "\t....You have booked the slot\t" + doc[0]['Slot_no'];
     return v;
    }

    else {
      await Future.delayed(Duration(seconds: 2));

      String v = "Hello\t"+ doc[0]['Email'] + '\t....Please book a slot';
      return v;
    }
  }





  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFFF9861),

        appBar: AppBar(
          leading:
          IconButton(
            icon: Icon(Icons.arrow_back_ios),

            onPressed: () { Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Page2(username: '${widget.username}',)));

            },
          ),

           title: Text('Your Bookings', style: TextStyle(fontFamily: 'Roboto', fontSize: 22.0),),
           actions: <Widget>[
             new IconButton(icon: Icon(MdiIcons.logout, color: Color(0xFFFFFFFF), size: 35.0,), onPressed: (){_signout(context);})],

          backgroundColor: Color(0xFFFF9861),
        ),


        body:
        Center(
          child: Container(padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
            height: 500.0,

            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(80.0)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black87,
                      offset: Offset(0.0, 0.0),
                      blurRadius: 25.0
                  )
                ]

            ),
            child:  Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(padding: EdgeInsets.only(top: 50.0),
                     child: FutureBuilder<String>(
                      future: initstate(),
                      initialData: "Please Wait Loading......",
                      builder: (context, snapshot) {

                        return new Text(snapshot.data.toString(), style: TextStyle(fontFamily: 'Roboto', fontSize: 25.0, fontWeight: FontWeight.bold),);
                     }),
                ),

                  Container(padding: EdgeInsets.only(top: 50.0, right: 50.0),
                      child: RaisedButton(
                          onPressed: () async{
                            bool _isbe;
                            QuerySnapshot querySnapshot = await Firestore.instance.collection(
                                'ParkingDB')
                                .where('Email', isEqualTo: '${widget.username}')
                                .getDocuments();
                            var doc = querySnapshot.documents;
                            if (doc[0]['Slot_no'] != null) {_isbe = true;}
                            else{_isbe = false;}

                            _isbe ? checkdata(): null;
                          },

                          textColor: Colors.white,
                          splashColor: Colors.grey,
                          padding: const EdgeInsets.all(0.0),
                          child: Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: <Color>[
                                  Color(0xFFFF9861),
                                  Color(0xFF42A5F5),
                                ],
                              ),
                            ),
                            padding: const EdgeInsets.all(10.0),
                            child: const Text(
                                'CANCEL BOOKING',
                                style: TextStyle(fontSize: 20,
                                    fontFamily: 'Pacifico')
                            ),
                          )
                      )
                  )
              ]),
            )
                ),
        )
      )
    );

  }

  Future<void> checkdata() async {
    QuerySnapshot querySnapshot = await Firestore.instance.collection(
        'ParkingDB')
        .where('Email', isEqualTo: '${widget.username}')
        .getDocuments();
    var doc = querySnapshot.documents;


    if (doc[0]['Slot_no'] != null) {

      final DocumentReference documentReference =
      Firestore.instance.collection("Slots").document();
      Map<String, String> data = <String, String>{
        "Slot_no": doc[0]['Slot_no']
      };
      documentReference.setData(data).whenComplete(() {
        print("Document Added");
      }).catchError((e) => print(e));
      Firestore.instance.collection('ParkingDB').document(doc[0].documentID).updateData({'Slot_no': FieldValue.delete()}).whenComplete((){
        Fluttertoast.showToast(
            msg: "You have cancelled your slot",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.push(context, MaterialPageRoute(builder: (context) => Page2(username: '${widget.username}',)));
      });
    }

  }

  _signout(context) async {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "Are you sure you want to Logout? ",
      buttons: [
        DialogButton(
          child: Text(
            "NO",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        ),
        DialogButton(
          child: Text(
            "YES",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () async{
            try {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.pushReplacement(
                  context, MaterialPageRoute(
                  builder: (context) => MyHomePage()));
              Flushbar(
                padding: EdgeInsets.all(10),
                borderRadius: 8,
                backgroundColor: Colors.blue,
                boxShadows: [
                  BoxShadow(
                    color: Colors.black45,
                    offset: Offset(3, 3),
                    blurRadius: 3,
                  ),
                ],
                duration: new Duration(seconds: 4),
                dismissDirection: FlushbarDismissDirection.HORIZONTAL,
                forwardAnimationCurve: Curves.easeInOutCubic,
                title: "Logged Out Successfully",
                message: " ",
                flushbarPosition: FlushbarPosition.TOP,
                icon: Icon(Icons.thumb_up, color: Colors.white,),

              ).show(context);
            }
            catch (e) {
              print(e.message);
            }

          },
          width: 120,
        ),
      ],
    ).show();


  }


}


*/







