import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:instagram_clone/providers/userprovider.dart';
import 'package:instagram_clone/utils/global_variables.dart';

class ResponsiveLayoutScreen extends StatefulWidget {
  final Widget webScreenLayout;
  final Widget appScreenLayout;

  const ResponsiveLayoutScreen({
      super.key,
      required this.webScreenLayout,
      required this.appScreenLayout,
    });

  @override
  State<ResponsiveLayoutScreen> createState() => _ResponsiveLayoutScreenState();
}

class _ResponsiveLayoutScreenState extends State<ResponsiveLayoutScreen> {

  @override
  void initState() {
    super.initState();
    addData();
  }

  void addData() async {
    UserProvider userprovider = Provider.of(context, listen: false);  //* Need to run refresh user somewhere for user gets updated unless if we print the value of user with userprovider we will get null value
      //? with listen : false it will get user value only once, without it, it will listen continuesly
    await userprovider.refreshUser();
  }
  
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {

        if (constraints.maxWidth > webScreenwidthSize) {
          return widget.webScreenLayout;
        }

        return widget.appScreenLayout;
      },
    );
  }
}
