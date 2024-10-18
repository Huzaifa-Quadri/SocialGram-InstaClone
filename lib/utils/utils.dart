import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async {
  final ImagePicker imagepicker = ImagePicker();

  XFile? imgfile = await imagepicker.pickImage(source: source);

  if (imgfile == null) {
    print('IMAGE NOT SELECTED');
    return;
  }

  return await imgfile.readAsBytes();
  //! Using Uint8List method because going with normal -
  //? File(imgfile.path) as it is not compatible on web
}

showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
      // backgroundColor: color,
    ),
  );
}

void heartnotification(BuildContext context, bool isweb) {
  final double width = MediaQuery.of(context).size.width;

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Container(
        padding: const EdgeInsets.all(5),
        height: 60,
        width: isweb ? width * 0.45 : null,
        decoration: const BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: const Center(
            child: Text(
          "You're up to date! No new notifications",
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        )),
      ),
      duration: const Duration(milliseconds: 1600),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
  );
}

void showDMSnackbar(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Container(
        padding: const EdgeInsets.all(5),
        height: 60,
        decoration: const BoxDecoration(
            color: Color(0xFFFF6F61),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: const Center(
            child: Text(
          "Stay tuned! This feature is on its way. 🚀✨",
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        )),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      duration: const Duration(milliseconds: 1700),
      elevation: 0,
    ),
  );
}
