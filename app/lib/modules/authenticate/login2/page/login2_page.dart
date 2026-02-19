import 'package:app/modules/authenticate/login2/widget/login.dart';
import 'package:flutter/material.dart';

class Login2Page extends StatefulWidget {
  const Login2Page({super.key});

  @override
  State<Login2Page> createState() => _Login2PageState();
}

class _Login2PageState extends State<Login2Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('inicio de sesion'), centerTitle: true),
      body: SafeArea(
        child: Padding(padding: EdgeInsets.all(20), child: Login()),
      ),
    );
  }
}
