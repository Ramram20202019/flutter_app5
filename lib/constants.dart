import 'package:cloud_firestore/cloud_firestore.dart';

// Get Slots for Phase - 1
 getslotP1() async {
  QuerySnapshot q = await Firestore.instance.collection('ParkingDB').where('Slot_no', isGreaterThan: 'P1').getDocuments();
  QuerySnapshot q2 = await Firestore.instance.collection('Slots').document('Phase-1').collection('totslots').where('Slot_no', isGreaterThan: '').getDocuments();
  int slots_p1 = 16;
  int t = q2.documents.length;
  String v = t.toString() + '/' + slots_p1.toString();
  return v;
}


//Get Slots for Phase - 2
getslotP2() async {
 QuerySnapshot q = await Firestore.instance.collection('ParkingDB').where('Slot_no', isGreaterThan: 'P1').getDocuments();
 QuerySnapshot q2 = await Firestore.instance.collection('Slots').document('Phase-3').collection('totslots').where('Slot_no', isGreaterThan: '').getDocuments();
 int slots_p2 = 9;
 int t = q2.documents.length;
 String v = t.toString() + '/' + slots_p2.toString();
 return v;
}

//Get total slots
Future<String> getslot() async {
 QuerySnapshot q = await Firestore.instance.collection('ParkingDB').where('Slot_no', isGreaterThan: '').getDocuments();
 int t = 25;
 int s = 25 - q.documents.length;
 String v = s.toString() + '/' + t.toString();
 return v;
}

//Minimum distance for the user(with vehicle) to be present to book a slot

double getdist() {
  return 1000; // The value 1000 is in meters i.e. 1 KM
}