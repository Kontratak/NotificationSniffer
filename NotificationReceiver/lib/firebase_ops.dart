import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseOps{
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static late CollectionReference _mainCollection;
  static setFirestore(){
    _mainCollection = _firestore.collection('notifications');
  }

  static Stream<QuerySnapshot> readItems(){
    return _mainCollection.snapshots();
  }
}