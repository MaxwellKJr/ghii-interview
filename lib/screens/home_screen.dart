import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ghii_interview/models/repository/repository.dart';
import 'package:ghii_interview/screens/saved_repos_page.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Repository>> futureRepositories;

  Future<List<Repository>> fetchRepositories() async {
    final response =
        await http.get(Uri.parse('https://api.github.com/repositories'));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Repository.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load repositories');
    }
  }

  @override
  void initState() {
    super.initState();
    futureRepositories = fetchRepositories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FutureBuilder<List<Repository>>(
                future: fetchRepositories(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    List<Repository> repositories = snapshot.data!;
                    // Limiting the number of queries to 15 repositories
                    List<Repository> reposList = repositories.take(15).toList();

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: reposList.map((repository) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(repository.avatarUrl),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                              onPressed: () {},
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
                      }).toList(),
                    );
                  } else {
                    return const Text('No data available');
                  }
                },
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const SavedReposPage()));
        },
        tooltip: 'Saved Repositories',
        child: const Icon(Icons.save),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
