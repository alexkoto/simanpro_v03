import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:simanpro_v03/models/kontrak_model.dart';
import 'package:simanpro_v03/services/api_connection.dart';

class KontrakService {
  static const String baseUrl = ApiConnection.baseUrl;

  // Get all kontrak
  static Future<List<Kontrak>> getAllKontrak() async {
    final response = await http.get(Uri.parse('$baseUrl/kontrak'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Kontrak.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load kontrak');
    }
  }

  // Get kontrak by ID
  static Future<Kontrak> getKontrakById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/kontrak/$id'));
    if (response.statusCode == 200) {
      return Kontrak.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load kontrak');
    }
  }

  // Get kontrak by Project Manager ID
  static Future<List<Kontrak>> getKontrakByProjectManager(
    int idProjectManager,
  ) async {
    final response = await http.get(
      Uri.parse('$baseUrl/kontrak/projectmanager/$idProjectManager'),
    );
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Kontrak.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load kontrak');
    }
  }

  // Get kontrak by Pemberi Kerja ID
  static Future<List<Kontrak>> getKontrakByPemberiKerja(
    int idPemberiKerja,
  ) async {
    final response = await http.get(
      Uri.parse('$baseUrl/kontrak/pemberikerja/$idPemberiKerja'),
    );
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Kontrak.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load kontrak');
    }
  }

  // Create new kontrak
  static Future<Kontrak> createKontrak(Kontrak kontrak) async {
    final response = await http.post(
      Uri.parse('$baseUrl/kontrak'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(kontrak.toJson()),
    );
    if (response.statusCode == 201) {
      return Kontrak.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create kontrak');
    }
  }

  // Update kontrak
  static Future<Kontrak> updateKontrak(Kontrak kontrak) async {
    final response = await http.put(
      Uri.parse('$baseUrl/kontrak/${kontrak.idKontrak}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(kontrak.toJson()),
    );
    if (response.statusCode == 200) {
      return Kontrak.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update kontrak');
    }
  }

  // Delete kontrak
  static Future<void> deleteKontrak(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/kontrak/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete kontrak');
    }
  }
}
