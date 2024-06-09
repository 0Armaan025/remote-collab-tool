import 'package:cloud_firestore/cloud_firestore.dart';

void sendMessage(
  senderID,
  receiverID,
  message,
) {
  int messageTime = DateTime.now().microsecondsSinceEpoch;
  FirebaseFirestore.instance
      .collection("user")
      .doc(receiverID)
      .collection(senderID)
      .doc("${messageTime}")
      .set({
    "message": message,
    "sender": false,
    "messageTime": messageTime,
  });
  FirebaseFirestore.instance
      .collection("user")
      .doc(senderID)
      .collection(receiverID)
      .doc("${messageTime}")
      .set({
    "message": message,
    "sender": true, // This field will tell the user that whether he is sender or not  
    "messageTime": messageTime,
  });
}
