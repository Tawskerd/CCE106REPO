import 'package:flutter/material.dart';
import 'package:socmed_part2/model/userdata.dart';
import 'package:socmed_part2/model/userpost.dart';
import 'package:socmed_part2/widgets/comment_card.dart';
import 'package:socmed_part2/widgets/comment_input.dart';

class PostDetailView extends StatefulWidget {
  final Userdata userdata;
  final Userpost userpost;

  const PostDetailView({
    super.key,
    required this.userdata,
    required this.userpost,
  });

  @override
  State<PostDetailView> createState() => _PostDetailViewState();
}

class _PostDetailViewState extends State<PostDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.grey),
        ),
        title: const Text('Post'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                _buildUserLine(),
                _buildPostImage(),
                _buildButtons(),
                _buildCommenters(),
                const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Comments',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.userdata.commentList.length,
                  itemBuilder: (context, index) {
                    return CommentCard(
                      userComment: widget.userdata.commentList[index],
                    );
                  },
                ),
                const SizedBox(height: 80),
              ],
            ),
          ),
          CommentInput(
            userdata: widget.userdata,
            userpost: widget.userpost,
            onCommentAdded: () {
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

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
                onPressed: () {},
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