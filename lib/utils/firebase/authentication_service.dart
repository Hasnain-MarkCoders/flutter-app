import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';
import 'package:likeplay/utils/constant_lists.dart';
import '../sharedpref/preferences.dart';
import '../sharedpref/shared_prefrence.dart';
import 'firebase_exceptions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthenticationService {
  final _auth = FirebaseAuth.instance;
  static late AuthStatus _status;
  //create chat...
  Future<AuthStatus> createChatUser({
    required String senderId,
    required String receiverId,
    required String senderName,
    required String receiverName,
    required String senderImage,
    required String receiverImage,
    required String admrireStatus,
    required String subscriptionStatus,
    required String subscriptionPlan,
  }) async {
    try {
      //Creating the user table here
      final resultuser = await FirebaseFirestore.instance.collection('users').doc(senderId);
      resultuser.set({
        'time_stamp':FieldValue.serverTimestamp(),
      });
      //Match for Receiver
      resultuser.collection("match").doc(receiverId).set(({
        'user_id': receiverId,
        'user_name': receiverName,
        'user_image': receiverImage,
        'message_time':DateTime.now().millisecondsSinceEpoch,
        'time_stamp':FieldValue.serverTimestamp(),
        'is_block':false,
        'is_report':false,
        'subscription_status':subscriptionStatus,
        'subscription_plan':subscriptionPlan,
        "is_chat":false
      }));


      //Create Receiver
      final resultReceiveruser = await FirebaseFirestore.instance.collection('users').doc(receiverId);
      resultReceiveruser.set({
        'time_stamp':FieldValue.serverTimestamp(),
      });

      //Match for sender
      resultReceiveruser.collection("match").doc(senderId).set(({
        'user_id': senderId,
        'user_name': senderName,
        'user_image': senderImage,
        'message_time':DateTime.now().millisecondsSinceEpoch,
        'time_stamp':FieldValue.serverTimestamp(),
        'is_block':false,
        'is_report':false,
        'subscription_status':subscriptionStatus,
        'subscription_plan':subscriptionPlan,
        "is_chat":false
      }));
      String generateChatId(String senderId, String receiverId) {
        return senderId.compareTo(receiverId) <= 0
            ? '${senderId}_${receiverId}'
            : '${receiverId}_${senderId}';
      }
      var chatId=generateChatId(senderId,receiverId);
      // print("chatId=========="+chatId.toString());

      //End
      final result = await FirebaseFirestore.instance
          .collection('chat').doc(chatId);
      result.get().then((value) {
        if(value.exists==false){
          result.set({
            'sender_id': senderId,
            'receiver_id': receiverId,
            'receiver_name': receiverName,
            'sender_name': senderName,
            'receiver_image': receiverImage,
            'sender_image': senderImage,
            "message_time":DateTime.now().millisecondsSinceEpoch,
            "time_stamp":FieldValue.serverTimestamp(),
            "members":[senderId,receiverId],
            "recentMessage":{
              "message":"",
              "messageType": "",
              "message_time":DateTime.now().millisecondsSinceEpoch,
              "time_stamp":FieldValue.serverTimestamp(),
              "receiverID": receiverId,
              "senderID": senderId,
              "senderName": senderName,
              'is_admire':admrireStatus,
              'is_block': false,
              'is_report': false,
              "sender_active_time":DateTime.now().millisecondsSinceEpoch,
              "receiver_active_time":DateTime.now().millisecondsSinceEpoch,
            },
          });
        }
      });
      _status = AuthStatus.successful;
    } on FirebaseAuthException catch (e) {
      _status = AuthExceptionHandler.handleAuthException(e);
    }
    return _status;
  }
  String generateChatId(String senderId, String receiverId) {
    return senderId.compareTo(receiverId) <= 0
        ? '${senderId}_${receiverId}'
        : '${receiverId}_${senderId}';
  }
  sendMessage(
      String senderId,
      String receiverId,
      String senderName,
      String receiverName,
      String senderImage,
      String receiverImage,
      String media_url,String message, int messageType, String thumbhnail/*, int senderAdmire,int receiverAdmire*/) async {
    try {
      final resultuser = await FirebaseFirestore.instance.collection('users').doc(senderId);
      await resultuser.collection("match").doc(receiverId).get().then((value) {
        if(value.data()!["is_chat"]==false){
          resultuser.collection("match").doc(receiverId).update({
            "is_chat":true,
          });
        }
      });

      final resultMatch = await FirebaseFirestore.instance.collection('users').doc(receiverId);
      await resultMatch.collection("match").doc(senderId).get().then((value) {
        if(value.data()!["is_chat"]==false){
          resultMatch.collection("match").doc(senderId).update({
            "is_chat":true,
          });
        } });
      var chatId=generateChatId(senderId.toString(),receiverId.toString());
      final result =await FirebaseFirestore.instance.collection('chat').doc(chatId).collection("messages");
      result.add({
        "message": message,
        "messageType": messageType,
        'sender_id': senderId,
        'receiver_id': receiverId,
        'receiver_name': receiverName,
        'sender_name': senderName,
        'receiver_image': receiverImage,
        'sender_image': senderImage,
        "thumbURL": thumbhnail,
        "media_url": media_url,
        "message_time":DateTime.now().millisecondsSinceEpoch,
        "time_stamp":FieldValue.serverTimestamp(),
        "read_status":false,
        "delete_by":[],
      });
      sendFcmMessage(receiverId,senderName,);
      //End
    } on FirebaseAuthException catch (e) {
    }
  }

  updateAdmireStatus(
      String senderId,
      String receiverId,String status) async {
    try {
      var chatId=generateChatId(senderId.toString(),receiverId.toString());
      final collectionReference =
      FirebaseFirestore.instance.collection('chat');
      await collectionReference.doc(chatId).update({
        "recentMessage.is_admire": status, // Set the new value here
      });
    } on FirebaseAuthException catch (e) {
    }
  }

  updateBlockStatus( String senderId,
      String receiverId,bool status) async {
    try {
      var chatId=generateChatId(senderId.toString(),receiverId.toString());
      final collectionReference =
      FirebaseFirestore.instance.collection('chat');
      await collectionReference.doc(chatId).get().then((value) async {
        if(value.exists){
          await collectionReference.doc(chatId).update({
            "recentMessage.is_block": status, // Set the new value here
          });
          final resultuser = await FirebaseFirestore.instance.collection('users').doc(senderId);
          resultuser.collection("match").doc(senderId).update({
            "is_block":status,
          });
        }
      });
    } on FirebaseAuthException catch (e) {
    }
  }
  updateReportStatus( String senderId,
      String receiverId,bool status) async {
    var chatId=generateChatId(senderId.toString(),receiverId.toString());
    final collectionReference =
    FirebaseFirestore.instance.collection('chat');
    await collectionReference.doc(chatId).delete();
    final resultuser = await FirebaseFirestore.instance.collection('users').doc(senderId);
    resultuser.collection("match").doc(receiverId).delete();
    final resultusers = await FirebaseFirestore.instance.collection('users').doc(receiverId);
    resultusers.collection("match").doc(senderId).delete();
    /*try {
      final collectionReference =
      FirebaseFirestore.instance.collection('chat');
      await collectionReference.doc(senderId.hashCode <= receiverId.hashCode
          ?senderId + '_' + receiverId
          :receiverId + '_' +senderId ,).update({
        "recentMessage.is_report": status, // Set the new value here
      });
      final resultuser = await FirebaseFirestore.instance.collection('users').doc(senderId);
      resultuser.collection("match").doc(receiverId).update({
        "is_report":status,
      });
      final resultusers = await FirebaseFirestore.instance.collection('users').doc(receiverId);
      resultusers.collection("match").doc(receiverId).update({
        "is_report":status,
      });
    } on FirebaseAuthException catch (e) {
    }*/
  }
  deleteAdmireStatus(String senderId, String receiverId) async {
    var collection = FirebaseFirestore.instance.collection('chat');
    var snapshots = await collection.get();
    for (var doc in snapshots.docs) {
      await doc.reference.delete();
    }
  }
  delelteUser(String senderId,
      String receiverId) async {
    var chatId=generateChatId(senderId.toString(),receiverId.toString());
    final collectionReference =
    FirebaseFirestore.instance.collection('chat');
    await collectionReference.doc(chatId).delete();
    final resultuser = await FirebaseFirestore.instance.collection('users').doc(senderId);
    resultuser.collection("match").doc(receiverId).delete();
    final resultusers = await FirebaseFirestore.instance.collection('users').doc(receiverId);
    resultusers.collection("match").doc(senderId).delete();
    var refrence=  await FirebaseFirestore.instance.collection('chat').doc(chatId);
    refrence.collection('messages').get().then((snapshot) {
      for (DocumentSnapshot doc in snapshot.docs) {
        doc.reference.delete();
      }});
  }
  deleteChat(String senderId, String receiverId) async{
/* var refrence=  await FirebaseFirestore.instance.collection('chat').doc(
      senderId.hashCode <= receiverId.hashCode
          ? '${senderId}_$receiverId'
          : '${receiverId}_$senderId');
 refrence.collection('messages').get().then((snapshot) {
     for (DocumentSnapshot doc in snapshot.docs) {
       doc.reference.delete();
     }});*/
    var chatId=generateChatId(senderId.toString(),receiverId.toString());
    final result =await FirebaseFirestore.instance.collection('chat').doc(chatId).collection("messages");
    result.get().then((value) {
      for(var data in value.docs){
        List deleteUser=[];
        deleteUser.addAll(data["delete_by"]);
        deleteUser.add(senderId);
        print("deleteUser===>"+data.id.toString());
        result.doc(data.id.toString()).update({
          "delete_by": deleteUser.toSet().toList()
        });
      }
    });

    /* result.doc().update({
       dd
     });*/
  }

  updateName(String name) async {
    var collection = FirebaseFirestore.instance.collection('chat');
    var snapshots = await collection.get();
    for (var doc in snapshots.docs) {
      if(doc.id.toString().contains(SessionManager.getString(Preferences.USER_ID))){
        if(doc.data()["sender_id"]==SessionManager.getString(Preferences.USER_ID)){
          await collection.doc(doc.id.toString()).update({
            "sender_name": name,
            "recentMessage.senderName": name,
          });
        }else{
          await collection.doc(doc.id.toString()).update({
            "receiver_name": name, // Set the new value here
          });
        }
      }
    }
    await updateNameFromUserTable(name);
  }

  updateNameFromUserTable(String name) async {
    var collection = FirebaseFirestore.instance.collection('users');
    var snapshots = await collection.get();
    for (var doc in snapshots.docs) {

      //match
      var collectionMatch =  collection.doc(doc.id.toString()).collection("match");
      collectionMatch.get().then((value) async {
        var snapshotMatch = await collectionMatch.get();
        for (var docMatch in snapshotMatch.docs) {
          print("docs--->"+docMatch.id.toString());
          if(docMatch.id.toString().contains(SessionManager.getString(Preferences.USER_ID))){
            await collectionMatch.doc(docMatch.id.toString()).update({
              "user_name": name, // Set the new value here
            });
          }
        }

      });
    }
  }

  updateImage(String imageUrl) async {
    var collection = FirebaseFirestore.instance.collection('chat');
    var snapshots = await collection.get();
    for (var doc in snapshots.docs) {
      if(doc.id.toString().contains(SessionManager.getString(Preferences.USER_ID))){
        if(doc.data()["sender_id"]==SessionManager.getString(Preferences.USER_ID)){
          await collection.doc(doc.id.toString()).update({
            "sender_image": imageUrl,
          });
        }else{
          await collection.doc(doc.id.toString()).update({
            "receiver_image": imageUrl,
          });
        }
      }
    }
    print("chat sender_image====>");
    await updateImageFromUserTable(imageUrl);
  }

  updateImageFromUserTable(String imageUrl) async {
    var collection = FirebaseFirestore.instance.collection('users');
    var snapshots = await collection.get();
    for (var doc in snapshots.docs) {
      var collectionMatch =  collection.doc(doc.id.toString()).collection("match");
      collectionMatch.get().then((value) async {
        var snapshotMatch = await collectionMatch.get();
        for (var docMatch in snapshotMatch.docs) {
          print("docMatch====>+"+docMatch.id.toString());
          print("imageUrl====>+"+imageUrl.toString());
          if(docMatch.id.toString().contains(SessionManager.getString(Preferences.USER_ID))){
            await collectionMatch.doc(docMatch.id.toString()).update({
              "user_image": imageUrl, // Set the new value here
            });
          }
        }
      });
      print("updateImageFromUserTable====>");
    }
  }
  Future<bool> sendFcmMessage(String receiverId,String receiverName) async {
    try {

      var url = 'https://fcm.googleapis.com/fcm/send';
      var header = {
        "Content-Type": "application/json",
        "Authorization": "key=AAAASN7iER4:APA91bGb1RdNOa0mdSaabWeGuIc5D5xIxvM6YVJWXbgy5h1weO5-ibPmjFCI-Rf69IDruTz0Vgpu8gsbTNL-2Ucy5cc_TY_BDUC2o6yGK7JtwaZEPrxNcR_ASsvtPoDW2KlmgKlbHPqI",
      };
      var message="";
      var title="";
      message= receiverName + " has sent you a message!";

      var request = {
        'notification': {'title': "LikePlay", 'body':message},
        'data': {
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          'type': 'COMMENT'
        },
        'to': '/topics/chatId_${receiverId}'
      };
      var client =  Client();
      var response = await client.post(Uri.parse(url), headers: header, body: json.encode(request));
      return true;
    } catch (e, s) {
      print(e);
      return false;
    }

  }

}


