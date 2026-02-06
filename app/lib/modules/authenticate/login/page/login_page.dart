import 'package:app/modules/authenticate/login/widget/login_pin_form.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final titulocrear = Provider.of<UserProvider>(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginPinForm()),
                );
              },
              child: Text('Crear Pin'),
              // SafeArea(

              //   child: Center(

              //     child: const LoginPinForm()),
              //   //   child: Column(
              //   //     mainAxisAlignment: MainAxisAlignment.center,
              //   //     children: [const LoginPinForm(), ResetPassword()], //resetpassword()

              //   //   ),
              //   // ),
            ),
          ],
        ),
      ),
    );
  }
}
