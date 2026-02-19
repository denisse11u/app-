import 'package:app/modules/authenticate/login/page/login_page.dart';
import 'package:app/modules/authenticate/login/widget/login_pin_form.dart';
import 'package:app/modules/home/page/home_page.dart';
import 'package:app/shared/helpers/global_helper.dart';
import 'package:flutter/material.dart';
import 'package:app/shared/storage/user_storage.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  final storage = Userstorage();
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const LoginPage()),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: keyForm,
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 30),

                  TextFormField(
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: 'Ingresar la palabra de seguridad',
                      prefixIcon: Icon(Icons.lock),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo no debe estar vacío';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),
                  FilledButton.tonal(
                    onPressed: () async {
                      if (!keyForm.currentState!.validate()) return;

                      final savedWord = await storage.getWord();

                      if (savedWord == null) {
                        if (!mounted) return;
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const HomePage()),
                        );
                        return;
                      }

                      if (controller.text.trim() == savedWord) {
                        await storage.deletePin();

                        if (!mounted) return;

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const LoginPinForm(islogin: false),
                          ),
                        );
                      } else {
                        if (!mounted) return;
                        GlobalHelper.showError(context, 'Palabra incorrecta');
                      }
                    },

                    child: const Text('Guardar'),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _wordExist() async {
    final word = await storage.getWord();
    if (word != null) {
      setState(() {
        controller.text = word;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    //_wordExist();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
