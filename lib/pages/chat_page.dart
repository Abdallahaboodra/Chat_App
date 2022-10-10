import 'package:chat_app/constant.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/chat_buble.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});
  static String id = 'Chat Page';

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  String? textData;
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessageCollection);
  final ScrollController controllerScroll = ScrollController();

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var emali = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy(kcreatedAt, descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Message> messageList = [];
            for (var i = 0; i < snapshot.data!.docs.length; i++) {
              messageList.add(Message.fromJson(snapshot.data!.docs[i]));
            }
            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: kPrimaryColor,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/scholar.png',
                      height: 50,
                    ),
                    const Text('Chat'),
                  ],
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      controller: controllerScroll,
                      itemCount: messageList.length,
                      itemBuilder: ((context, index) {
                        return messageList[index].id == emali
                            ? ChatBuble(
                                message: messageList[index],
                              )
                            : ChatBubleForFriend(message: messageList[index]);
                      }),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: TextField(
                      controller: controller,
                      onChanged: (value) {
                        textData = value;
                      },
                      onSubmitted: ((value) {
                        messages.add(
                          {
                            kmessage: value,
                            kcreatedAt: DateTime.now(),
                            'id': emali
                          },
                        );
                        controller.clear();
                        controllerScroll.animateTo(0,
                            duration: const Duration(
                              seconds: 2,
                            ),
                            curve: Curves.fastOutSlowIn);
                      }),
                      decoration: InputDecoration(
                        hintText: 'Send Message',
                        suffixIcon: IconButton(
                          onPressed: () {
                            controller.clear();
                            messages.add({
                              kmessage: textData,
                              kcreatedAt: DateTime.now(),
                              'id': emali
                            });
                          },
                          icon: const Icon(Icons.send),
                          color: kPrimaryColor,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            16,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(color: kPrimaryColor),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Text('is Lodaing...');
          }
        });
  }
}
