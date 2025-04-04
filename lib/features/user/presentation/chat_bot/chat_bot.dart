// ignore_for_file: deprecated_member_use

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:graduation_project/core/utils/app_colors.dart';
import 'package:graduation_project/features/user/presentation/chat_bot/messege.dart';

class ChatBot extends StatefulWidget {
  const ChatBot({super.key});

  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  List messeges = [];
  TextEditingController controller = TextEditingController();
  add() {
    if (controller.text.isNotEmpty) {
      setState(() {
        messeges.add({
          "text": controller.text,
          "sender": true,
        });
      });
      Gemini gemini = Gemini.instance;
      gemini.text(controller.text).then(
        (value) {
          value?.output;
          setState(() {
            messeges.add({
              "text": value?.output,
              "sender": false,
            });
          });
        },
      );
    }
    setState(() {
      controller.text = '';
    });
  }

  @override
  void initState() {
    Gemini.init(apiKey: "AIzaSyAOGeTLsdlqVwaQGTubWl38BfdfZMgT-1c");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Help Assistant',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 18,
              ),
        ),
        iconTheme: Theme.of(context).iconTheme,
      ),
      body: Column(
        children: [
          DottedLine(
            lineLength: double.infinity,
            lineThickness: 1.0,
            dashLength: 5.0,
            dashColor: AppColors.dividerColor,
            dashRadius: 0.0,
            dashGapLength: 5.0,
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Messege(
                    sender: messeges[index]['sender'],
                    text: messeges[index]['text']);
              },
              itemCount: messeges.length,
            ),
          )),
          Container(
            height: 80,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                )),
            child: Row(
              children: [
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: TextField(
                    controller: controller,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(8),
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          add();
                        },
                        icon: Icon(
                          Icons.send,
                          color: AppColors.blue,
                        ),
                      ),
                      hintText: "Write your message",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
