import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:flutter_svg/flutter_svg.dart';

class homepage extends StatefulWidget {
  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  String _platformVersion = 'Unknown';
  var MobileNumber = null;
  var CountryCode = '+91';
  var Message = null;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await FlutterOpenWhatsapp.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Rapid WhtsApp'),
        centerTitle: true,
        backgroundColor: Color(0xFF075e54),
      ),
      drawer: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width / 2,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: SvgPicture.asset('assets/msg.svg'),
              height: 200,
            ),
            Expanded(child: Container()),
            Divider(),
            ListTile(
              leading: Icon(Icons.message_rounded),
              title: Text("Contact Developer"),
              onTap: () {
                FlutterOpenWhatsapp.sendSingleMessage('+917073142922', 'Hi');
              },
            ),
          ],
        ),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          decoration: new BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/bg.png')),
            color: Color(0xFFe5dcd5),
          ),
          child: Center(
            child: Container(
              width: 360,
              child: Column(
                children: <Widget>[
                  Spacer(),
                  Row(
                    children: [
                      Container(
                        width: 60,
                        child: TextField(
                            onChanged: (code) {
                              CountryCode = code;
                              setState(() {
                                code = CountryCode;
                              });
                            },
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                contentPadding: EdgeInsets.all(10),
                                filled: true,
                                hintText: '  +91',
                                // prefixIcon: Icon(Icons.smartphone),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.horizontal(
                                  left: Radius.circular(40),
                                )))),
                      ),
                      Container(
                        width: 300,
                        child: TextField(
                          onChanged: (number) {
                            MobileNumber = number;
                            setState(() {
                              number = MobileNumber;
                            });
                          },
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              contentPadding: EdgeInsets.all(10),
                              filled: true,
                              hintText: 'Enter Mobile Number',
                              // hintText: 'Enter Mobile Number',
                              // prefixIcon: Icon(Icons.smartphone),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.horizontal(
                                right: Radius.circular(40),
                              ))),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  TextField(
                    onChanged: (message) {
                      Message = message;
                      setState(() {
                        message = Message;
                      });
                    },
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        hintText: 'Type a message',
                        contentPadding: EdgeInsets.all(10),
                        filled: true,
                        prefixIcon: Icon(Icons.message),
                        border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                          const Radius.circular(40.0),
                        ))),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  RaisedButton(
                      padding: EdgeInsets.all(15),
                      splashColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      color: Color(0xFF075e54),
                      child: new Text(
                        "Send",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () => FlutterOpenWhatsapp.sendSingleMessage(
                          '$CountryCode$MobileNumber', Message)),
                  Spacer(
                    flex: 2,
                  )
                ],
              ),
            ),
          )),
    );
  }
}
