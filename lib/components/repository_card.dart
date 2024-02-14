import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ghii_interview/db_controllers/repository_database.dart';
import 'package:ghii_interview/models/repository/repository.dart';

class RepositoryCard extends StatelessWidget {
  final Repository repository;

  const RepositoryCard({
    super.key,
    required this.repository,
  });

  @override
  Widget build(BuildContext context) {
    final RepositoryDatabse newRepo = RepositoryDatabse();

    saveRepository(Repository repository) async {
      newRepo.addRepository(repository);

      Fluttertoast.showToast(
          msg: "Repository Saved",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.deepPurple,
          textColor: Colors.white,
          fontSize: 16.0);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(repository.avatarUrl),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Full Name: ${repository.fullname}'),
                  Text('Private: ${repository.isPrivate}'),
                  Text('Login: ${repository.login}'),
                  Text('Type: ${repository.type}'),
                  Text('Type: ${repository.description}'),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      FilledButton(
                          onPressed: () async {
                            saveRepository(repository);
                          },
                          child: const Text("Save"))
                    ],
                  ), // Add a divider between repositories
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
