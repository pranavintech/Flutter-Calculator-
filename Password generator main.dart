import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Password Generator',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: PasswordGeneratorApp(),
    );
  }
}

class PasswordGeneratorApp extends StatefulWidget {
  @override
  _PasswordGeneratorAppState createState() => _PasswordGeneratorAppState();
}

class _PasswordGeneratorAppState extends State<PasswordGeneratorApp> {
  String generatedPassword = '';
  int passwordLength = 12;
  bool includeUppercase = true;
  bool includeLowercase = true;
  bool includeDigits = true;
  bool includeSpecialChars = true;

  void generatePassword() {
    String chars = '';
    if (includeUppercase) chars += 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    if (includeLowercase) chars += 'abcdefghijklmnopqrstuvwxyz';
    if (includeDigits) chars += '0123456789';
    if (includeSpecialChars) chars += '!@#%^&*()_-+=<>?';

    String password = '';
    final random = Random();
    for (int i = 0; i < passwordLength; i++) {
      password += chars[random.nextInt(chars.length)];
    }

    setState(() {
      generatedPassword = password;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Password Generator')),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Generated Password:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              SelectableText(
                generatedPassword,
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    value: includeUppercase,
                    onChanged: (value) {
                      setState(() {
                        includeUppercase = value!;
                      });
                    },
                  ),
                  Text('Uppercase'),
                  Checkbox(
                    value: includeLowercase,
                    onChanged: (value) {
                      setState(() {
                        includeLowercase = value!;
                      });
                    },
                  ),
                  Text('Lowercase'),
                  Checkbox(
                    value: includeDigits,
                    onChanged: (value) {
                      setState(() {
                        includeDigits = value!;
                      });
                    },
                  ),
                  Text('Digits'),
                  Checkbox(
                    value: includeSpecialChars,
                    onChanged: (value) {
                      setState(() {
                        includeSpecialChars = value!;
                      });
                    },
                  ),
                  Text('Special Chars'),
                ],
              ),
              Slider(
                value: passwordLength.toDouble(),
                min: 6,
                max: 20,
                onChanged: (value) {
                  setState(() {
                    passwordLength = value.toInt();
                  });
                },
              ),
              Text('Password Length: $passwordLength'),
              ElevatedButton(
                onPressed: generatePassword,
                child: Text('Generate Password'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
