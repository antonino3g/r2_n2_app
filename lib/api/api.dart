import 'package:dio/dio.dart';

class Api {
  Future createTtr(int tecnicoId, String tombo, String destino,
      String responsavel, String observacao) async {
    try {
      var response =
          await Dio().post('http://10.50.16.93:3000/ttrs/create', data: {
        'n2_tecnico_id': tecnicoId,
        'tombo': '$tombo',
        'destino': '$destino',
        'responsavel': '$responsavel',
        'observacao': '$observacao'
      });
      print(response);
    } catch (e) {
      print(e);
    }
  }
}
