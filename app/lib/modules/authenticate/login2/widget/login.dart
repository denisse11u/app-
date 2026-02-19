import 'package:app/modules/home/page/home_page.dart';
import 'package:app/shared/widget/text_form_field.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;

  void _validateForm() async {
    if (!_formkey.currentState!.validate()) return;

    setState(() {
      isLoading = true;
    });

    await Future.delayed(Duration(seconds: 2));

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          customTextFormField(
            decoration: InputDecoration(border: OutlineInputBorder()),
            obscureText: false,
            controller: emailController,
            hintText: 'correo',
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Campo obligatorio";
              }
              return null;
            },
          ),
          SizedBox(height: 34),
          customTextFormField(
            decoration: InputDecoration(border: OutlineInputBorder()),
            controller: passwordController,
            obscureText: true,
            hintText: 'contraseña',
            validator: (value) {
              if (value == null || value.length < 6) {
                return "Campo obligatorio";
              }
              return null;
            },
          ),
          SizedBox(height: 34),

          isLoading
              ? const CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const HomePage()),
                    );
                  },
                  child: Text('Ingresar'),
                ),
        ],
      ),
    );
  }
}
