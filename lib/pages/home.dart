import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:r2_n2/api/api.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  final formKey = GlobalKey<FormState>();

  int tecnicoID = 0;
  String tombo = '';
  String destino = '';
  String responsavel = '';
  String observacoes = '';

  TextEditingController tomboController = new TextEditingController();
  final tecnicoIdController = new TextEditingController();
  final destinoController = new TextEditingController();
  final responsavelController = new TextEditingController();
  final observacaoController = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<void> handleScanQR() async {
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
      tomboController.text = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('R2 N2 TTR CREATOR'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomCenter,
                colors: <Color>[Colors.black, Colors.blue]),
          ),
        ),
      ),
      body: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            Text(
              'TÉCNICO ID',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.blue[600],
                  fontSize: 18),
            ),
            SizedBox(height: 16),
            buildTecnicoId(),
            SizedBox(height: 16),
            Text(
              'TOMBO',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.blue[600],
                  fontSize: 18),
            ),
            SizedBox(height: 16),
            buildTombo(),
            SizedBox(height: 16),
            Text(
              'DESTINO',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.blue[600],
                  fontSize: 18),
            ),
            SizedBox(height: 16),
            buildDestino(),
            SizedBox(height: 16),
            Text(
              'RESPONSÁVEL',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.blue[600],
                  fontSize: 18),
            ),
            SizedBox(height: 16),
            buildResponsavel(),
            SizedBox(height: 16),
            Text(
              'OBSERVAÇÕES',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.blue[600],
                  fontSize: 18),
            ),
            SizedBox(height: 16),
            buildObservacao(),
            SizedBox(height: 16),
            buildSubmit(),
          ],
        ),
      ),
    );
  }

  Widget buildTecnicoId() => TextFormField(
        controller: tecnicoIdController,
        keyboardType: TextInputType.number,
        autofocus: false,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.keyboard),
          filled: false,
          fillColor: Colors.blueGrey[200],
          hintText: 'Insira seu ID',
          border: OutlineInputBorder(
            borderRadius: new BorderRadius.circular(15.0),
          ),
        ),
        validator: (value) {
          if (value != null && value.length < 1) {
            return 'O ID deve conter no mín 1 caractere';
          } else {
            return null; // form is valid
          }
        },
      );

  Widget buildTombo() => TextFormField(
        controller: tomboController,
        keyboardType: TextInputType.number,
        autofocus: false,
        decoration: InputDecoration(
          prefixIcon: IconButton(
              icon: Icon(Icons.qr_code_2),
              onPressed: () {
                handleScanQR();
                debugPrint('222');
              }),
          filled: false,
          fillColor: Color.fromARGB(191, 209, 255, 255),
          hintText: 'Clique no QR Code ou Digite...',
          border: OutlineInputBorder(
            borderRadius: new BorderRadius.circular(15.0),
          ),
        ),
        validator: (value) {
          if (tomboController.text == '-1' || tomboController.text == '') {
            tomboController.text = '';
            return 'Lembre-se de informar o TOMBO';
          } else {
            return null; // form is valid
          }
        },
      );

  Widget buildDestino() => TextFormField(
        keyboardType: TextInputType.number,
        controller: destinoController,
        autofocus: false,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.emoji_transportation),
          filled: false,
          fillColor: Color.fromARGB(191, 209, 255, 255),
          hintText: 'ex: 899',
          border: OutlineInputBorder(
            borderRadius: new BorderRadius.circular(15.0),
          ),
        ),
        onChanged: (value) => setState(
          () {
            destino = value;
          },
        ),
        validator: (value) {
          if (value != null && value.length < 1) {
            return 'O DESTINO deve conter no mín 1 caractere';
          } else {
            return null; // form is valid
          }
        },
      );

  Widget buildResponsavel() => TextFormField(
        controller: responsavelController,
        autofocus: false,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.emoji_people),
          filled: false,
          fillColor: Color.fromARGB(191, 209, 255, 255),
          hintText: '(opcional)',
          border: OutlineInputBorder(
            borderRadius: new BorderRadius.circular(15.0),
          ),
        ),
        onChanged: (value) => setState(
          () {
            observacoes = value;
          },
        ),
      );

  Widget buildObservacao() => TextFormField(
        controller: observacaoController,
        autofocus: false,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.notes),
          filled: false,
          fillColor: Color.fromARGB(191, 209, 255, 255),
          hintText: '(opcional)',
          border: OutlineInputBorder(
            borderRadius: new BorderRadius.circular(15.0),
          ),
        ),
      );

  Widget buildSubmit() => ElevatedButton(
      child: const Text('ENVIAR AO ROBÔ'),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(15.0),
        ),
      ),
      onPressed: () {
        final isValidForm = formKey.currentState!.validate();

        if (isValidForm) {
          showAlertDialogInitial(context);
        }
      });

  showAlertDialogInitial(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancelar"),
      onPressed: () {
        formKey.currentState!.validate();
        Navigator.pop(context, 'Cancel');
      },
    );
    Widget continueButton = TextButton(
      child: Text("Enviar"),
      onPressed: () {
        Navigator.pop(context, 'OK');
        showAlertSuccess(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Enviar para o robô"),
      content: Text("Gostaria de enviar esse pedido?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertSuccess(BuildContext context) {
    Widget sendPressed = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context, 'OK');
        sendToRobot();
      },
    );

    AlertDialog alertSuccess = AlertDialog(
      content: Text("Pedido de TTR enviado com sucesso!"),
      actions: [
        sendPressed,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertSuccess;
      },
    );
  }

  Future sendToRobot() async => {
        await Api().createTtr(
          int.parse(tecnicoIdController.text),
          tomboController.text.toString(),
          destinoController.text.toString(),
          responsavelController.text.toString(),
          observacaoController.text.toString(),
        ),
        debugPrint('$tecnicoIdController.text'),
        debugPrint('$tomboController.text'),
        debugPrint('$destinoController.text'),
        debugPrint('$responsavelController.text'),
        debugPrint('$observacaoController.text'),
      };
}
