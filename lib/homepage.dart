import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:testingapph/firebaseupload/auth.dart';

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  String imageurl = '';
  String imageurl2 = '';
  bool _isloading = false;

  void apicall() async {
    setState(() {
      _isloading = true;
    });
    var api = 'https://dog.ceo/api/breeds/image/random';
    var res = await http.get(Uri.parse(api));
    dynamic list = jsonDecode(res.body);
    imageurl = list['message'];
    print(list['message']);
    setState(() {
      _isloading = false;
    });
  }

  //show last image on
  void getimagefromfirebase() async {
    final ref = FirebaseStorage.instance.ref().child('profile');
    var url = await ref.getDownloadURL();
    imageurl2 = url;
    print(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: _isloading
              ? CircularProgressIndicator(
                  color: Colors.black,
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Column(
                    children: [
                      Container(
                        height: 200,
                        width: 200,
                        //color: Colors.black,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(imageurl),
                                fit: BoxFit.fill)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          onPressed: apicall, child: Text('refresh')),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            String res = await Authmethod()
                                .uploaddata(Imageurl: imageurl);
                            print(res);
                          },
                          child: Text('upload')),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          onPressed: getimagefromfirebase,
                          child: Text('lastimage')),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 200,
                        width: 200,
                        //color: Colors.black,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(imageurl2),
                                fit: BoxFit.fill)),
                      ),
                    ],
                  ),
                )),
    );
  }
}
