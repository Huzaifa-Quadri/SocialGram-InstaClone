import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageMethod {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> uploadImagetoStorage(String childName, Uint8List img, bool isPost) async {
    
    Reference ref =_storage.ref().child(childName).child(_auth.currentUser!.uid);

    UploadTask uploadtask = ref.putData(img);   //? putting or uploading file at refferenced location

    TaskSnapshot snap = await uploadtask;       //? Process and storing snapshot of upoloading image task to drawout Download URL
    String downloadUrl = await snap.ref.getDownloadURL();

    return downloadUrl;
  }
}
