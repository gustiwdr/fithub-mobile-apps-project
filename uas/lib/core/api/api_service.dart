import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uas/domain/entities/company.dart';
import 'package:uas/domain/entities/service.dart';
import 'package:uas/domain/entities/trainer.dart';
import 'package:uas/domain/entities/user.dart';

class ApiService {
  final String baseUrl = "http://192.168.43.122/api";
  final String baseImageUrl = "http://192.168.43.122/storage/";

  // Fungsi untuk menyimpan token ke SharedPreferences
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  // Fungsi login
  Future<String> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    print('Email: $email');
    print('Password: $password');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final token = data['token'];

      // Simpan token setelah login berhasil
      if (token != null) {
        await saveToken(token); // Simpan token jika valid
      }

      return token; // Kembalikan token
    } else {
      throw Exception('Failed to login');
    }
  }

  // Fungsi untuk mendapatkan token dari SharedPreferences
  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null || token.isEmpty) {
      print("No token found in SharedPreferences");
    }
    return token ?? ''; // Jika token kosong, kembalikan string kosong
  }

  // Fungsi untuk mengambil semua perusahaan
  Future<List<Company>> getAllCompanies() async {
    final response = await http.get(Uri.parse('$baseUrl/admin/companies'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'];

      return data.map<Company>((companyData) {
        return Company.fromJson(companyData, baseImageUrl);
      }).toList();
    } else {
      throw Exception("Failed to load companies");
    }
  }

  // Fungsi untuk mengambil semua layanan
  Future<List<Service>> getAllServices() async {
    final response = await http.get(Uri.parse('$baseUrl/admin/services'));

    if (response.statusCode == 200) {
      final body = json.decode(response.body);

      if (body.containsKey('data') && body['data'] is List) {
        return (body['data'] as List)
            .map<Service>((serviceData) => Service.fromJson(serviceData))
            .toList();
      } else {
        throw Exception(
            "Invalid response format: 'data' is missing or not a list");
      }
    } else {
      throw Exception("Failed to load services: ${response.statusCode}");
    }
  }

  // Fungsi untuk mengambil semua trainer
  Future<List<Trainer>> getAllTrainers() async {
    final response = await http.get(Uri.parse('$baseUrl/admin/trainers'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'];

      // Convert data into Trainer objects
      return data.map<Trainer>((trainerData) {
        return Trainer.fromJson(trainerData);
      }).toList();
    } else {
      throw Exception("Failed to load trainers");
    }
  }

  // Di kelas ApiService, perbaiki method getLoggedInUser
  Future<User> getLoggedInUser(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/user'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json', // Tambahkan header ini
        },
      );

      print('User API Status: ${response.statusCode}');
      print('User API Response: ${response.body}'); // Debug response

      if (response.statusCode == 200) {
        return User.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in getLoggedInUser: $e');
      rethrow;
    }
  }
}
