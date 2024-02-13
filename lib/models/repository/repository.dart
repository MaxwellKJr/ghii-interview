import 'package:isar/isar.dart';

part 'repository.g.dart';

@collection
class Repository {
  Id? id;
  String fullname;
  bool isPrivate;
  String login;
  String avatarUrl;
  String type;
  String description;

  Repository({
    this.id,
    required this.fullname,
    required this.isPrivate,
    required this.login,
    required this.avatarUrl,
    required this.type,
    required this.description,
  });

  factory Repository.fromJson(Map<String, dynamic> json) {
    return Repository(
      id: json['id'] as int?, // Make sure to cast to the correct type
      fullname: json['full_name'] as String,
      isPrivate: json['private'] as bool,
      login: json['owner']['login'] as String,
      avatarUrl: json['owner']['avatar_url'] as String,
      type: json['owner']['type'] as String,
      description: json['description'] as String? ??
          '', // Add a default value for description
    );
  }
}
