
import 'package:flutter/material.dart';

class TopInfo extends StatelessWidget {
  const TopInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text(
          'Welcome Back! Chief',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Spacer(),
        CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage('assets/images/profile.png'),
        ),
      ],
    );
  }
}
