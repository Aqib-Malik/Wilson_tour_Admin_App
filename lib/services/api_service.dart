import 'package:http/http.dart' as http;
import 'dart:convert';
class ApiService {
  Future<List<dynamic>> fetchBookingLocations() async {
    final url = 'https://wilsontoursafrica.com/wp-json/wp/v2/booking-locations';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return jsonResponse['data'];
    } else {
      throw Exception('Failed to fetch booking locations');
    }
  }
}
