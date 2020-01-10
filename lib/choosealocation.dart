import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'slotshow.dart';


class choosealocation extends StatefulWidget {
  String parkname;
  choosealocation({Key key, this.parkname}) : super (key: key);

  @override
  _choosealocationstate createState() => _choosealocationstate();
}

class _choosealocationstate extends State<choosealocation> with TickerProviderStateMixin {


  final DocumentReference documentReference =
  Firestore.instance.document("ParkingDB/sample");

  TabController _tabController;
  bool showFab = true;

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    List<String> getListelements() {
      var items = List<String>.generate(
          20, (counter) => "P1 - A${counter + 1}");
      return items;
    }


    void _add(i) {
      Firestore.instance
          .collection('ParkingDB')
          .where("Email", isEqualTo: "abc@gmail.com")
          .snapshots()
          .listen((data) =>
          data.documents.forEach((doc) => ));
      Map<String, String> data = <String, String>{
        "Email": "abc@gmail.com",
        "Slot_no": i
      };
      documentReference.setData(data).whenComplete(() {
        print("Document Added");
      }).catchError((e) => print(e));
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

              /*Fluttertoast.showToast(msg: "You have booked the slot\n" + Listitems[index] +
                  "\n!!!!!",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIos: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0);
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) =>
                  slotshow(username: Listitems[index],)));*/

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
          /* body: grid(),*/
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


}



