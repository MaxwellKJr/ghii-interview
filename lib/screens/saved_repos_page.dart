import 'package:flutter/material.dart';

class SavedReposPage extends StatefulWidget {
  const SavedReposPage({super.key});

  @override
  State<SavedReposPage> createState() => _SavedReposPageState();
}

class _SavedReposPageState extends State<SavedReposPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Saved Repositories"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: const Center(child: Text("No Repositories Saved")),
    );
  }
}
