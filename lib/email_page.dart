import 'dart:async';

import 'package:flutter/material.dart';
import 'package:yews_news/home_page.dart';

class EmailPage extends StatefulWidget {
  const EmailPage({Key? key}) : super(key: key);

  @override
  State<EmailPage> createState() => _EmailPageState();
}

class _EmailPageState extends State<EmailPage> {
  bool isSignIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 50, right: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter a phone number or email \nOr just tap submit',
              style: TextStyle(height: 2, color: Color(0xFF1b1212)),
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: '|',
                border: InputBorder.none,
              ),
            ),
            InkWell(
              onTap: () async {
                isSignIn = true;
                setState(() {});
                await Future.delayed(const Duration(seconds: 2), () {
                  isSignIn = false;
                  setState(() {});
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ),
                  );
                });
              },
              child: Text(
                isSignIn ? 'Please wait...' : 'Submit',
                style: const TextStyle(
                  height: 2,
                  fontWeight: FontWeight.normal,
                  color: Color(0xFF1b1212),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
