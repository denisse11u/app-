import 'package:flutter/material.dart';

class CreateData extends StatelessWidget {
  const CreateData({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("nuevo texto")),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(decoration: InputDecoration(hintText: "Asunto")),
            SizedBox(height: 24),
            TextField(
              maxLines: 10,
              decoration: InputDecoration(hintText: "descripcion"),
            ),
            FloatingActionButton(onPressed: () => context),
            Icon(Icons.abc_outlined),
          ],
        ),
      ),
    );
  }
}
