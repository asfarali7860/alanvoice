import 'package:flutter/material.dart';
import 'package:alan_voice/alan_voice.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initAlanButton();
  }

  void initAlanButton() {
    AlanVoice.addButton(
        "ae119700d4e1057d125747eebbea33b12e956eca572e1d8b807a3e2338fdd0dc/stage", // Replace with your actual project key
        buttonAlign: AlanVoice.BUTTON_ALIGN_LEFT);

    AlanVoice.callbacks.add((command) => _handleVoiceCommand(command.data));
  }

  void _handleVoiceCommand(Map<String, dynamic> data) {
    String commandType = data["command"];
    switch (commandType) {
      case "fillName":
        setState(() {
          nameController.text = data["value"];
        }); 
        break;
      case "fillEmail":
        setState(() {
          emailController.text = data["value"];
        });
        break;
      default:
        print("Command not recognized");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Voice-Powered Form'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
