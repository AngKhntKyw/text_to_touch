import 'dart:typed_data';
import 'package:http/http.dart' as http;

Future<Uint8List?> fetchImageFromUrl(String url) async {
  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}
