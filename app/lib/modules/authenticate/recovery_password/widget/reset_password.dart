// import 'package:app/modules/login/page/forgot_password.dart';
// import 'package:flutter/material.dart';

// class ResetPassword extends StatefulWidget {
//   const ResetPassword({super.key});

//   @override
//   State<ResetPassword> createState() => _ResetPasswordState();

// }

// class _ResetPasswordState extends State<ResetPassword> {
//   GlobalKey<FormState> keyForm = GlobalKey();

//   @override
//   Widget build(BuildContext context) {

//     return Scaffold(

//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(8.0),
//         child: Form(
//             key: keyForm,
//               child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,

//                 children: [
//                   Icon(
//                     Icons.arrow_back
//                   ),

//                             const SizedBox(height: 30),
//                TextFormField(
//                 decoration: const InputDecoration(
//                   hintText: 'Ingresar la palabra de seguridad',
//                   prefixIcon: Icon(Icons.lock),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Campo no debe estar vacío';
//                   }
//                   return null;
//                 },
//               ),
//                                const SizedBox(height: 20),
//                  ElevatedButton(
//                     onPressed: () {
//                       if(keyForm.currentState!.validate() );
//                     },
//                     child: const Text('Submit'),
//                   ),

//                                 const SizedBox(height: 20),
//                          TextButton(
//                 onPressed: () {
//                   Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => const ForgotPassword(),
//                     ),
//                   );
//                 },
//                 child: const Text('¿Olvidaste tu contraseña?'),
//               ),
//                 ]

//                     ),

//                 //     Navigator.pushReplacement(
//                 //   context,
//                 //   MaterialPageRoute(builder: (_) => const ForgotPassword()));
//                 //       }, child: Text ( '¿Olvidaste tu contraseña?')),

//                 // ],
//               ),
//           )

//     ); }
// }

//  // Padding(
//             //   padding: const EdgeInsets.symmetric(vertical: 5),
//             //   child: Column(
//             //     crossAxisAlignment: CrossAxisAlignment.start,
//             //     children: [
//             //       TextFormField(
//             //         decoration: InputDecoration(hintText: 'Ingresar la palabra de seguridad'),
//             //         validator: (String? value) {
//             //   if (value == null || value.isEmpty) {
//             //     return 'Campo no debe estar vacío';
//             //   }
//             //   return null;
//             // },
//             //       ),

//             //       Padding(padding:

//             //       const EdgeInsetsGeometry.symmetric(vertical: 20),
//             //       child: ElevatedButton(
//             //   onPressed: () {
//             //     if(keyForm.currentState!.validate() );
//             //   },
//             //   child: const Text('Submit'),
//             // ),

//             //       )
//             //     ],

//             //   ),
//             // ),

//                 // validator: (value) {
//                 //   if (value == null || value.trim().isEmpty) {
//                 //     return 'El campo no puede estar vacio';
//                 //   }
//                 //   return null;
//                 // },
//                 //   ),
//                 // ],

import 'package:app/modules/authenticate/login/page/login_page.dart';
import 'package:app/modules/authenticate/login/widget/login_pin_form.dart';
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
                        GlobalHelper.showError(
                          context,
                          'No hay palabra registrada',
                        );
                        return;
                      }

                      if (controller.text.trim() == savedWord) {
                        await storage.deletePin();

                        if (!mounted) return;
                        GlobalHelper.showSuccess(
                          context,
                          'Palabra correcta, crea un nuevo PIN',
                        );

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const LoginPinForm(),
                          ),
                        );
                      } else {
                        if (!mounted) return;
                        GlobalHelper.showError(context, 'Palabra incorrecta');
                      }
                    },

                    child: const Text('Guardar'),
                  ),

                  //   FilledButton(text: 'Iniciar Sesión', onPressed: (){
                  //     if (keyForm.currentState!.validate()) {
                  //         _tryLogin();
                  //       }
                  // },)
                  // ElevatedButton(
                  //   onPressed: () {
                  //     if (keyForm.currentState!.validate()) {
                  //       return GlobalHelper.showSuccess(context, 'guardado exitosamente');
                  //     }
                  //   },
                  //   child: const Text('Submit'),
                  // ),
                  const SizedBox(height: 20),

                  // TextButton(
                  //   onPressed: () {
                  //     Navigator.pushReplacement(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (_) => const ForgotPassword(),
                  //       ),
                  //     );
                  //   },
                  //   child: const Text('¿Olvidaste tu contraseña?'),
                  // ),
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
    _wordExist();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
