import 'package:flutter/material.dart';

class slotshow extends StatefulWidget{
  String username;
  slotshow({Key key, this.username}) : super (key: key);

  @override
  _slotshow createState() => _slotshow();
}

class _slotshow extends State<slotshow> {

  @override
  void initState(){
    super.initState();

  }

/*String getdata() {
  DatabaseReference db = FirebaseDatabase.instance.reference();
  db.child("ParkingDB").once().then((DataSnapshot snap) {
    var keys = snap.value.keys;
    var value = snap.value;
    for (var k in keys) {
      if ('${widget.username}' == k) {
        String v = snap.value.k;
        return v;
      }
    }
    print(snap.value);
    print("\n---------------------");
    print("\n");
    print(snap.value.keys);
  });
}*/






  @override
  /* Widget build(BuildContext context) {

    String d = initstate();
    if (d == ' ' || d == null) {
      // TODO: implement build
      return Scaffold(backgroundColor: Color(0xFF21BFBD),
          body:
          ListView(
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
                      Text('Welcome\t',
                          style: TextStyle(
                              fontFamily: 'Pacifico',
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25.0
                          )),
                      Text('${widget.username}' + '!!!!',
                          style: TextStyle(
                              fontFamily: 'Pacifico',
                              color: Colors.black,
                              fontSize: 25.0

                          ))
                    ],
                  ),
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

                              Text(
                                  'You did not booked a slot yet, Please book the slot',
                                  style: TextStyle(
                                      fontSize: 35.0,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: .6)),


                            ]
                        )
                    )
                )
              ]
          )

      );
    }
    else{
      return Scaffold(backgroundColor: Color(0xFF21BFBD),
          body:
          ListView(
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
                      Text('Welcome\t',
                          style: TextStyle(
                              fontFamily: 'Pacifico',
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25.0
                          )),
                      Text('${widget.username}' + '!!!!',
                          style: TextStyle(
                              fontFamily: 'Pacifico',
                              color: Colors.black,
                              fontSize: 25.0

                          ))
                    ],
                  ),
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

                              Text(
                                  'Your booked slot is' + d +'. Valid till 9P.M. tonight',
                                  style: TextStyle(
                                      fontSize: 35.0,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: .6)),


                            ]
                        )
                    )
                )
              ]
          )

      );
    }
  }*/
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading:
          IconButton(
            icon: Icon(Icons.arrow_back_ios),

            onPressed: () { Navigator.pop(context);

            },
          ),

          title: Text('Your Bookings', textAlign: TextAlign.center,),

          backgroundColor: Color(0xFFFF9861),
        ),


        body: Container(
          child: Text('Your Booked slot is ${widget.username}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, fontFamily: 'Roboto'),textAlign: TextAlign.center,),
        ),
      ),
    );
  }


}










