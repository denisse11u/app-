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
import 'package:app/shared/helpers/global_helper.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  String firstWord = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () =>  Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const LoginPage(),
                        ),
                  )

                ),),
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
FilledButton.tonal(onPressed: () {
  if (keyForm.currentState!.validate()) {
                        return GlobalHelper.showSuccess(context, 'guardado exitosamente');
                        
                      }
}, child: const Text('Enabled')),


                  
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
}


// Future<void> createWord(String value) async {
   

//     if (mode == PinMode.confirm) {
//       if (value == firstPin) {
//         await storage.savePin(value);
//         GlobalHelper.showSuccess(context, "pin creado");
//           // Navigator.pushReplacement(
//           //           context,
//           //           MaterialPageRoute(builder: (_) => const ResetPassword()),
//           //         );

//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (_) => const HomePage()),
//         );
//       } 
//       else {
//         GlobalHelper.showError(context, "no coincide con el pin creado");
//         controller.clear();
//         setState(() => mode = PinMode.create);
//       }
//       return;
//     }

//     if (mode == PinMode.enter) {
//       final savePin = await storage.getPin();

//       if (value == savePin) {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (_) => const HomePage()),
//         );
//       } else {
//         GlobalHelper.showError(context, "PIN incorrecto");
//         controller.clear();
//       }
//     }
//   }