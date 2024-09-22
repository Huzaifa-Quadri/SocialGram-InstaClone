import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/global_variables.dart';

class ReponsiveLayoutScreen extends StatefulWidget {
  final Widget webScreenLayout;
  final Widget appScreenLayout;

  const ReponsiveLayoutScreen({
      super.key,
      required this.webScreenLayout,
      required this.appScreenLayout,
    });

  @override
  State<ReponsiveLayoutScreen> createState() => _ReponsiveLayoutScreenState();
}

class _ReponsiveLayoutScreenState extends State<ReponsiveLayoutScreen> {
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
