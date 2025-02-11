import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'package:ghii_interview/db_controllers/repository_database.dart';
import 'package:ghii_interview/models/repository/repository.dart';

class SavedRepositoryCard extends StatefulWidget {
  final Repository repository;

  const SavedRepositoryCard({
    super.key,
    required this.repository,
  });

  @override
  State<SavedRepositoryCard> createState() => _SavedRepositoryCardState();
}

class _SavedRepositoryCardState extends State<SavedRepositoryCard> {
  @override
  void initState() {
    super.initState();
    fetchRepos();
  }

  // Fetch all saved repositories
  void fetchRepos() {
    context.read<RepositoryDatabse>().fetchRepositories();
  }

  // Delete Repository
  void deleteRepository(id) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Delete this repo?"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel")),
                TextButton(
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all<Color>(Colors.red),
                      foregroundColor:
                          WidgetStateProperty.all<Color>(Colors.white),
                    ),
                    onPressed: () {
                      context
                          .read<RepositoryDatabse>()
                          .deleteRepository(id)
                          .then((id) => Fluttertoast.showToast(
                              msg: "Repository Deleted",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.TOP,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0));
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Yes, delete",
                    ))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(widget.repository.avatarUrl),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Full Name: ${widget.repository.fullname}'),
                  Text('Private: ${widget.repository.isPrivate}'),
                  Text('Login: ${widget.repository.login}'),
                  Text('Type: ${widget.repository.type}'),
                  Text('Type: ${widget.repository.description}'),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      TextButton(
                          onPressed: () async {
                            deleteRepository(widget.repository.id);
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                WidgetStateProperty.all<Color>(Colors.red),
                            foregroundColor:
                                WidgetStateProperty.all<Color>(Colors.white),
                          ),
                          child: const Text("Delete Repo")),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Divider(),
      ],
    );
  }
}
