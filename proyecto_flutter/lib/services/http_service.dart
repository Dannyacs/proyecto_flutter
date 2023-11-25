import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpService {
  final String apiUrl = 'http://10.0.2.2:8000/api';

  Future<List<dynamic>> mascotas() async {
    var respuesta = await http.get(Uri.parse(apiUrl + '/mascotas'));

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    }
    print(respuesta.statusCode);
    return [];
  }

  Future<LinkedHashMap<String, dynamic>> mascotasAgregar(String especie,
      String raza, String nombre, String fechaNacimiento, String sexo) async {
    var url = Uri.parse('$apiUrl/mascotas');
    var respuesta = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json'
      },
      body: json.encode(<String, dynamic>{
        'especie': especie,
        'raza': raza,
        'nombre': nombre,
        'fecha_nacimiento': fechaNacimiento,
        'sexo': sexo,
      }),
    );
    return json.decode(respuesta.body);
  }
}
