
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import 'slotshow.dart';
import 'bookaslot.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';




void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home:MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}


class MyHomePage extends StatefulWidget{


  @override
  _Myhomepagestate createState() => _Myhomepagestate();
}

class _Myhomepagestate extends State<MyHomePage> with WidgetsBindingObserver{

  /*Parking parking = new Parking();
  String username, pwd;*/
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String un;
  String pw;

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


  var _u = new TextEditingController();
  var _p = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

        backgroundColor: Color(0xFFFF9861),
        body: Form(
            key: _formKey,
            child: ListView(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 15.0, left: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(icon: Icon(Icons.arrow_back_ios),
                            disabledColor: Colors.white,
                            onPressed: null),
                      ],
                    ),
                  ),

                  SizedBox(height: 25.0),
                  Padding(
                    padding: EdgeInsets.only(left: 40.0),
                    child: Row(
                      children: <Widget>[
                        Text('My Parking',
                            style: TextStyle(
                                fontFamily: 'Pacifico',
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 30.0
                            )),
                        Text('\tApp',
                            style: TextStyle(
                                fontFamily: 'Pacifico',
                                color: Colors.white,
                                fontSize: 30.0

                            ))
                      ],
                    ),
                  ),
                  SizedBox(height: 40.0),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                      height: MediaQuery
                          .of(context)
                          .size
                          .height - 320.0,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(60.0),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black87,
                                offset: Offset(0.0, 0.0),
                                blurRadius: 25.0
                            )
                          ]

                      ),
                      child: Padding(
                          padding: EdgeInsets.only(
                              left: 16.0, right: 16.0, top: 50.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text('LOGIN',
                                    style: TextStyle(
                                        fontSize: 25.0,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: .6)),
                                SizedBox(
                                  height: 15.0,
                                ),
                                Text('Email',
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        fontFamily: 'Roboto',
                                        letterSpacing: .6)),
                                new TextFormField(
                                  controller: _u,
                                  validator: (val) =>
                                  val.isEmpty
                                      ? 'Email cannot be empty'
                                      : null,

                                  onSaved: (val) => un = val,

                                  decoration: InputDecoration(
                                    hintText: "Email",

                                    hintStyle: TextStyle(
                                        color: Colors.grey, fontSize: 12.0),),
                                ),

                                SizedBox(
                                  height: 15.0,
                                ),
                                Text('PASSWORD',
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        fontFamily: 'Roboto',
                                        letterSpacing: .6)),
                                new TextFormField(
                                  controller: _p,
                                  validator: (val) =>
                                  val.isEmpty
                                      ? 'Password cannot be empty'
                                      : null,
                                  onSaved: (val) => pw = val,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    hintText: "password",
                                    hintStyle: TextStyle(
                                        color: Colors.grey, fontSize: 12.0),),
                                ),

                                RaisedButton(
                                    onPressed: () {
                                      signin();
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
                                          'SIGN IN',
                                          style: TextStyle(fontSize: 20,
                                              fontFamily: 'Pacifico')
                                      ),
                                    )
                                )
                              ]
                          )
                      )
                  )
                ]
            )
        )
    );
  }

  Future<void> signin() async {


    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(email: un, password: pw);
        Future<bool> ret() async{
          QuerySnapshot q = await Firestore.instance.collection('ParkingDB')
              .where('Email', isGreaterThan: '')
              .getDocuments();
          bool i1 = false;
          var d = q.documents;
          for (int j = 0; j < q.documents.length; j++) {
            if(un == d[j]['Email'].toString()){
              i1 = true;
            }
          }
          return i1;
        }

        bool j = await ret();
        if(!j){
          Firestore.instance.collection("ParkingDB").document().setData({'Email': un});
          print('User added to the database');
        }
        Navigator.push(context, MaterialPageRoute(builder: (context) => Page2(username: un,)));
      } catch (e) {
        Fluttertoast.showToast(

            msg: "Invalid Credentials. Please try again!!!!!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);

        print(e.message);
      }

    }
  }


}



class Page2 extends StatefulWidget{
  String username;
  Page2({Key key, this.username}) : super (key: key);

  @override
  _Page2state createState() => _Page2state();
}

class _Page2state extends State<Page2> {




  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(backgroundColor: Color(0xFFFF9861),
        appBar: AppBar(
          backgroundColor: Color(0xFFFF9861),

          leading:
          IconButton(
            icon: Icon(Icons.arrow_back_ios),

              onPressed: () { Navigator.pop(context);

             },
            ),
          actions: <Widget>[
            Container(padding: EdgeInsets.only(top: 17.0),child: new Text('Logout',  style: TextStyle(fontFamily: 'Roboto', fontSize: 22.0),)),
            new IconButton(icon: Icon(Icons.account_box, color: Color(0xFFFFFFFF), size: 35.0,), onPressed: (){_signout();})
          ],

        ),
        body: ListView(
            children: <Widget>[


              SizedBox(height: 25.0,),
              Padding(
                padding: EdgeInsets.only(left: 40.0),
                child: Wrap(
                  children: <Widget>[Row(
                    children: <Widget>[
                      Text('Welcome\t',
                          style: TextStyle(
                              fontFamily: 'Pacifico',
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25.0
                          )),
                      Text('${widget.username}'.substring(0, 8) + '!!!!',
                          style: TextStyle(
                              fontFamily: 'Pacifico',
                              color: Colors.black,
                              fontSize: 25.0

                          ))
                    ],
                  ),
                ]),
              ),

              SizedBox(height: 40.0),
              Container(
                  padding: EdgeInsets.only(left: 20.0, right: 5.0),
                  height: MediaQuery
                      .of(context)
                      .size
                      .height - 350.0,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(80.0),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black87,
                            offset: Offset(0.0, 0.0),
                            blurRadius: 25.0
                        )
                      ]

                  ),

                  child: Padding(
                      padding: EdgeInsets.only(
                          left: 1.0, right: 1.0, top: 16.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text('DASHBOARD',
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: .6)),
                            RaisedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context, MaterialPageRoute(
                                      builder: (context) =>
                                          slotshow(
                                            username: '${widget.username}',)));
                                },
                                textColor: Colors.white,
                                splashColor: Colors.grey,

                                padding: const EdgeInsets.all(0.0),
                                child: Container(
                                  width: 250.0,
                                  height: 80.0,
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
                                      'MY BOOKINGS',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 20,
                                          fontFamily: 'Pacifico')
                                  ),
                                )
                            ),
                            RaisedButton(
                                onPressed: () {
                                  checkuser();

                                },
                                textColor: Colors.white,
                                splashColor: Colors.grey,
                                padding: const EdgeInsets.all(0.0),
                                child: Container(
                                  width: 250.0,
                                  height: 80.0,
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
                                      'BOOK A SLOT',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 20,
                                          fontFamily: 'Pacifico')
                                  ),
                                )
                            )
                          ]
                      )
                  )
              )
            ]
        )

    );
  }

  Future<void> checkuser() async {
    QuerySnapshot querySnapshot = await Firestore.instance.collection(
        'ParkingDB')
        .where('Email', isEqualTo: '${widget.username}')
        .getDocuments();
    var doc = querySnapshot.documents;
    print(doc[0].documentID);
    print(doc[0]['Slot_no']);


    if (doc[0]['Slot_no'] != null) {
      print('Inside if');
      Fluttertoast.showToast(
          msg: "You have already booked a slot cannot book again. Please cancel the slot you have booked for booking again",
          toastLength: Toast.LENGTH_LONG,
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
      Navigator.push(
          context, MaterialPageRoute(
          builder: (context) => bookaslot(username: '${widget.username}',)));
    }
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
















