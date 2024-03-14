import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoDataUi extends StatelessWidget {
  const NoDataUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/no_data_animation.json'),
          const SizedBox(height: 10),
          const Text("No task available."),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
