import 'package:http/http.dart' as http;
class NetworkInterface{
  final http.Client httpClient = http.Client();
  
  NetworkInterface();
}