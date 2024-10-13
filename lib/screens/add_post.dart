import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/models/user.dart' as custommodel;

import 'package:instagram_clone/utils/theme_layout.dart';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:instagram_clone/providers/userprovider.dart';
import 'package:instagram_clone/resources/firestore_methods.dart';
import 'package:instagram_clone/utils/utils.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final TextEditingController descriptioncontroller = TextEditingController();
  Uint8List? _img;
  final FirebaseAuth _singoutauth = FirebaseAuth.instance;
  bool _isLoading = false;

  void uploadPost(String uid, String username, String desc, String profImg) async{
    setState(() {
      _isLoading = true;
    });
    try {
      String res  =  await FireStoreMethods().uploadPost(uid, username, desc, _img!, profImg);
      print("||||||| Post Uploaded ||||||||||");
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        if (res == 'success') {
        showSnackBar(context, 'Posted!');
        }else{
        showSnackBar(context, res.toString());
        }
      }
      
    } catch (er) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        showSnackBar(context, er.toString());
      }
    }
  }

  void getImage() async {
    return showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Create a Post'),
        children: [
          SimpleDialogOption(
            padding: const EdgeInsets.all(20),
            child: const Text('Take a Photo'),
            onPressed: () async {
              Navigator.of(context).pop();
              Uint8List file = await pickImage(ImageSource.camera);
              setState(() {
                _img = file;
              });
            },
          ),
          SimpleDialogOption(
            padding: const EdgeInsets.all(20),
            child: const Text('Pick Image from gallery'),
            onPressed: () async {
              Navigator.of(context).pop();
              Uint8List file = await pickImage(ImageSource.gallery);
              setState(() {
                _img = file;
              });
            },
          ),
          SimpleDialogOption(
            padding: const EdgeInsets.all(20),
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    descriptioncontroller.dispose();
  }

  void exit(){
    setState(() {
      _img = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Handling the User model with proper null safety
    custommodel.User? user = Provider.of<UserProvider>(context).getUser;
    
    // Adding null check and placeholder handling
    if (user == null) {
      return const Center(child: CircularProgressIndicator());
    }

    print("Just checking values for -------------------------------------------------------------------------------------:");
    print(user.uid);
    print(user.username);
    print(user.photoUrl);
    print(user.bio);
    print("Checking Values Doneeeee--------------------------------------------------------------------------------------:");
    
    if (_img == null) {
      return Scaffold(
          backgroundColor: mobileBackgroundColor,
          body: InkWell(
            onTap: getImage,
            child: Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                width: double.infinity,
                child: const Center(
                  child: Icon(Icons.upload),
                ),
              ),
            ),
          )
        );
    }

    return Scaffold(
      backgroundColor: mobileBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
            onPressed: exit,
            icon: const Icon(Icons.arrow_back)),
        title: const Text(
          "Post To",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () {
              uploadPost(user.uid, user.username, descriptioncontroller.text, user.photoUrl);
            },
            child: const Text("Post",
                style: TextStyle(color: Colors.blueAccent, fontSize: 16)),
          )
        ],
      ),
      body: Column(
        children: [
          _isLoading ? const LinearProgressIndicator() : const Padding(padding: EdgeInsets.only(top: 0)),
          const Gap(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(user.photoUrl),
              ),
              SizedBox(
                height: 100,
                width: MediaQuery.of(context).size.width * 0.4,
                child: TextField(
                  controller: descriptioncontroller,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Write a caption ...',
                    ),
                  maxLines: 10,
                ),
              ),
              SizedBox(
                height: 45,
                width: 45,
                child: AspectRatio(
                    aspectRatio: 487 / 481,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: MemoryImage(_img!),
                            fit: BoxFit.fill,
                            alignment: FractionalOffset.topCenter,
                          ),
                      ),
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
