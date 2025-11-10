import 'user_model.dart';
import 'comment_model.dart';

class PostModel {
  final int id;
  final UserModel user;
  final String caption;
  final String imageUrl;
  final int likes;
  final List<CommentModel> comments;
  final int shares;
final String createdAt;
  PostModel({
    required this.id,
    required this.user,
    required this.caption,
    required this.imageUrl,
    required this.likes,
    required this.comments,
    required this.shares,
     required this.createdAt,
  });
}
