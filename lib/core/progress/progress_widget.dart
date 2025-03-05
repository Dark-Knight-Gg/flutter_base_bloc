import 'package:flutter/material.dart';

class ProgressWidget extends StatelessWidget {
  final bool dismissible;

  const ProgressWidget({super.key, required this.dismissible});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => dismissible,
      child: Container(
        alignment: Alignment.center,
        child: const CircularProgressIndicator(),
      ),
    );
  }
}
