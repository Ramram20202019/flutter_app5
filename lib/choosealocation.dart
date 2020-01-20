import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'main.dart';
import 'slotshow.dart';


class choosealocation extends StatefulWidget {
  String username;
  choosealocation({Key key, this.username}) : super (key: key);

  @override
  _choosealocationstate createState() => _choosealocationstate();
}

class _choosealocationstate extends State<choosealocation> with TickerProviderStateMixin, WidgetsBindingObserver {

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


 /* final DocumentReference documentReference =
  Firestore.instance.collection("ParkingDB").document();*/

  TabController _tabController;
  bool showFab = true;




  @override
  Widget build(BuildContext context) {
    List<String> getListelements() {
      var items = List<String>.generate(
          20, (counter) => "P1 - A${counter + 1}");
      return items;
    }


    void _add(i) async{


      QuerySnapshot querySnapshot = await Firestore.instance.collection('ParkingDB').where('Email', isEqualTo: '${widget.username}').getDocuments();
      var doc = querySnapshot.documents;
      print(doc[0].documentID);
      print(doc[0]['Slot_no']);



        /* Firestore.instance.collection("ParkingDB").document().setData({'Email': '1234@gmail.com'});*/







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


        Future<bool> ret() async{
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

          Navigator.push(
           context, MaterialPageRoute(builder: (context) =>
            slotshow(slotno: i, username: "${widget.username}",)));
      }

      }


    }

   Widget getlistview() {
      var Listitems = getListelements();

      var listView = ListView.separated(
          itemCount: Listitems.length, itemBuilder: (context, index) {

        return Container(

          child: ListTile(contentPadding: EdgeInsets.only(bottom: 5.0),
              trailing: new RawMaterialButton(
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
                  Icons.directions_car,
                  color: Colors.blue,
                  size: 45.0,
                ),
                shape: new CircleBorder(),
                elevation: 2.0,
                fillColor: Colors.white,
                padding: const EdgeInsets.all(5.0),
              ),

              title: Text(Listitems[index], style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 25,
                  fontWeight: FontWeight.bold),),
              onTap: () {_add(Listitems[index]);

              }


          ),
        );
      },
          separatorBuilder: (context, index) {
            return Divider();
          }


      );


      return listView;
    }


    List<Widget> containers = [
      SafeArea(
        child: Container(

            child: Scaffold(
              body: getlistview(),
            )
        ),
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
            Container(padding: EdgeInsets.only(top: 15.0),child:  Text('Logout',  style: TextStyle(fontFamily: 'Roboto', fontSize: 22.0),)),
            new IconButton(icon: Icon(Icons.account_box, color: Color(0xFFFFFFFF), size: 35.0,), onPressed: (){_signout();}),
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
  _signout() async{
    try{
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
    catch(e){
      print(e.message);}

  }

}



