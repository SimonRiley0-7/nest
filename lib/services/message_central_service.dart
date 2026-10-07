import 'dart:convert';
import 'package:http/http.dart' as http;

class MessageCentralService {
  static const String _baseUrl = 'https://cpaas.messagecentral.com';
  static const String _customerId = 'C-C01DE91DE9B64D7';
  static const String _email = 'shivamwadatkar16@gmail.com';
  static const String _password = 'Bharat#123';

  String? _authToken;

  // ─── Step 1: Get auth token ───────────────────────────────────────────────
  Future<String?> _getAuthToken() async {
    if (_authToken != null) return _authToken;

    try {
      // Password must be Base64-encoded as per MessageCentral docs
      final encodedPassword = base64.encode(utf8.encode(_password));

      final uri = Uri.parse(
        '$_baseUrl/auth/v1/authentication/token'
        '?country=IN'
        '&customerId=$_customerId'
        '&email=${Uri.encodeComponent(_email)}'
        '&key=$encodedPassword'
        '&scope=NEW',
      );

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _authToken = data['token'] as String?;
        return _authToken;
      } else {
        throw Exception('Auth failed: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('Error getting auth token: $e');
    }
  }

  // ─── Step 2: Send OTP ─────────────────────────────────────────────────────
  /// Returns [verificationId] used to validate OTP later.
  Future<String> sendOtp(String mobileNumber) async {
    final token = await _getAuthToken();
    if (token == null) throw Exception('Could not obtain auth token.');

    final uri = Uri.parse(
      '$_baseUrl/verification/v3/send'
      '?countryCode=91'
      '&customerId=$_customerId'
      '&flowType=SMS'
      '&mobileNumber=$mobileNumber',
    );

    final response = await http.post(
      uri,
      headers: {
        'authToken': token,
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final verificationId = data['data']?['verificationId']?.toString();
      if (verificationId == null) {
        throw Exception('No verificationId in response: ${response.body}');
      }
      return verificationId;
    } else {
      _authToken = null; // Clear token in case it expired
      throw Exception('Send OTP failed: ${response.statusCode} - ${response.body}');
    }
  }

  // ─── Step 3: Verify OTP ───────────────────────────────────────────────────
  /// Returns true if the OTP is correct, false otherwise.
  Future<bool> verifyOtp({
    required String mobileNumber,
    required String verificationId,
    required String otp,
  }) async {
    final token = await _getAuthToken();
    if (token == null) throw Exception('Could not obtain auth token.');

    final uri = Uri.parse(
      '$_baseUrl/verification/v3/validateOtp'
      '?countryCode=91'
      '&mobileNumber=$mobileNumber'
      '&verificationId=$verificationId'
      '&customerId=$_customerId'
      '&code=$otp',
    );

    final response = await http.get(
      uri,
      headers: {
        'authToken': token,
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final responseCode = data['responseCode']?.toString() ?? data['data']?['responseCode']?.toString();
      if (responseCode == '200') {
        return true;
      } else {
        throw Exception('Verify OTP Failed: responseCode=$responseCode, fullBody=${response.body}');
      }
    } else {
      throw Exception('Verify OTP HTTP Error: ${response.statusCode} - ${response.body}');
    }
  }
}
