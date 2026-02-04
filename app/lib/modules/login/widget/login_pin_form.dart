import 'package:app/modules/home/page/home_page.dart';
import 'package:app/shared/helpers/global_helper.dart';
import 'package:app/shared/storage/user_storage.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

enum PinMode { create, confirm, enter }

class LoginPinForm extends StatefulWidget {
  const LoginPinForm({super.key});

  @override
  State<LoginPinForm> createState() => _LoginPinFormState();
}

class _LoginPinFormState extends State<LoginPinForm> {
  final storage = Userstorage();
  PinMode mode = PinMode.enter;
  final controller = TextEditingController();
  String firstPin = "";

  @override
  void initState() {
    super.initState();
    // storage.deletePin();

    _pinExist();
  }

  Future<void> _pinExist() async {
    final hasPin = await storage.hasPin();
    setState(() {
      mode = hasPin ? PinMode.enter : PinMode.create;
    });
  }

  Future<void> createPin(String value) async {
    if (mode == PinMode.create) {
      firstPin = value;
      controller.clear();
      setState(() => mode = PinMode.confirm);
      return;
    }

    if (mode == PinMode.confirm) {
      if (value == firstPin) {
        await storage.savePin(value);
        GlobalHelper.showSuccess(context, "pin creado");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomePage()),
        );
      } else {
        GlobalHelper.showError(context, "no coincide con el pin creado");
        controller.clear();
        setState(() => mode = PinMode.create);
      }
      return;
    }

    if (mode == PinMode.enter) {
      final savePin = await storage.getPin();

      if (value == savePin) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomePage()),
        );
      } else {
        GlobalHelper.showError(context, "PIN incorrecto");
        controller.clear();
      }
    }
  }

  String get title {
    switch (mode) {
      case PinMode.create:
        return "Crea tu PIN";
      case PinMode.confirm:
        return "Confirma tu PIN";
      case PinMode.enter:
        return "Ingresa tu PIN";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.lock, size: 60, color: Colors.blue),
        const SizedBox(height: 20),
        Text(
          title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 40),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: PinCodeTextField(
            controller: controller,
            appContext: context,
            length: 4,
            obscureText: true,
            keyboardType: TextInputType.number,
            animationType: AnimationType.fade,

            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(10),
              fieldHeight: 60,
              fieldWidth: 60,
              selectedColor: Colors.blue,
              inactiveColor: Colors.grey,
            ),

            onCompleted: createPin,
          ),
        ),
      ],
    );
  }
}
