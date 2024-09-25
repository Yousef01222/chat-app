import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scholar_chat/models/message.dart';
import 'package:scholar_chat/view/login_page.dart';
import 'package:scholar_chat/widget/chat_buble.dart';
import 'package:scholar_chat/widget/constant.dart';
import 'package:scholar_chat/widget/custom_text_filed.dart';

// ignore: must_be_immutable
class ChatPages extends StatefulWidget {
  static String id = 'ChatPages';
  String? name;
  dynamic image;

  ChatPages({
    super.key,
    this.name,
    this.image,
  });

  @override
  State<ChatPages> createState() => _ChatPagesState();
}

class _ChatPagesState extends State<ChatPages> {
  final CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollection);
  final TextEditingController controller = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ImagePicker _imagePicker = ImagePicker();

  File? _image;

  Future<void> _pickImages() async {
    final pickedFile = await _imagePicker.pickImage(
      source: ImageSource.gallery, // or ImageSource.camera
      imageQuality: 100,
    );

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });

      // Upload the image to Firebase Storage
      String imageUrl = await uploadImage(_image!);

      // Send the image URL to Firestore
      messages.add({
        kMessage: imageUrl, // Text message can be empty
        kCreatedAt: DateTime.now(),
        'id': _auth.currentUser?.email,
        'message_time': DateTime.now().toString(),
      });

      // Clear the selected image
      setState(() {
        _image = null;
      });
    }
  }

  Future<String> uploadImage(File image) async {
    // Create a unique file name
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference ref =
        FirebaseStorage.instance.ref().child('chat_images/$fileName');

    // Upload the file to Firebase Storage
    await ref.putFile(image);

    // Get the download URL
    String downloadUrl = await ref.getDownloadURL();
    return downloadUrl;
  }

  @override
  Widget build(BuildContext context) {
    var email = _auth.currentUser?.email;

    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(kCreatedAt, descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(child: Text("Error loading messages"));
        }

        if (snapshot.hasData) {
          // List<Message> messageList =
          //     snapshot.data!.docs.map((doc) => Message.formJson(doc)).toList();
          List<Message> messageList = snapshot.data!.docs.map((doc) {
            return Message.formJson(doc.data() as Map<String, dynamic>);
          }).toList();

          return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: () async {
                    await messages.get().then((value) {
                      for (var doc in value.docs) {
                        doc.reference.delete();
                      }
                    });
                  },
                  icon: const Icon(Icons.delete, size: 28),
                ),
                IconButton(
                  onPressed: () {
                    _auth.signOut();
                    Navigator.pushReplacementNamed(context, LoginPage.id);
                  },
                  icon: const Icon(Icons.logout, size: 28),
                ),
              ],
              automaticallyImplyLeading: false,
              backgroundColor: Colors.teal,
              foregroundColor: Colors.white,
              title: Row(children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 5),
                  child: GestureDetector(
                    child: CircleAvatar(
                      radius: 25,
                      backgroundImage: widget.image is String
                          ? NetworkImage(widget.image as String)
                          : widget.image is File
                              ? FileImage(widget.image as File)
                              : const AssetImage('assets/images/images.jpeg')
                                  as ImageProvider,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Text(widget.name.toString()),
              ]),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: scrollController,
                    itemCount: messageList.length,
                    itemBuilder: (context, index) {
                      return messageList[index].id == email
                          ? ChatBuble(message: messageList[index])
                          : ChatBubleForFrind(message: messageList[index]);
                    },
                  ),
                ),
                CustomTextFiled(
                  onPressed: _pickImages,
                  email: email ?? '',
                  controller: controller,
                  onSubmitted: (data) {
                    messages.add({
                      kMessage: data,
                      kCreatedAt: DateTime.now(),
                      'id': email,
                      'message_time': DateTime.now().toString(),
                    });
                    controller.clear();
                    scrollController.animateTo(
                      0,
                      curve: Curves.easeOut,
                      duration: const Duration(milliseconds: 500),
                    );
                  },
                ),
              ],
            ),
          );
        } else {
          return const Center(child: Text('No messages found.'));
        }
      },
    );
  }
}
