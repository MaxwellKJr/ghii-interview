import 'package:flutter/material.dart';
import 'package:ghii_interview/components/saved_repository_card.dart';
import 'package:ghii_interview/db_controllers/repository_database.dart';
import 'package:ghii_interview/models/repository/repository.dart';
import 'package:provider/provider.dart';

class SavedReposPage extends StatefulWidget {
  const SavedReposPage({super.key});

  @override
  State<SavedReposPage> createState() => _SavedReposPageState();
}

class _SavedReposPageState extends State<SavedReposPage> {
  @override
  void initState() {
    super.initState();
    fetchRepos();
  }

  // Fetch all saved repositories
  void fetchRepos() {
    context.read<RepositoryDatabse>().fetchRepositories();
  }

  @override
  Widget build(BuildContext context) {
    final repositoryDatabse = context.watch<RepositoryDatabse>();
    List<Repository> savedRepositories = repositoryDatabse.savedRepositories;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Saved Repositories"),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: savedRepositories.isEmpty
            ? const Center(
                child: Text("No repositories have been saved."),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                    itemCount: savedRepositories.length,
                    itemBuilder: (context, index) {
                      final repository = savedRepositories[index];
                      return SavedRepositoryCard(repository: repository);
                    }),
              ));
  }
}
