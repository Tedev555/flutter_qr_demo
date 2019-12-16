import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:qrscan/qrscan.dart' as scanner;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String barcode = '';
  Uint8List bytes = Uint8List(200);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Scanner'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
//            _buildImage(),
            Text('Result Data: $barcode'),
            RaisedButton(onPressed: _scan, child: Text("Scan QR")),
            RaisedButton(
                onPressed: _generateBarCode, child: Text("Generate Barcode")),
          ],
        ),
//            RaisedButton(onPressed: _scanPhoto, child: Text("Scan Photo")),
//            RaisedButton(onPressed: _generateBarCode, child: Text("Generate Barcode")),
      ),
    );
  }

  Future _scan() async {
    String barcode = await scanner.scan();
    print("BarCodeData: " + barcode);
    setState(() => this.barcode = barcode);
  }

  Future _generateBarCode() async {
    Uint8List result = await scanner
        .generateBarCode('http://tedory.me');
    this.setState(() => this.bytes = result);
  }

  Widget _buildImage() {
    return bytes != null
        ? SizedBox(
            width: 200,
            height: 200,
            child: Image.memory(bytes),
          )
        : Container();
  }
}
