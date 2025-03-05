import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../configs/app_colors.dart';
import '../configs/constants_widget.dart';
import 'dialog_event.dart';
import 'extensions.dart';

class DialogWidget extends StatelessWidget {
  final DialogEvent event;

  const DialogWidget({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        constraints: const BoxConstraints.tightFor(width: 400),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Visibility(
              visible: event.title != null,
              child: Text(
                event.title ?? '',
                style: GoogleFonts.inter(
                  color: AppColors.primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.start,
                maxLines: 3,
              ),
            ),
            Visibility(
              visible: event.title != null && event.content != null,
              child: height12,
            ),
            Visibility(
              visible: event.content != null,
              child: Text(
                event.content ?? '',
                style: GoogleFonts.inter(
                  color: AppColors.primaryColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 5,
              ),
            ),
            height24,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: _buildActions(context),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> _buildActions(BuildContext context) {
    final result = <Widget>[];
    event.actions.forEachIndexed((index, element) {
      if (index != 0) {
        result.add(width12);
      }
      result.add(element.toWidget(context));
    });
    return result;
  }
}
