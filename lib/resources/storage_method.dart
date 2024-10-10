import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageMethod {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> uploadImagetoStorage(String childName, Uint8List img, bool isPost) async {
    
    Reference ref =_storage.ref().child(childName).child(_auth.currentUser!.uid);

    if (isPost) {
      String postImgId = const Uuid().v1(); //* if it is post, we generate unique time-based id for post image to store and store it inside
      ref = ref.child(postImgId);         //* And store image at that referrence of a particular user at this uniquw post id
    }

    UploadTask uploadtask = ref.putData(img);   //? putting or uploading file at refferenced location
    //? putData function is specifically used for Uint8List file and can also contain metadata about image

    TaskSnapshot snap = await uploadtask;       //? Process and storing snapshot of upoloading image task to drawout Download URL
    String downloadUrl = await snap.ref.getDownloadURL();

    return downloadUrl;
  }
}
