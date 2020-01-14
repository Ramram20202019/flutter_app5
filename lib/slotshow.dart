import 'package:flutter/material.dart';


class slotshow extends StatefulWidget{
  String slotno;
  slotshow({Key key, this.slotno}) : super (key: key);

  @override
  _slotshow createState() => _slotshow();
}

class _slotshow extends State<slotshow> {

  @override
  void initState(){
    super.initState();

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

            onPressed: () { Navigator.pop(context);

            },
          ),

          title: Text('Your Bookings', textAlign: TextAlign.center,),

          backgroundColor: Color(0xFFFF9861),
        ),


        body:
        Container(padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          height: 150.0,
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
          child: Text('Your Booked slot is ${widget.slotno}'  , style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, fontFamily: 'Roboto'),textAlign: TextAlign.center,),
        ),
      ),
    );
  }


}










