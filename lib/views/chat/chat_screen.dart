import 'package:architect_app/models/firestore.dart';
import 'package:architect_app/models/preferences/auth_preference.dart';
import 'package:architect_app/models/responses/login_response.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String chatRoomId;
  final String username;

  ChatScreen(this.chatRoomId, this.username);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _isSubmitted = false;
  User _user;
  AuthPreference _authPreference = AuthPreference();
  Stream _chatMessageStream;
  Firestore _firestore = Firestore();
  final _messageForm = TextEditingController();

  Widget _chatMessageList() {
    return StreamBuilder(
        stream: _chatMessageStream,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    return MessageTile(snapshot.data.docs[index]["message"],
                        snapshot.data.docs[index]["sendBy"] == _user.username);
                  })
              : Container();
        });
  }

  _sendMessage() {
    if (_messageForm.text.isNotEmpty) {
      Map<String, dynamic> messageMap = {
        "message": _messageForm.text,
        "sendBy": _user.username,
        "time": DateTime.now().millisecondsSinceEpoch
      };

      List<String> users = [_user.username, widget.username];
      Map<String, dynamic> chatRoomMap = {
        "users": users,
        "chatRoomId": widget.chatRoomId
      };

      _firestore.createChatRoom(widget.chatRoomId, chatRoomMap);
      _firestore.addConversationMessage(widget.chatRoomId, messageMap);
      _messageForm.text = "";
    }
  }

  _initialize() async {
    var user = await _authPreference.getUserData();
    setState(() {
      _user = user;
    });
  }

  @override
  void initState() {
    _initialize();
    _firestore.getConversationMessages(widget.chatRoomId).then((value) {
      setState(() {
        _chatMessageStream = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            // CircleAvatar(
            //     backgroundImage:
            //         NetworkImage("https://source.unsplash.com/V8j3F6Ik9_s")),
            Container(
              // padding: EdgeInsets.only(top: 6, left: 8, right: 8, bottom: 8),
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Center(
                child: Text(
                  widget.username.substring(0, 1),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.amber,
                    // fontSize: 16,
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                widget.username,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                maxLines: 1,
              ),
            )
          ],
        ),
        backgroundColor: Colors.amber[300],
      ),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 60),
            child: _chatMessageList(),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        color: Colors.amber.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(40)),
                    child: TextField(
                      controller: _messageForm,
                      onChanged: (value) {
                        setState(() {
                          _isSubmitted = true;
                        });
                      },
                      // onSubmitted: (value) {},
                      decoration: InputDecoration(
                          hintText: "Type message", border: InputBorder.none),
                    ),
                  ),
                ),
                _isSubmitted
                    ? GestureDetector(
                        onTap: () {
                          _sendMessage();
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.amber.withOpacity(0.05),
                          ),
                          child: Icon(Icons.send),
                        ),
                      )
                    : SizedBox()
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool isSendByMe;

  MessageTile(this.message, this.isSendByMe);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment:
            isSendByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7),
            decoration: BoxDecoration(
                color:
                    isSendByMe ? Colors.amber : Colors.amber.withOpacity(0.2),
                borderRadius: BorderRadius.circular(30)),
            child: Text(
              message,
              style: TextStyle(color: isSendByMe ? Colors.white : Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
