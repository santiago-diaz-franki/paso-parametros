import 'dart:convert';
import 'dart:io';
import 'package:hola_mundo/models/chiste.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hola_mundo/views/chiste/api_exceptions.dart';

class ChistesService {
  final String apiUrl = dotenv.env['CHISTE_API_URL']!;

  Future<List<Chiste>> getChistes({int limit = 5}) async {
    List<Chiste> chistesList = [];

    try {
      for (int i = 0; i < limit; i++) {
        final response = await http.get(Uri.parse('$apiUrl/random'));

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          chistesList.add(Chiste.fromJson(data));
        } else {
          throw ServerException(response.statusCode);
        }
      }
    } on SocketException {
      throw NoInternetException();
    } catch (_) {
      throw UnexpectedException();
    }

    return chistesList;
  }

  Future<Chiste> getChisteById(String id) async {
    try {
      final response = await http.get(Uri.parse('$apiUrl/$id'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Chiste.fromJson(data);
      } else {
        throw ServerException(response.statusCode);
      }
    } on SocketException {
      throw NoInternetException();
    } catch (_) {
      throw UnexpectedException();
    }
  }
}
