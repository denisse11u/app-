import 'package:app/modules/authenticate/login/page/login_page.dart';
import 'package:app/modules/home/widget/create_data.dart';
import 'package:app/modules/wordspace/wigdet/create_wordspace.dart';
import 'package:app/shared/storage/user_storage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final storage = Userstorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Baúl de Conexiones'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.logout_outlined),

          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const LoginPage()),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CreateWordspace()),
              );
            },
            icon: Icon(Icons.add_circle_outline_sharp),
          ),
        ],
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
