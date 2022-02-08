import 'package:chat_app/Screens/home.dart';
import 'package:chat_app/methods.dart';
import 'package:flutter/material.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: isLoading
            ? Center(
                child: Container(
                  height: size.height / 20,
                  width: size.width / 20,
                  child: CircularProgressIndicator() ,
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height / 20,
                    ),
                    Container(
                        alignment: Alignment.centerLeft,
                        width: size.width / 1.2,
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.arrow_back_ios))),
                    SizedBox(
                      height: size.height / 50,
                    ),
                    Container(
                        width: size.width / 1.3,
                        child: Text(
                          "Welcome",
                          style: TextStyle(
                              fontSize: 34, fontWeight: FontWeight.bold),
                        )),
                    Container(
                      width: size.width / 1.3,
                      child: Text(
                        "Create Account Continue!",
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      height: size.height / 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18.0),
                      child: Container(
                          alignment: Alignment.center,
                          width: size.width,
                          child: field(size, "Name", Icons.account_box, _name)),
                    ),
                    Container(
                        alignment: Alignment.center,
                        width: size.width,
                        child: field(size, "email", Icons.account_box, _email)),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18.0),
                      child: Container(
                        alignment: Alignment.center,
                        width: size.width,
                        child: field(size, "password", Icons.lock, _password),
                      ),
                    ),
                    SizedBox(
                      height: size.height / 20,
                    ),
                    customButton(
                      size,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    )
                  ],
                ),
              ));
  }

  Widget customButton(Size size) {
    return GestureDetector(
      onTap: () {
        if (_name.text.isNotEmpty &&
            _email.text.isNotEmpty &&
            _password.text.isNotEmpty) {
          setState(() {
            isLoading = true;
          });

          createAccount(_name.text, _email.text, _password.text).then((user) {
            if (user != null) {
              setState(() {
                isLoading = false;
              });
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => HomeScreen()));
              print("Account Created Successfull");

            } else {
              print("Login Failed");
            }
          });
        } else {
          print("Please enter Fields");
          setState(() {
            isLoading= false;
          });
        }
      },
      child: Container(
        height: size.height / 14,
        width: size.width / 1.2,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: Colors.blue),
        child: Text(
          "Create Account ",
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget field(
      Size size, String hintText, IconData icon, TextEditingController cont) {
    return Container(
      height: size.height / 14,
      width: size.width / 1.1,
      child: TextField(
        controller: cont,
        decoration: InputDecoration(
            prefixIcon: Icon(icon),
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      ),
    );
  }
}
