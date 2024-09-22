import 'package:flutter/material.dart';
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
