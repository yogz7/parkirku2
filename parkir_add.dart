import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:parkirku/history.dart';

class ParkirAdd extends StatefulWidget {
  const ParkirAdd({super.key});

  @override
  State<ParkirAdd> createState() => _ParkirAddState();
}

class _ParkirAddState extends State<ParkirAdd> {
  final apiUrl = 'http://192.168.253.102:8080/parkir/create';
  final namaController = TextEditingController();
  final nomorController = TextEditingController();
  final jenisController = TextEditingController();

  Future<void> sendPostRequest() async {
    var map = <String, dynamic>{};
    map['nama_pengguna'] = namaController.text;
    map['nomor_plat'] = nomorController.text;
    map['jenis_kendaraan'] = jenisController.text;
    var response = await http.post(Uri.parse(apiUrl), body: map);
    // print(response.statusCode);
    // print(response.body);
    if (response.statusCode == 201) {
      var getPostsData = json.decode(response.body);
      showDialog<String>(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Message'),
          content: Text(getPostsData['messages']['success']),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                navHistory();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      showDialog<String>(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Message'),
          content: const Text("Failed to create report!"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context, 'OK');
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  void navHistory() {
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return const History();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tambah Parkir',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.red.shade900,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 15),
              TextField(
                controller: namaController,
                decoration: const InputDecoration(
                    hintText: "Nama Pengguna", border: OutlineInputBorder()),
              ),
              SizedBox(height: 15),
              TextField(
                controller: nomorController,
                decoration: const InputDecoration(
                    hintText: "Nomor Plat", border: OutlineInputBorder()),
              ),
              SizedBox(height: 15),
              TextField(
                controller: jenisController,
                decoration: const InputDecoration(
                    hintText: "Jenis Kendaraan", border: OutlineInputBorder()),
              ),
              ElevatedButton(
                onPressed: sendPostRequest,
                child: const Text("Kirim Data Parkir",
                    style: TextStyle(color: Colors.black)),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: navHistory,
        tooltip: 'Increment',
        child: const Icon(Icons.home),
      ),
    );
  }
}
