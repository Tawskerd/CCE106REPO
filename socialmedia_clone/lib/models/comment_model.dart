import 'user_model.dart';

class CommentModel {
  final UserModel user;
  final String text;
  final DateTime createdAt;


  CommentModel({
    required this.user,
    required this.text,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

}
