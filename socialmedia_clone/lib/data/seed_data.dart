import '../models/user_model.dart';
import '../models/post_model.dart';
import '../models/comment_model.dart';

/// --- Logged-in user (you) ---
final demoUser = UserModel(
  id: 0,
  name: 'Corvo Attano',
  email: 'corvoattano1234@gmail.com',
  profileImage: 'assets/images/corvo.jpg', // You can replace this image
  followers: 152,
  following: 98,
  posts: 12,
);

/// --- Breaking Bad characters ---
final users = [
  UserModel(
    id: 1,
    name: 'Walter White',
    email: 'walter@heisenberg.com',
    profileImage: 'assets/images/walter.jpg',
    followers: 250,
    following: 120,
    posts: 40,
  ),
  UserModel(
    id: 2,
    name: 'Jesse Pinkman',
    email: 'jesse@yo.com',
    profileImage: 'assets/images/jesse.jpg',
    followers: 180,
    following: 200,
    posts: 32,
  ),
  UserModel(
    id: 3,
    name: 'Saul Goodman',
    email: 'saul@bettercallsaul.com',
    profileImage: 'assets/images/saul.jpg',
    followers: 520,
    following: 80,
    posts: 65,
  ),
  UserModel(
    id: 4,
    name: 'Mike Ehrmantraut',
    email: 'mike@fixer.com',
    profileImage: 'assets/images/mike.jpg',
    followers: 300,
    following: 150,
    posts: 28,
  ),
  UserModel(
    id: 5,
    name: 'Gus Fring',
    email: 'gus@polloshermanos.com',
    profileImage: 'assets/images/gus.jpg',
    followers: 620,
    following: 110,
    posts: 72,
  ),
];

/// --- Posts with comments ---
final posts = [
  PostModel(
    id: 1,
    user: users[0], // Walter
    caption: "Say my name.",
    imageUrl: 'assets/images/lab.jpg',
    likes: 350,
    shares: 45,
    comments: [
      CommentModel(user: users[1], text: "You're Heisenberg! 😳"),
      CommentModel(user: users[2], text: "Better call me before DEA does."),
    ],
    createdAt: "2 hours ago",
  ),
  PostModel(
    id: 2,
    user: users[1], // Jesse
    caption: "Yo, science rules! 👨‍🔬💥",
    imageUrl: 'assets/images/rv.jpg',
    likes: 210,
    shares: 12,
    comments: [
      CommentModel(user: users[0], text: "Focus, Jesse. We're cooking, not posting."),
      CommentModel(user: users[3], text: "You're being watched, kid."),
    ],
    createdAt: "2 hours ago",
  ),
  PostModel(
    id: 3,
    user: users[2], // Saul Goodman
    caption: "In legal trouble? You know who to call 📞",
    imageUrl: 'assets/images/saul_office.jpg',
    likes: 420,
    shares: 90,
    comments: [
      CommentModel(user: demoUser, text: "Even assassins need lawyers."),
      CommentModel(user: users[4], text: "We may do business soon."),
    ],
    createdAt: "2 hours ago",
  ),
  PostModel(
    id: 4,
    user: users[4], // Gus
    caption: "A man provides.",
    imageUrl: 'assets/images/los_pollos.jpg',
    likes: 510,
    shares: 73,
    comments: [
      CommentModel(user: users[0], text: "Well said, Mr. Fring."),
      CommentModel(user: users[3], text: "Always calm, huh?"),
    ],
    createdAt: "2 hours ago",
  ),
];
