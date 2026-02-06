import 'package:app/modules/authenticate/recovery_password/widget/reset_password.dart';
import 'package:flutter/material.dart';

class WordSecurityPage extends StatelessWidget {
  const WordSecurityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ingrese la palabra de seguridad'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const ResetPassword()),
            );
          },
        ),
      ),
    );
  }
}
