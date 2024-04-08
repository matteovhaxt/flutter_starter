import 'package:flutter/material.dart';

extension GoTo on PageController {
  void goToNextPage() {
    nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void goToPreviousPage() {
    previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}
