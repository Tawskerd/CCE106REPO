import 'package:socmed_part2/model/account.dart';
import 'package:socmed_part2/model/friend.dart';
import 'package:socmed_part2/model/usercomment.dart';
import 'package:socmed_part2/model/userpost.dart';


class Userdata {
  List <Userpost> userList = [
    Userpost (
      userimg: "assets/images/walter.jpg",
      username: "Walter White",
      time: "2 hrs ago",
      postcontent: "My name is walter white, I am a chemistry teacher.",
      posting: "assets/images/lab.jpg",
      numcomments: "24",
      numshare: "5",
      isLiked: false,
    ),
    Userpost (
      userimg: "assets/images/jesse.jpg",
      username: "Jesse Pinkman",
      time: "3 hrs ago",
      postcontent: "This is my own private domicile and I will not be Harrased!.",
      posting: "assets/images/rv.jpg",
      numcomments: "15",
      numshare: "3",
      isLiked: true,
    ),
    Userpost (
      userimg: "assets/images/gus.jpg",
      username: "Gus Fring",
      time: "5 hrs ago",
      postcontent: "And a man, a man provides. And he does it even when he's not appreciated, or respected, or even loved. He simply bears up and he does it. Because he's a man",
      posting: "assets/images/los_pollos.jpg",
      numcomments: "30",
      numshare: "8",
      isLiked: false,
    ),
  ];
  List<Friend> friendList = [
    Friend(img: "assets/images/walter.jpg", name: "Walter White"),
    Friend(img: "assets/images/jesse.jpg", name: "Jesse Pinkman"),
    Friend(img: "assets/images/gus.jpg", name: "Gus Fring"),
    Friend(img: "assets/images/saul.jpg", name: "Saul Goodman"),
    Friend(img: "assets/images/skyler.jpg", name: "Skyler White"),
    Friend(img: "assets/images/hank.jpg", name: "Hank Schrader"),
  ];

  List<Usercomment> commentList = [
    Usercomment(
      commenterImg: "assets/images/saul.jpg",
      commenterName: "Saul Goodman",
      commenterTime: "1 hr ago",
      commentContent: "Better call Saul!",
    ),
    Usercomment(
      commenterImg: "assets/images/skyler.jpg",
      commenterName: "Skyler White",
      commenterTime: "2 hrs ago",
      commentContent: "We need to talk.",
    ),
    Usercomment(
      commenterImg: "assets/images/hank.jpg",
      commenterName: "Hank Schrader",
      commenterTime: "3 hrs ago",
      commentContent: "DEA on the case!",
    ),
  ];

  Account MyUserAccount = Account(
    name: "Christoper James Cuesta",
    email: "corvo.attano@example.com",
    img: "assets/images/corvo.jpg",
    numFollowers: "1500",
    numPosts: "300",
    numFollowing: "180",
    numFriends: "250",
  );
}