import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'choosealocation.dart';





class bookaslot extends StatefulWidget{
  String username;
  String park;
  bookaslot({Key key, this.username}) : super (key: key);

  @override
  _bookaslot createState() => _bookaslot();
}


class _bookaslot extends State<bookaslot> {
  Completer<GoogleMapController> _controller = Completer();
  final LatLng _center = const LatLng(45.521563, -122.677433);


  void _onMapCreated(GoogleMapController controller) {

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(


      home: Scaffold(
        appBar: AppBar(leading:
        IconButton(
          icon: Icon(Icons.arrow_back_ios),

          onPressed: () { Navigator.pop(context);

          },
        ),

          title: Text('Choose a Location', textAlign: TextAlign.center,),
          backgroundColor: Color(0xFFFF9861),
        ),
        body: Stack(
          children: <Widget>[
            _buildGoogleMap(context),
            _buildContainer(),

          ],
        ),
      ),
    );
  }

  Widget _buildGoogleMap(BuildContext context) {

    return Container(

        height: MediaQuery
            .of(context)
            .size
            .height,
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
              target: LatLng(12.9864, 80.2425), zoom: 14),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          markers: {
            ascendasmarker, tidelmarker
          },
        )
    );
  }
  Marker ascendasmarker = Marker(
    markerId: MarkerId('Ascendas IT Park'),
    position: LatLng(12.9864, 80.2425),

    infoWindow: InfoWindow(title: 'Ascendas IT Park, Taramani', ),
    icon: BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueRed,
    ),
  );

  Marker tidelmarker = Marker(
    markerId: MarkerId('Tidel Park'),
    position: LatLng(12.9896, 80.2486),
    infoWindow: InfoWindow(title: 'Tidel Park'),
    icon: BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueRed,
    ),
  );


  Widget _buildContainer() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 150.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://www.google.com/maps/uv?hl=en&pb=!1s0x3a525d639e47618b%3A0xaa10fd327e29e31c!3m1!7e115!4shttps%3A%2F%2Flh5.googleusercontent.com%2Fp%2FAF1QipO4_ADl2bWjQ6Xaa8un7jOIMAwXbm2HkQCUPjD-%3Dw406-h200-k-no!5sascendas%20it%20park%20chennai%20-%20Google%20Search!15sCAQ&imagekey=!1e10!2sAF1QipNHLg-Eu9OUhgd1uH8T4_OfOHRyMH-BVTr_zeq1&sa=X&ved=2ahUKEwidp-vWpefmAhUnzjgGHce7CCoQoiowFHoECB0QBg",
                  12.9864, 80.2425, "Ascendas IT Park, Taramani"),
            ),
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://content3.jdmagicbox.com/comp/chennai/95/044p7003295/catalogue/tidel-park-ltd-tharamani-chennai-business-centres-8zavy.jpg?clr=264040",
                  12.9896, 80.2486, "Tidel Park, Chennai"),
            ),

          ],
        ),
      ),
    );
  }

  Widget _boxes(String _image, double lat, double long, String ParkName) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => choosealocation(username: '${widget.username}',)));
        /* _gotoLocation(lat, long);*/
      },
      child: Container(
        child: new FittedBox(
          child: Material(
              color: Colors.white,
              elevation: 14.0,
              borderRadius: BorderRadius.circular(24.0),
              shadowColor: Color(0x802196F3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 180,
                    height: 200,
                    child: ClipRRect(
                      borderRadius: new BorderRadius.circular(24.0),
                      child: Image(
                        fit: BoxFit.fill,
                        image: NetworkImage(_image),
                      ),
                    ),),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: myDetailsContainer1(ParkName),
                    ),
                  ),

                ],)
          ),
        ),
      ),
    );
  }

  Future<void> _gotoLocation(double lat, double long) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, long), zoom: 15, tilt: 50.0,
          bearing: 45.0,)));
  }


  Widget myDetailsContainer1(String ParkName) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Text(ParkName,
                style: TextStyle(
                    color: Color(0xff6200ee),
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold),
              )),
        ),
        SizedBox(height: 5.0),
        Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                    child: Text(
                      "4.1",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18.0,
                      ),
                    )),
                Container(
                  child: Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 15.0,
                  ),
                ),
                Container(
                  child: Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 15.0,
                  ),
                ),
                Container(
                  child: Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 15.0,
                  ),
                ),
                Container(
                  child: Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 15.0,
                  ),
                ),
                Container(
                  child: Icon(
                    Icons.star_half,
                    color: Colors.amber,
                    size: 15.0,
                  ),
                ),
                Container(
                    child: Text(
                      "(946)",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18.0,
                      ),
                    )),
              ],
            )),

      ],
    );
  }




}




