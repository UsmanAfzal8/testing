import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:testingapph/firebaseupload/imageupload.dart';

class Authmethod {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<String> uploaddata({
    required String Imageurl,
  }) async {
    String res = "not in the function";
    try {
      if (Imageurl.isNotEmpty) {
        String profileimage =
            await imagestorage().uploadimage('profile', Imageurl);

        await _firestore.collection('user').add({
          'phot': Imageurl,
          'imageurl': profileimage,
        });
        res = 'Success';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
