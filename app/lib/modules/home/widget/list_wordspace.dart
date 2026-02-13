import 'package:app/models/wordspace_model.dart';
import 'package:app/modules/wordspace/wigdet/create_name_wordspace.dart';
import 'package:app/shared/storage/user_storage.dart';
import 'package:app/shared/storage/wordspace_storage.dart';
import 'package:flutter/material.dart';

class ListWordspace extends StatefulWidget {
  const ListWordspace({super.key});

  @override
  State<ListWordspace> createState() => _ListWordspaceState();
}

class _ListWordspaceState extends State<ListWordspace> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  WordspaceModel? wordspace;
  List<Credential> filterNote = [];

  final storage = Userstorage();
  final searchController = TextEditingController();
  bool isLoading = true;
  List<WordspaceModel> filterWordspaces = [];

  Future<void> loadData() async {
    wordspace = await WordspaceStorage().getUserSpaceData();
    setState(() {
      wordspace = wordspace;
      filterNote = wordspace?.credentials ?? [];
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Expanded(
          child: filterNote.isEmpty
              ? const Center(child: Text("Sin datos"))
              : ListView.builder(
                  itemCount: filterNote.length,
                  itemBuilder: (context, index) {
                    final c = filterNote[index];
                    return Card(
                      margin: const EdgeInsets.only(top: 12),
                      child: GestureDetector(
                        child: ListTile(title: Text(c.name)),
                        onTap: () => {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  const CreateNameWordspace(wordspaceId: 0),
                            ),
                          ),
                        },
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
