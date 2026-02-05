import 'package:app/modules/authenticate/login/widget/login_pin_form.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: const LoginPinForm()),
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [const LoginPinForm(), ResetPassword()], //resetpassword()

            
        //   ),
        // ),
      ),
    );
  }
}
