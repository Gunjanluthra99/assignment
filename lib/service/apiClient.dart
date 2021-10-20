import 'dart:convert';
import 'dart:html';

import 'package:http/http.dart' as http;
import 'package:test_project/models/empData.dart';

class ApiClient {
  Future<List<Data>> getEmployeeList() async {
    List<Data> list = [];
    try {
      var url = Uri.parse('https://api.npoint.io/bb49708e26fb07b203a2');
      final response = await http.get(url);
      if (response.statusCode == HttpStatus.ok) {
        var content = response.body;
        var data = json.decode(content);
        final jsonResponse = json.decode(data);
        EmpData empData = EmpData.fromJson(jsonResponse);
        if (empData.status == "success") {
          return empData.data;
        }

        return list;
      }
    } catch (e) {
      print(e);
    }

    return list;
  }
}
