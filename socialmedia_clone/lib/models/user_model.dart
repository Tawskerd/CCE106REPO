class UserModel {
  final int id;
  final String name;
  final String email;
  final String profileImage;
  final int followers;
  final int following;
  final int posts;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.profileImage,
    required this.followers,
    required this.following,
    required this.posts,
  });
}
