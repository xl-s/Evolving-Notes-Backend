import "dart:convert";
import "constants.dart" as C;
import "package:flutter/material.dart";
import "package:http/http.dart" as http;

void main() => runApp(App());

Future<Response> requestGET(String url) async {
  final response = await http.get(url);
  if (response.statusCode != 200) throw Exception("Failed to load");
  return Response.fromJson(json.decode(response.body));
}

class Response {
  final String body;

  Response({this.body});

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(body: json["body"]);
  }
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[200],
        body: Home(),
      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<Response> request;

  @override
  void initState() {
    super.initState();
    request = requestGET(C.api);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<Response>(
        future: request,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.data.body);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
