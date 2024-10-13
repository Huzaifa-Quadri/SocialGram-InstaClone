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
  bool _isLoadingData = true;
  @override
  void initState() {
    super.initState();
    addData();
  }

  //? Fetch the user data from the provider asynchronously
  void addData() async {
    UserProvider userProvider = Provider.of<UserProvider>(context,
        listen:
            false); //? with listen : false it will get user value only once, without it, it will listen continuesly

    await userProvider.refreshUser(); //? Wait for refreshUser to complete, need to run it atleast once
    setState(() {
      _isLoadingData = false; // Set loading flag to false once data is fetched
    });
  }

  @override
  Widget build(BuildContext context) {
    // Display a loading indicator until user data is fetched
    if (_isLoadingData) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    //* Once data is fetched, use LayoutBuilder for responsive design
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
