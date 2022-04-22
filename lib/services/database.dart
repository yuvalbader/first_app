import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  late final String? uid;

  DatabaseService({this.uid});

  //collection reference
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('Devices');

  Future updateUserData(String email, String firstName, String lastName, String phoneNumber) async {
    return await usersCollection
        .doc(uid)
        .set({'Email':email, 'First Name':firstName,'Last Name':lastName,'Phone Number':phoneNumber});
  }
   Future updateUserEmail(String email) async {
    return await usersCollection
        .doc(uid).
        update({'Email':email});
  }
 Future updateUserFirstName(String firstName) async {
    return await usersCollection
        .doc(uid)
        .update({'First Name':firstName});
  }
   Future updateUserLastName(String lastName) async {
    return await usersCollection
        .doc(uid)
        .update({'Last Name':lastName});
  }
   Future updateUserPhoneNumber(String phoneNumber) async {
    return await usersCollection
        .doc(uid)
        .update({'Phone Number':phoneNumber});
  }
  Future updateLigthState(bool ligthSatae) async {
    return await usersCollection.doc(uid).update({'Ligth': ligthSatae});
  }

  Future updateUserDuration(Duration duration) async {
    return await usersCollection
        .doc(uid)
        .update({'Duration': duration.toString()});
  }

  Stream<QuerySnapshot> get users {
    return usersCollection.snapshots();
  }
}
