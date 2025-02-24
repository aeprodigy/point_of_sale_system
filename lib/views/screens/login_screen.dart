import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:point_on_sale_system/views/screens/home_screen.dart';
import 'package:point_on_sale_system/views/widgets/button_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isChecked = false;
  bool _isObscured = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //icon
              Center(
                child: FaIcon(
                  FontAwesomeIcons.bellConcierge,
                  color: Colors.pink,
                  size: 80,
                ),
              ),
              SizedBox(
                height: 20,
              ),

              //name of the app
              Center(
                child: Text(
                  'Cashier POS App',
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              //username
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  "Username",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              //Textfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Enter Your username",
                    hintStyle: TextStyle(
                      color: Colors.grey[600],
                    ),
                    fillColor: Colors.grey[200],
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                          color: Colors.transparent), // Transparent border
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                          color:
                              Colors.transparent), // No border when not focused
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                          color: Colors.transparent), // No border when focused
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 16, // Adjust top & bottom padding
                      horizontal: 25, // Adjust left & right padding
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              //password
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  "Password",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              //Textfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextField(
                  obscureText: _isObscured,
                  decoration: InputDecoration(
                    hintText: "Enter Your Password",
                    hintStyle: TextStyle(
                      color: Colors.grey[600],
                    ),
                    fillColor: Colors.grey[200],
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                          color: Colors.transparent), // Transparent border
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                          color:
                              Colors.transparent), // No border when not focused
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                          color: Colors.transparent), // No border when focused
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 16, // Adjust top & bottom padding
                      horizontal: 25, // Adjust left & right padding
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        _isObscured = !_isObscured; // Toggle visibility
                      },
                      icon: Icon(
                        _isObscured ? Icons.visibility : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              //forgot and remember me
              Row(
                children: [
                  Row(
                    children: [
                      //Tick box
                      Checkbox(
                          value: isChecked,
                          onChanged: (bool? newValue) {
                            isChecked = newValue!;
                          }),
                      SizedBox(
                        width: 3,
                      ),
                      //remember me text
                      Text(
                        "Remember me",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 80,
                  ),
                  //Forgot password
                  Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Colors.pink,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.pink,
                      fontSize: 16,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              //button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ButtonWidget(
                  name: 'Login',
                  ontap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
