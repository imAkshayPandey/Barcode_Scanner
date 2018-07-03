import 'package:flutter/material.dart';
//import 'Barcode.dart';


class History extends StatefulWidget {
  History(this.barcode);
   List<Container> barcode;
  @override
  _HistoryState createState() => new _HistoryState();
}

class _HistoryState extends State<History> {


@override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
    void dispose() {
      this.widget.barcode=widget.barcode;
      // TODO: implement dispose
      super.dispose();
      Navigator.pop(context);
    }
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("History"),

      ),
      //  body: Container(child: Text("ok"),)
      body: ListView.builder(
        itemCount: widget.barcode.length,
        itemBuilder: (context,i){
            return Column(children: widget.barcode,);
        },
     
         )
    );
  }
        
      
    
  
}