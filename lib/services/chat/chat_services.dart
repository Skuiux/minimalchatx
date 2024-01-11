import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:minimalchatx/models/message.dart';

class Chatservice{
  // get instance of firestore $ auth
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseAuth _auth= FirebaseAuth.instance;
  // get user stream
Stream<List<Map<String,dynamic>>> getUsersStream(){
  return _firestore.collection("Users").snapshots().map((snapshot){
    return snapshot.docs.map((doc) {
      final user = doc.data();
      return user;
    }).toList();
  });
}

//send message
Future<void> sendMessage(String receiverID,message )async{
  //get current user info
final String currentUserID = _auth.currentUser!.uid;
final String currentUserEmail = _auth.currentUser!.email!;
final Timestamp timestamp = Timestamp.now();

  //create a new message
Message newMessage = Message(senderID: currentUserID, senderEmail: currentUserEmail, receiverID: receiverID, message: message, timestamp: timestamp);
  //construct chat room ID For Two Users(sorted to ensure uniquness)
List<String> ids = [currentUserID,receiverID];
ids.sort(); // sort the ids(this ensure the chatroom Id
String chatRoomID = ids.join('_');// )
  //add new message
await _firestore.collection("chat_rooms").doc(chatRoomID).collection("message").add(newMessage.toMap());
}
//get message

Stream<QuerySnapshot> getMessages(String userID,otherUserID){
  // construct  a chatroomId for the two users

  List<String> ids =[userID,otherUserID];
  ids.sort();
  String chatRoomID = ids.join('_');

  return _firestore.collection("chat_rooms").doc(chatRoomID).collection("messages").orderBy("timestamp",descending: false).snapshots();
}
}