import 'package:flutter/material.dart';
import 'package:socmed_part2/model/userdata.dart';
import 'package:socmed_part2/model/userpost.dart';
import 'package:socmed_part2/views/post_detail_view.dart';

class PostCard extends StatefulWidget {
  final Userdata userdata;
  final Userpost userpost;

  const PostCard({
    super.key,
    required this.userdata,
    required this.userpost,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildUserLine(),
        _buildPostImage(),
        _buildButtons(),
        _buildCommenters(),
        const SizedBox(height: 10),
        Container(
          height: 10,
          color: Colors.grey[300],
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  // User profile line
  Widget _buildUserLine() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: CircleAvatar(
            backgroundImage: AssetImage(widget.userpost.userimg),
            radius: 25,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.userpost.username,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Row(
              children: [
                Text(widget.userpost.time),
                const SizedBox(width: 5),
                const Icon(Icons.group, size: 15, color: Colors.grey),
              ],
            ),
          ],
        ),
      ],
    );
  }

  // Post image
  Widget _buildPostImage() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.userpost.postcontent,
            style: const TextStyle(fontSize: 15),
          ),
          const SizedBox(height: 15),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: AssetImage(widget.userpost.posting),
                fit: BoxFit.cover,
              ),
            ),
            height: 350,
          ),
        ],
      ),
    );
  }

  // Interaction buttons
  Widget _buildButtons() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Divider(color: Colors.grey),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton.icon(
                onPressed: () {
                  setState(() {
                    widget.userpost.isLiked = !widget.userpost.isLiked;
                  });
                },
                icon: Icon(
                  Icons.thumb_up,
                  size: 30,
                  color: widget.userpost.isLiked ? Colors.blue : Colors.grey,
                ),
                label: Text(
                  "Like",
                  style: TextStyle(
                    color: widget.userpost.isLiked ? Colors.blue : Colors.grey,
                  ),
                ),
              ),
              TextButton.icon(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.grey,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PostDetailView(
                        userdata: widget.userdata,
                        userpost: widget.userpost,
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.chat_bubble, size: 30),
                label: Text("Comment (${widget.userpost.numcomments})"),
              ),
              TextButton.icon(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.grey,
                ),
                onPressed: () {},
                icon: const Icon(Icons.share, size: 20),
                label: Text("Share (${widget.userpost.numshare})"),
              ),
            ],
          ),
        ),
        const Divider(color: Colors.grey),
      ],
    );
  }

  // Comment count
  Widget _buildCommenters() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${widget.userpost.numcomments} Comments • ${widget.userpost.numshare} Shares',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}