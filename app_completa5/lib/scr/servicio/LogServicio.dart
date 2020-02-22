import 'dart:convert';
import 'package:app_completa5/scr/modelo/Log.dart';
import 'package:http/http.dart' as http;

class LogProvider{
  final String _url = "https://optativa-log-cd9e6.firebaseio.com";

  Future<bool> crearLog(Log log) async{
    final url = '$_url/log.json';
    final response = await http.post(url, body: logModelToJson(log));
    final decodeData = json.decode(response.body);
    print(decodeData);
    return true;
  }

  final String _urlF = "https://optativa-log-cd9e6.firebaseio.com/log/-M0K90rKO0Akij2KZPLA.json";
  //final String _urlF = "https://optativa-log-cd9e6.firebaseio.com/log.json";
  Future<String> getFechas()async{
    String url = "$_urlF";
    print(url);
    http.Response res = await http.get(
      Uri.encodeFull(url),
      headers: {
        "Accept": "application/json"
      }
    );
    final decode = await json.decode(res.body);
    print(decode);
    //final fecha = new Logs.fromJsonList(decode);
    print(decode['fecha'].toString());
    //print('La fecha es');
    //print(fecha.lista[0].fecha);
    return decode['fecha'].toString();
  }
  
}