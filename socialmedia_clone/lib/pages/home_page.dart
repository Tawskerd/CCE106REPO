import 'package:flutter/material.dart';
import '../data/seed_data.dart';
import 'profile_page.dart';
import 'post_detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Map<int, bool> likedPosts = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Posts"),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) =>  ProfilePage()),
              );
            },
          ),
        ],
      ),

      // 📰 Post List
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          final isLiked = likedPosts[index] ?? false;

          return Card(
            margin: const EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 👤 Post Header (user info)
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(post.user.profileImage),
                    radius: 22,
                  ),
                  title: Text(
                    post.user.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(post.createdAt), // show time here
                  onTap: () {
                    // Go to profile page of the post user
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) =>  ProfilePage()),
                    );
                  },
                ),

                // 🖼️ Post Image
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PostDetailPage(post: post),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      post.imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 250,
                    ),
                  ),
                ),

                // ❤️ Like / 💬 Comment / 🔁 Share Row
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        icon: Icon(
                          isLiked ? Icons.favorite : Icons.favorite_border,
                          color: isLiked ? Colors.red : Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            likedPosts[index] = !isLiked;
                          });
                        },
                      ),
                      const Text('Like'),
                      const SizedBox(width: 20),

                      IconButton(
                        icon: const Icon(Icons.comment_outlined),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PostDetailPage(post: post),
                            ),
                          );
                        },
                      ),
                      const Text('Comment'),
                      const SizedBox(width: 20),

                      IconButton(
                        icon: const Icon(Icons.share_outlined),
                        onPressed: () {},
                      ),
                      const Text('Share'),
                    ],
                  ),
                ),

                // 🗨️ Comment Count
                Padding(
                  padding: const EdgeInsets.only(left: 16, bottom: 10),
                  child: Text(
                    "${post.comments.length} Comments",
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
