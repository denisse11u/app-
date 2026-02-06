import 'package:app/modules/authenticate/login/page/login_page.dart';
import 'package:app/modules/home/widget/create_data.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Datos creados'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),

          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const LoginPage()),
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => CreateData()),
          );
        },
        child: Icon(Icons.add),
      ),

      // body: Padding(
      //   padding: const EdgeInsets.all(20),
      //   child: Column(
      //     children: [
      //       TextField(decoration: const InputDecoration(hintText: "Título")),

      //       const SizedBox(height: 20),

      //       TextField(
      //         maxLines: 5,
      //         decoration: const InputDecoration(hintText: "Contenido"),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
