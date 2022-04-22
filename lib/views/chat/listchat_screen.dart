import 'package:architect_app/constants/theme.dart';
import 'package:architect_app/models/firestore.dart';
import 'package:architect_app/models/preferences/auth_preference.dart';
import 'package:architect_app/models/responses/login_response.dart';
import 'package:architect_app/views/chat/chat_screen.dart';
import 'package:flutter/material.dart';

class ListChatScreen extends StatefulWidget {
  @override
  _ListChatScreenState createState() => _ListChatScreenState();
}

class _ListChatScreenState extends State<ListChatScreen> {
  Firestore _firestore = Firestore();
  Stream _chatRoomStream;
  User _user;
  AuthPreference _authPreference = AuthPreference();

  _chatRoomList() {
    return StreamBuilder(
        stream: _chatRoomStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.docs.length > 0) {
              return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ChatRoomsTile(
                      username: snapshot.data.docs[index]['chatRoomId']
                          .toString()
                          .replaceAll("_", "")
                          .replaceAll(_user.username, ""),
                      chatRoomId: snapshot.data.docs[index]["chatRoomId"],
                    );
                  });
            } else {
              return Center(child: Text("Tidak ada pesan"));
            }
          } else {
            return Center(child: loadingIndicator);
          }
        });
  }

  _getUserInfo() async {
    _firestore.getChatRooms(_user.username).then((value) {
      setState(() {
        _chatRoomStream = value;
      });
    });
  }

  _initialize() async {
    var user = await _authPreference.getUserData();
    setState(() {
      _user = user;
      _getUserInfo();
    });
  }

  @override
  void initState() {
    _initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pesan",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        backgroundColor: Colors.amber[300]
        
      ),
      body: SafeArea(
        child: Container(margin: EdgeInsets.all(8), child: _chatRoomList()),
      ),
    );
  }
}

class ChatRoomsTile extends StatelessWidget {
  final String username;
  final String chatRoomId;

  ChatRoomsTile({this.username, this.chatRoomId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatScreen(chatRoomId, username)));
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20, top: 20, left: 20, right: 20),
          child: Row(
            children: [
              Container(
                // padding: EdgeInsets.only(top: 6, left: 8, right: 8, bottom: 8),
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.amber,
                ),
                child: Center(
                  child: Text(
                    username.substring(0, 1),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      // fontSize: 16,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      username,
                      style: blackFontStyle2.copyWith(fontSize: 16),
                    ),
                    // Text(
                    //   chat,
                    //   style: blackFontStyle1.copyWith(fontSize: 12),
                    //   maxLines: 1,
                    //   overflow: TextOverflow.ellipsis,
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
