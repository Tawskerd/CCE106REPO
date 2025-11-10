import 'package:flutter/material.dart';
import '../models/post_model.dart';
import '../models/comment_model.dart';
import '../data/seed_data.dart'; // to access users[0] as demo current user

class PostDetailPage extends StatefulWidget {
  final PostModel post;
  const PostDetailPage({super.key, required this.post});

  @override
  State<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  final TextEditingController commentController = TextEditingController();

  void _addComment() {
    final text = commentController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        widget.post.comments.add(CommentModel(user: demoUser, text: text));
      });
      commentController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final post = widget.post;

    // Comment count
    final commentCount = post.comments.length;

    return Scaffold(
      appBar: AppBar(title: Text(post.user.name)),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(post.imageUrl),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(post.caption, style: const TextStyle(fontSize: 16)),
                  ),
                  // Display post time here
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      post.createdAt, // Show the mock time
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ),
                  const Divider(),

                  // Comment count display
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "$commentCount Comments", // Show the number of comments
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),

                  // Display the list of comments
                  ...post.comments.map((c) => ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage(c.user.profileImage),
                        ),
                        title: Text(c.user.name),
                        subtitle: Text(c.text),
                      )),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            color: Colors.grey[100],
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: commentController,
                    decoration: const InputDecoration(
                      hintText: "Write a comment...",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.blue),
                  onPressed: _addComment,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
