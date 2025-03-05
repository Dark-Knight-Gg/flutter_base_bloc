import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../configs/app_colors.dart';
import 'dialog_event.dart';

extension DialogActionExt on DialogAction {
  Widget toWidget(BuildContext context) {
    switch (type) {
      case DialogActionType.positive:
        return _buildPositiveAction(context);
      case DialogActionType.negative:
        return _buildNegativeAction(context);
    }
  }

  Widget _buildPositiveAction(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).pop();
        onTap?.call();
      },
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(80, 32),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        backgroundColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildNegativeAction(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        Navigator.of(context).pop();
        onTap?.call();
      },
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(80, 32),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        side: const BorderSide(color: AppColors.primaryColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.primaryColor,
        ),
      ),
    );
  }
}
