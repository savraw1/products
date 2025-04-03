import 'package:flutter/material.dart';
import 'package:products/view/product_list.dart';
import 'package:provider/provider.dart';
import 'package:products/provider/auth_provider.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldMessengerKey,
      resizeToAvoidBottomInset: true,
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          height: MediaQuery.of(context).size.height * 0.50,
          width: MediaQuery.of(context).size.width * 0.95,
          decoration: BoxDecoration(
            color: Colors.white10,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Log In",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextField(
                  controller: usernameController,
                  textInputAction: TextInputAction.next,
                  style: TextStyle(color: Colors.white, fontSize: 17.5),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person, color: Colors.black),
                    labelText: "Username",
                    labelStyle: TextStyle(color: Colors.white, fontSize: 17.5),
                    fillColor: Colors.white30,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
              SizedBox(height: 25),
              Consumer<AuthProvider>(
                builder: (context, authProvider, child) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextField(
                      textInputAction: TextInputAction.done,
                      onSubmitted: (_) => _login(context),
                      controller: passwordController,
                      obscureText: authProvider.isPasswordHidden,
                      style: TextStyle(color: Colors.white, fontSize: 17.5),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock, color: Colors.black),
                        suffix: InkWell(
                          splashColor: Colors.transparent,
                          onTap: () => authProvider.togglePasswordVisibility(),
                          child: Text(
                            authProvider.isPasswordHidden ? "Show" : "Hide",
                            style:
                                TextStyle(fontSize: 17.5, color: Colors.white),
                          ),
                        ),
                        labelText: "Password",
                        labelStyle:
                            TextStyle(color: Colors.white, fontSize: 17.5),
                        fillColor: Colors.white30,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 25),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.blue.shade900),
                  fixedSize: MaterialStateProperty.all(
                    Size(MediaQuery.of(context).size.width * 0.8, 65),
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                onPressed: () => _login(context),
                child: const Text(
                  "Log in",
                  style: TextStyle(
                      color: Colors.white, fontSize: 20, letterSpacing: 1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _login(BuildContext context) {
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();

    if (username.isEmpty && password.isEmpty) {
      _showSnackBar(context, "Please enter your username and password");
      return;
    } else if (username.isEmpty) {
      _showSnackBar(context, "Please enter your username");
      return;
    } else if (password.isEmpty) {
      _showSnackBar(context, "Please enter your password");
      return;
    } else if (password.length < 6) {
      _showSnackBar(context, "Password must be at least 6 characters long");
      return;
    } else if (username == "admin" && password == "admin@123") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ProductList()),
      );
    } else {
      _showSnackBar(context, "Invalid username or password");
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}