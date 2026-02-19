import 'package:app/modules/authenticate/recovery_password/widget/reset_password.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recuperar contraseña')),
      body: const SafeArea(child: ResetPassword()),
    );
  }
}
