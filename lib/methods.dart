import 'package:chat_app/Screens/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Screens/home.dart';

Future<User> createAccount(String name, String email, String password) async {
  FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  try {
    User? user = (await _auth.createUserWithEmailAndPassword(
            email: email, password: password))
        .user;

    if (user != null) {
      print("Account created Successful");

      user.updateProfile(displayName: name);

      await _firestore.collection("users").doc(_auth.currentUser?.uid).set({
        "name": name,
        "email": email,
        "status": "Unavaliable",
        "uid": _auth.currentUser!.uid
      });
      return user;
    } else {
      print("Account creation Failed");
      return user!;
    }
  } catch (e) {
    print(e);
    return null!;
  }
}

Future<User> logIn(String email, String password) async {
  FirebaseAuth _auth = FirebaseAuth.instance;

  try {
    User? user = (await _auth.signInWithEmailAndPassword(
            email: email, password: password))
        .user;

    if (user != null) {
      print("Login Successful");
      return user;
    } else {
      print("Login Failed");
      return user!;
    }
  } catch (e) {
    print(e);
    return null!;
  }
}

Future logOut(BuildContext context) async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  try {
    await _auth.signOut().then((value) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen()));
    });
  } catch (e) {
    print("Error");
  }
}
