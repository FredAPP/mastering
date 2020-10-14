import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mastering/models/category.dart';

class DbApi {
  Stream<QuerySnapshot> getCategory() {
    FirebaseFirestore db = FirebaseFirestore.instance;
    try {
      Stream<QuerySnapshot> querySnapshot =
          db.collection('Categories').snapshots();
      return querySnapshot;
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Stream<QuerySnapshot> getProducts(Category category) {
    FirebaseFirestore db = FirebaseFirestore.instance;
    try {
      Stream<QuerySnapshot> querySnapshot = db
          .collection('Categories')
          .doc(category.id)
          .collection('parts')
          .snapshots();
      return querySnapshot;
    } catch (e) {
      print(e);
      throw (e);
    }
  }
}
