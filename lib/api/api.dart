import 'package:dio/dio.dart';

class Api {
  void createTombo(String tombo, String destino) async {
    try {
      var response = await Dio().post('http://10.50.16.93:3000/ttrs/create',
          data: {'tombo': '$tombo', 'destino': '$destino'});
      print(response);
    } catch (e) {
      print(e);
    }
  }
}
