
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:metod_chanel/button.dart';
import 'package:metod_chanel/colors.dart';
import 'package:metod_chanel/input.dart';
import 'package:metod_chanel/styles.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platform = MethodChannel('samples.flutter.dev/battery');

  String _batteryLevel = 'Intent Filtr';

  TextEditingController subjectEditingController = TextEditingController();
  TextEditingController toEditingController = TextEditingController();
  TextEditingController messageEditingController = TextEditingController();
  TextEditingController alarmTitleEditingController = TextEditingController();
  TimeOfDay? timeOfDay = TimeOfDay.now();

  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  Future<void> _setAlarm() async {
    try {
      await platform.invokeMethod('setAlarm', {
        "hour": timeOfDay?.hour,
        "minute": timeOfDay?.minute,
        "title": alarmTitleEditingController.text
      });
    } on PlatformException catch (e) {
      print("FAilt to set alarm::::: ${e.message}");
    }
  }

  Future<void> _sendEmail() async {
    await platform.invokeMethod('sendEmail', {
      "recipient": toEditingController.text,
      "subject": subjectEditingController.text,
      "message": messageEditingController.text
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustumInput(
                    hintText: "Recipient",
                    onSaved: (value) {},
                    validator: (validator) {},
                    controller: toEditingController),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustumInput(
                    hintText: "Subject",
                    onSaved: (value) {},
                    validator: (validator) {},
                    controller: subjectEditingController),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustumInput(
                    hintText: "Message",
                    onSaved: (onSaved) {},
                    validator: (validator) {},
                    controller: messageEditingController),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustumButton(
                    onPressed: () {
                      _sendEmail();
                    },
                    buttonText: "Send Email"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustumInput(
                    hintText: "Alarm Title",
                    onSaved: (onSaved) {},
                    validator: (validator) {},
                    controller: alarmTitleEditingController),
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _timePicker(context)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustumButton(
                    onPressed: () {
                      _setAlarm();
                    },
                    buttonText: "Set Alarm"),
              ),
             
            ],
          ),
        ),
      ),
    );
  }

  Widget _timePicker(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        timeOfDay =
            await showTimePicker(context: context, initialTime: timeOfDay!);
            setState(() {
              
            });
      },
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12),
          margin: EdgeInsets.only(bottom: 20),
          height: 50,
          decoration: BoxDecoration(
              color: TeleportColors.greyLight,
              borderRadius: Corners.smBorder,
              border: Border.all(color: Colors.white, width: 1)),
          child: Center(
            child: Text(
              "${timeOfDay?.hour} : ${timeOfDay?.minute}",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          )),
    );
  }
}
