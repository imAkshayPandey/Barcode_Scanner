import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'dart:async';
import 'package:flutter/services.dart';
//import 'Barcode.dart';
import 'History.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String barcode = "";

  List<Container> list=new List();


  barlist(barcode){
    String name=barcode;
    list.add(
      Container(child: Text(name),));
    

  }

  @override
  void initState() {
    super.initState();
    scan();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Barcode Scanner"),
        centerTitle: false,
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.red,
                margin: EdgeInsets.only(bottom: 380.0),
              ),
            ),
            new Padding(
              padding: const EdgeInsets.only(bottom: 70.0),
              child: new Container(
                margin: EdgeInsets.only(bottom: 360.0),
                child: new Column(
                  children: <Widget>[
                    ListTile(
                      title: Text("Scan"),
                      onTap: () {
                        scan();
                      },
                      trailing: Icon(Icons.camera_alt,color: Colors.black,),
                    ),
                    Divider(height: 1.2,indent:23.0,color: Colors.grey,),
                    ListTile(
                      title: Text("History"),
                      onTap: (){Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>
                           History(list)
                      ));},
                      trailing: Icon(Icons.history,color: Colors.black,),
                    ),
                    Divider(height: 1.2,indent:23.0,color: Colors.grey,),
                    ListTile(
                      title: Text("Settings"),
                      onTap: () {},
                      trailing: Icon(Icons.settings,color: Colors.black,),
                    ),
                    Divider(height: 1.2,indent:23.0,color: Colors.grey,),
                    // ListTile(title: Text(""),onTap: (){},),
                    ListTile(
                      title: Text("About"),
                      onTap: () {},
                      trailing: Icon(Icons.info,color: Colors.black,),
                    ),
                  ],
                ),
              ),
            ),

            // ListTile(title: Text("HISTORY"),onTap: (){},),
          ],
        ),
      ),
      body: new Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              child: Image(
                image: AssetImage("img/frame.png"),
              ),
            ),
          ),
          new Padding(
            padding: const EdgeInsets.all(30.0),
            child: new Center(
              child: Container(
                child: RawMaterialButton(
                  onPressed: () => scan(),
                  child: Text("Scan Now"),
                  fillColor: Colors.lightBlueAccent,
                  highlightColor: Colors.lightBlue,
                  splashColor: Colors.indigo,
                ),
              ),
            ),
          ),
          new Padding(
            padding: const EdgeInsets.only(bottom: 18.0, top: 10.0),
            child: Text(barcode),
          )
        ],
      ),
    );
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      barlist(barcode); 
      setState((){this.barcode = barcode;
      barlist(barcode);});
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = "Camera access denied,please allow the access";
        });
      } else {
        setState(() {
          this.barcode = "unknown error $e";
        });
      }
    } on FormatException catch (e) {
      setState(() => this.barcode =
          'null (User returned using the "back"-button before scanning anything. $e)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }
}
