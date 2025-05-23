import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BackToHome extends StatefulWidget {
  const BackToHome({super.key});

  @override
  State<BackToHome> createState() => _BackToHomeState();
}

class _BackToHomeState extends State<BackToHome> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () => context.go('/doctor_queue'),
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: const Color.fromARGB(255, 108, 117, 125),
      ),
      child: Text(
        'Back To Home',
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
    );
  }
}
