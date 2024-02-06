import 'package:bynry_task_main/HomeScreen.dart';
import 'package:bynry_task_main/SignUp.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';



class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  var userNameController = TextEditingController();
  var userPasswordController = TextEditingController();

  final Box _boxAccounts = Hive.box("accounts");
  final Box _boxLogin = Hive.box("login");

  final FocusNode _focusNodePassword = FocusNode();

  @override
  Widget build(BuildContext context) {
    if (_boxLogin.get("loginStatus") ?? false) {
      return HomeScreen();
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome Back !',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    fontSize: 30),
              ),
              Text(
                'Login Into Your Account',
                style: TextStyle(color: Colors.white70, fontSize: 20),
              ),
              SizedBox(
                height: 100,
                width: double.infinity,
              ),
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60),
                          topRight: Radius.circular(60),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Container(
                            height: 350,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(40),
                              ),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: userNameController,
                                    decoration: InputDecoration(
                                      hintText: 'Enter Email Address',
                                      hintStyle: TextStyle(color: Colors.grey),
                                    ),
                                    onEditingComplete: () =>
                                        _focusNodePassword.requestFocus(),
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please enter username.";
                                      } else if (!_boxAccounts
                                          .containsKey(value)) {
                                        return "Username is not registered.";
                                      }

                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 20),
                                  TextFormField(
                                    controller: userPasswordController,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      hintText: 'Enter Password',
                                      hintStyle: TextStyle(color: Colors.grey),
                                    ),
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please enter password.";
                                      } else if (value !=
                                          _boxAccounts
                                              .get(userNameController.text)) {
                                        return "Wrong password.";
                                      }

                                      return null;
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        GestureDetector(
                                          onTap: () {},
                                          child: Text(
                                            'Forgot Password?',
                                            style: TextStyle(
                                              color: Colors.blue,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            if (_formKey.currentState
                                                    ?.validate() ??
                                                false) {
                                              _boxLogin.put(
                                                  "loginStatus", true);
                                              _boxLogin.put("userName",
                                                  userNameController.text);

                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) {
                                                    return HomeScreen();
                                                  },
                                                ),
                                              );
                                            }
                                          },
                                          child: Text('Login'),
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.orange,
                                              minimumSize: Size(200, 40),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          2))),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(height: 10),
                                      GestureDetector(
                                        onTap: () {

                                          _formKey.currentState?.reset();

                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return SignUp();
                                              },
                                            ),
                                          );
                                          // Implement navigation to Sign Up screen
                                        },
                                        child: Text(
                                          'Already have an account? Sign Up',
                                          style: TextStyle(
                                            color: Colors.blue,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
