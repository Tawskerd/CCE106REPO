import 'package:flutter/material.dart';
import 'package:socmed_part2/socialmedia.dart';


class LoginForm extends StatefulWidget {
  const LoginForm({super.key}); // ✅ fixed constructor

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late String errorMessage;
  late bool isError;

  @override
  void initState() {
    errorMessage = "";
    isError = false;
    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void checkLogin(String username, String password) {
    setState(() {
      if (username.isEmpty) {
        errorMessage = "Please input your username";
        isError = true;
      } else if (password.isEmpty) {
        errorMessage = "Please input your password";
        isError = true;
      } else {
        isError = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo.jpg',
                    height: 48,
                    width: 48,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'THE SOCMED CLONE',
                    style: txtstyle,
                  ),
                ],
              ),

              const SizedBox(height: 15),

              TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Username',
                  prefixIcon: Icon(Icons.person),
                ),
              ),

              const SizedBox(height: 15),

              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Password',
                  prefixIcon: Icon(Icons.password),
                ),
              ),

              const SizedBox(height: 15),

              if (isError)
                Text(errorMessage, style: errortxtstyle), 

              const SizedBox(height: 10),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: Colors.blue,
                ),
               onPressed: () {
  checkLogin(usernameController.text, passwordController.text);

  if (!isError) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SocialMedia(),
      ),
    );
  }
},

                child: Text('Login', style: txtstyle2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



const txtstyle = TextStyle(
  fontWeight: FontWeight.bold,
  letterSpacing: 2,
  fontSize: 24,
);

const registertxtstyle = TextStyle(
  fontWeight: FontWeight.bold,
  letterSpacing: 2,
  fontSize: 14,
);

const errortxtstyle = TextStyle(
  fontWeight: FontWeight.bold,
  letterSpacing: 1,
  fontSize: 14,
  color: Colors.red,
);

const txtstyle2 = TextStyle(
  fontWeight: FontWeight.bold,
  letterSpacing: 2,
  fontSize: 24,
  color: Colors.white,
);
