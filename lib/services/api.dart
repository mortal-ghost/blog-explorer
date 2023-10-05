import 'dart:convert';
import 'package:http/http.dart' as http;


class DataService {
  fetchBlogs() async {
    const String url = 'https://intent-kit-16.hasura.app/api/rest/blogs';
    const String adminSecret = '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6';

    try {
      final response = await http.get(Uri.parse(url), headers: {
        'x-hasura-admin-secret': adminSecret,
      });

      if (response.statusCode == 200) {
        // Response.body is a string, we need to convert it to a list of maps
        final blogs = jsonDecode(response.body);
        return blogs['blogs'];
      } else {
        // Request failed
        return null;
      }
    } catch (e) {
      // Handle any errors that occurred during the request
      return null;
    }
  }
}


