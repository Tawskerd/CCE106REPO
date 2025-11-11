import 'package:flutter/material.dart';
import 'package:socmed_part2/model/userdata.dart';
import 'package:socmed_part2/model/userpost.dart';
import 'package:socmed_part2/model/usercomment.dart';

class CommentInput extends StatefulWidget {
  final Userdata userdata;
  final Userpost userpost;
  final VoidCallback onCommentAdded;

  const CommentInput({
    super.key,
    required this.userdata,
    required this.userpost,
    required this.onCommentAdded,
  });

  @override
  State<CommentInput> createState() => _CommentInputState();
}

class _CommentInputState extends State<CommentInput> {
  final TextEditingController _commentController = TextEditingController();
  final FocusNode _commentFocusNode = FocusNode();

  @override
  void dispose() {
    _commentController.dispose();
    _commentFocusNode.dispose();
    super.dispose();
  }

  void _addComment() {
    if (_commentController.text.trim().isEmpty) {
      return;
    }

    // Create new comment
    final newComment = Usercomment(
      commenterImg: widget.userdata.MyUserAccount.img,
      commenterName: widget.userdata.MyUserAccount.name,
      commenterTime: "Just now",
      commentContent: _commentController.text.trim(),
    );

    // Add to comment list
    widget.userdata.commentList.insert(0, newComment);

    // Update comment count
    int currentCount = int.parse(widget.userpost.numcomments);
    widget.userpost.numcomments = (currentCount + 1).toString();

    // Clear the text field
    _commentController.clear();

    // Remove focus from text field
    _commentFocusNode.unfocus();

    // Notify parent widget
    widget.onCommentAdded();

    // Show confirmation
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Comment added!'),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: SafeArea(
        child: Row(
          children: [
            // User avatar
            CircleAvatar(
              backgroundImage: AssetImage(widget.userdata.MyUserAccount.img),
              radius: 20,
            ),
            const SizedBox(width: 10),
            // Text input field
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(25),
                ),
                child: TextField(
                  controller: _commentController,
                  focusNode: _commentFocusNode,
                  decoration: const InputDecoration(
                    hintText: 'Write a comment...',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                  ),
                  maxLines: null,
                  textInputAction: TextInputAction.send,
                  onSubmitted: (_) => _addComment(),
                ),
              ),
            ),
            const SizedBox(width: 8),
            // Send button
            IconButton(
              onPressed: _addComment,
              icon: const Icon(
                Icons.send,
                color: Colors.blue,
              ),
              iconSize: 28,
            ),
          ],
        ),
      ),
    );
  }
}