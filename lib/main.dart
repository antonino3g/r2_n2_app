import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'api/api.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List _scanBarcode = [];
  TextEditingController tomboController = new TextEditingController();
  TextEditingController destinoController = new TextEditingController();
  List<TextEditingController> qrCodeController = [];

  void handleQrCode([tombo, destino]) {
    {
      tomboController.text = tombo;
      destinoController.text = destino;
    }
  }

  void handlePush() {
    while (_scanBarcode.length > 0) {
      // qrCodeController.addAll(_scanBarcode)
    }
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#009999', 'Cancelar', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode.add(barcodeScanRes);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('R2_N2 App 🤖'),
          centerTitle: true,
        ),
        body: Builder(
          builder: (BuildContext context) {
            return Container(
              alignment: Alignment.center,
              child: Flex(
                direction: Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Card(
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        maxLines: null,
                        minLines: 6,
                        readOnly: true,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: '$_scanBarcode\n'),
                      ),
                    ),
                  ),
                  TextField(
                    controller: tomboController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Insira o tombo',
                    ),
                  ),
                  TextField(
                    controller: destinoController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Insira o destino',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => scanQR(),
                    child: Icon(Icons.search_sharp),
                  ),
                  ElevatedButton(
                    onPressed: () => Api().createTombo(
                        tomboController.text.toString(),
                        destinoController.text.toString()),
                    child: Icon(Icons.api),
                  ),
                  ElevatedButton(
                    onPressed: () => Api().createTombo(
                        qrCodeController.toString(),
                        destinoController.text.toString()),
                    child: Icon(Icons.qr_code),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
