import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseSlambookAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getAllSlambooks() {
    return db.collection("slambook").snapshots();
  }

  Future<String> addSlambook(Map<String, dynamic> slambook) async {
    try {
      await db.collection("slambook").add(slambook);
      return "Successfully added an entry!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  Future<String> deleteSlambook(String? id) async {
    try {
      await db.collection("slambook").doc(id).delete();

      return "Successfully deleted an entry!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  Future<String> editSlambook(String? id, String field, dynamic title) async {

    switch (field) {
      case "relationship":
        if (title == "true") {
          title = true;
        } else if (title == "false") {
          title = false;
        }
        break;
      case "age":
        title = int.parse(title);
        break;
      case "happiness":
        title = int.parse(title);
        break;
    }

    try {
      print("New $field: $title");
      await db.collection("slambook").doc(id).update({field: title});

      return "Successfully edited todo!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }
}