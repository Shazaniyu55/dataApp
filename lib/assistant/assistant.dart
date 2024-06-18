import 'dart:convert';
import 'package:http/http.dart' as http;

class RequestAssistant {
  static Future<dynamic> sendPostRequest(String url, Map<String, dynamic> body,
      {Map<String, String>? headers}) async {
    try {
      // Define headers with default Content-Type as application/json
      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json',
      };

      // Add custom headers if provided
      if (headers != null) {
        requestHeaders.addAll(headers);
      }

      // Convert body to JSON
      String jsonBody = jsonEncode(body);

      // Make the POST request
      http.Response httpResponse = await http.post(
        Uri.parse(url),
        headers: requestHeaders,
        body: jsonBody,
      );

      // Check the status code and parse the response
      if (httpResponse.statusCode == 200) {
        var decodedResponse = jsonDecode(httpResponse.body);
        return decodedResponse;
      } else {
        // Return an error message with the status code
        return "Error Occurred. Status Code: ${httpResponse.statusCode}, Response: ${httpResponse.body}";
      }
    } catch (e) {
      // Catch and return any errors that occur during the request
      return "Error Occurred. Exception: $e";
    }
  }
}
