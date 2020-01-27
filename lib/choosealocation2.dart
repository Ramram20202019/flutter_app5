import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'main.dart';
import 'slotshow.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';


// ignore: must_be_immutable, camel_case_types
class choosealocation2 extends StatefulWidget {
  String username;
  choosealocation2({Key key, this.username}) : super (key: key);

  @override
  _choosealocation2state createState() => _choosealocation2state();
}

// ignore: camel_case_types
class _choosealocation2state extends State<choosealocation2> with TickerProviderStateMixin, WidgetsBindingObserver {

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


  bool showFab = true;




  @override
  Widget build(BuildContext context) {



    Future getdata () async {


      QuerySnapshot q1 = await Firestore.instance.collection('Slots').orderBy('Slot_no').getDocuments();


         return q1.documents;
    }


    void _add(i) async{


      QuerySnapshot querySnapshot = await Firestore.instance.collection('ParkingDB').where('Email', isEqualTo: '${widget.username}').getDocuments();
      var doc = querySnapshot.documents;
      print(doc[0].documentID);
      print(doc[0]['Slot_no']);



      if(doc[0]['Slot_no'] != null){
        print('Inside if');
        Fluttertoast.showToast(
            msg: "You have already booked a slot cannot book again",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) =>
            slotshow(username: doc[0]['Email'],)));
      }
      else{


        Future ret() async{
          QuerySnapshot q = await Firestore.instance.collection('ParkingDB')
              .where('Slot_no', isGreaterThan: '')
              .getDocuments();
          bool i1 = false;
          var d = q.documents;
          for (int j = 0; j < q.documents.length; j++) {
            if(i.toString() == d[j]['Slot_no'].toString()){
              i1 = true;
            }
          }
          return i1;
        }

        bool j = await ret();
        if(j) {
          Fluttertoast.showToast(
              msg: "This Slot has already been booked. Please choose another slot",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIos: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);

        }

        else{
          final DocumentReference documentReference =
          Firestore.instance.collection("ParkingDB").document(
              doc[0].documentID);
          Map<String, String> data = <String, String>{
            "Email": "${widget.username}",
            "Slot_no": i
          };
          documentReference.updateData(data).whenComplete(() {
            print("Document Added");
          }).catchError((e) => print(e));

          QuerySnapshot q2 = await Firestore.instance.collection('Slots').where('Slot_no', isEqualTo: i).getDocuments();
          var doc1 = q2.documents;

          Firestore.instance.collection("Slots").document(
              doc1[0].documentID).delete();


          Navigator.push(
              context, MaterialPageRoute(builder: (context) =>
              slotshow(slotno: i, username: "${widget.username}",)));
        }

      }



    }





    List<Widget> containers = [
      SafeArea(
          child: Container(

              child: Scaffold(
                body:  FutureBuilder(future: getdata(), builder: (context, snapshot){

                  if(snapshot.connectionState == ConnectionState.waiting || snapshot.hasData == null){
                    return Center(
                      child: Text('Loading...'),
                    );
                  }else{

                    return ListView.separated(itemCount: snapshot.data.length,
                        itemBuilder: (context, index){
                          return ListTile (trailing: new RawMaterialButton(
                            onPressed: () {},
                            child: new Icon(
                              Icons.local_parking,
                              color: Colors.green,
                              size: 45.0,
                            ),

                          ),
                            leading: new RawMaterialButton(
                              onPressed: () {},
                              child: new Icon(
                                MdiIcons.car,
                                color: Colors.blue,
                                size: 45.0,
                              ),
                              shape: new CircleBorder(),
                              elevation: 2.0,
                              fillColor: Colors.white,
                              padding: const EdgeInsets.all(5.0),
                            ),

                            title: Text(snapshot.data[index].data['Slot_no']),
                            onTap: (){_add(snapshot.data[index].data['Slot_no']);},

                          );

                        },
                        separatorBuilder: (context, index) {
                          return Divider();
                        }
                    );

                  }

                },),
              )
          )
      ),

      Container(
        child: Scaffold(
          body: Container(padding: EdgeInsets.only(left: 100.0, top: 250.0),
            child: new Text("Coming Soon", textAlign: TextAlign.center, style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.bold, fontSize: 40.0),),
          ),
        ),
      ),

    ];


    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading:
          IconButton(
            icon: Icon(Icons.arrow_back_ios),

            onPressed: () {
              Navigator.pop(context);
            },
          ),

          title: Text('Choose a Slot', textAlign: TextAlign.center,),
          actions: <Widget>[
            new IconButton(icon: Icon(MdiIcons.logout, color: Color(0xFFFFFFFF), size: 35.0,), onPressed: (){_signout(context);}),
          ],
          elevation: 0.7,
          backgroundColor: Color(0xFFFF9861),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                text: 'PHASE - 1',
              ),
              Tab(
                text: 'PHASE - 2',
              ),

            ],
          ),
        ),
        body: TabBarView(
          children: containers,
        ),
      ),
    );
  }
  _signout(context) async {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "Are you sure you want to exit? ",
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

              Fluttertoast.showToast(
                  msg: "Loggedout Succesfully",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIos: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0);
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.pushReplacement(
                  context, MaterialPageRoute(
                  builder: (context) => MyHomePage()));
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



