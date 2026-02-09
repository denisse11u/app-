import 'package:app/modules/authenticate/login/widget/login_pin_form.dart';
import 'package:app/shared/storage/user_storage.dart';
import 'package:flutter/material.dart';
import 'package:app/modules/authenticate/login/page/login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  double _opacity = 0.0;
  final storage = Userstorage();

  @override
  void initState() {
    super.initState();

    Future<void> _existUser() async {
      // final savePin = await storage.getPin();

      final hasPin = await storage.hasPin();

      if (!mounted) return;

      if (hasPin) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginPage()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginPinForm(islogin: false)),
        );
      }

      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (_) => const HomePage()),
      // );
    }

    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() => _opacity = 1.0);
      _existUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: AnimatedOpacity(
          opacity: _opacity,
          duration: const Duration(seconds: 1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.lock, size: 100, color: Colors.white),
              SizedBox(height: 20),
              CircularProgressIndicator(color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
