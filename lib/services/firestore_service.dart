

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_chat_app/models/user_model.dart';

class FirestoreService {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference users =
  FirebaseFirestore.instance.collection('users');

  Future<void> addUser(String username, String email, String? photoUrl) {
    // Call the user's CollectionReference to add a new user
    return users
        .add({
      'username': username,
      'userId':email,
      'photoUrl':photoUrl
    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add User: $error"));
  }

  Future<UserModel> getUserInfo(String email) async{
    // Call the user's CollectionReference to add a new user
    var user = await users.where('userId',isEqualTo: email).get();
    return UserModel.fromJson(user.docs.first.data() as Map<String,dynamic>);
  }

  Future<void> deleteChat(String chatId) async {
    final batch = _firestore.batch();

    final chatRef = _firestore.collection('chats').doc(chatId);
    batch.delete(chatRef);

    final messagesRef = chatRef.collection('messages');
    final messagesSnapshot = await messagesRef.get();
    for (var doc in messagesSnapshot.docs) {
      batch.delete(doc.reference);
    }

    await batch.commit();
  }


  Future<void> addData(String collection, Map<String, dynamic> data) async {
    try {
      await _firestore.collection(collection).add(data);
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateData(String collection, String docId, Map<String, dynamic> data) async {
    try {
      await _firestore.collection(collection).doc(docId).update(data);
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteData(String collection, String docId) async {
    try {
      await _firestore.collection(collection).doc(docId).delete();
    } catch (e) {
      print(e);
    }
  }

  Future<QuerySnapshot> getData(String collection) async {
    try {
      return await _firestore.collection(collection).get();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Stream<QuerySnapshot> streamData(String collection) {
    try {
      return _firestore.collection(collection).snapshots();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  // convert the messages map to messages model
  // List<Message> convertList(List messagesMapList){
  //   List<Message> messagesModelList = [];
  //   messagesMapList.forEach((element) {
  //     messagesModelList.add(Message.fromJson(element));
  //   });
  //   return messagesModelList;
  // }
}
