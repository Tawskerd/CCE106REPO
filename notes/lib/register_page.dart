import 'package:flutter/material.dart';
import 'package:notes/auth_service.dart';
import 'package:notes/login_page.dart'; // make sure you have this file

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final AuthService auth = AuthService();
  final TextEditingController emailCrtl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: emailCrtl,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: passwordCtrl,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              SizedBox(height: 12),
              ElevatedButton(
                child: loading
                    ? CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    : Text('Register'),
                onPressed: () async {
                  if (emailCrtl.text.isEmpty || passwordCtrl.text.isEmpty)
                    return;

                  setState(() => loading = true);

                  // FIXED: wrong syntax "auth,registerWithEmail"
                  final user = await auth.registerWithEmail(
                      emailCrtl.text, passwordCtrl.text);

                  setState(() => loading = false);

                  // FIXED if syntax
                  if (user != null) {
                    if (!user.emailVerified) {
                      await user.sendEmailVerification();

                      // FIXED: "Context" → "context"
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'Verification email sent. Please check your inbox.'),
                        ),
                      );
                    }

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginPage()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                            Text('Registration failed. Please try again.'),
                      ),
                    );
                  }
                },
              ),
              SizedBox(height: 12),
              TextButton(
                child: Text('Already have an account? Login'),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
