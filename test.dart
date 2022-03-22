import 'dart:io';

import "package:http/http.dart" as http;

void main() async {
  final request = await HttpClient().getUrl(Uri.parse(
      'https://raw.githubusercontent.com/MuhammedKpln/spamify/main/build.sh'));
  final responseBody = await request.close();
  responseBody.pipe(File('foo.txt').openWrite());
}
