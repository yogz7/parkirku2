import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:parkirku/history.dart';

class ParkirEdit extends StatefulWidget {
  const ParkirEdit({super.key, required this.id});

  final String id;

  @override
  State<ParkirEdit> createState() => _ParkirEditState();
}

class _ParkirEditState extends State<ParkirEdit> {
  late String idParkir;
  final apiUrl = 'http://192.168.253.102:8080/parkir/edit/';
  TextEditingController namaController = TextEditingController();
  TextEditingController nomorController = TextEditingController();
  TextEditingController jenisController = TextEditingController();

  @override
  void initState() {
    super.initState();
    idParkir = widget.id;
    fetchProducts(idParkir);
  }

  Future<void> fetchProducts(String data) async {
    final response =
        await http.get(Uri.parse('http://192.168.253.102:8080/parkir/$data'));
    // print(response.statusCode);
    // print(response.body);

    if (response.statusCode == 200) {
      var getPostsData = json.decode(response.body);
      setState(() {
        namaController.text = getPostsData['nama_pengguna'];
        nomorController.text = getPostsData['nomor_plat'];
        jenisController.text = getPostsData['jenis_kendaraan'];
      });
    } else {
      throw Exception('Failed to load Posts');
    }
  }

  Future<void> updatePostRequest() async {
    var map = <String, dynamic>{};
    map['nama_pengguna'] = namaController.text;
    map['nomor_plat'] = nomorController.text;
    map['jenis_kendaraan'] = jenisController.text;
    var response = await http.post(Uri.parse(apiUrl + idParkir), body: map);
    // print(response.statusCode);
    // print(response.body);

    if (response.statusCode == 200) {
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
          content: const Text("Failed to update data!"),
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
          'Ubah Parkir',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.red.shade900,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: namaController,
              decoration: const InputDecoration(hintText: "Nama Pengguna"),
            ),
            TextField(
              controller: nomorController,
              decoration: const InputDecoration(hintText: "Nomor Plat"),
            ),
            TextField(
              controller: jenisController,
              decoration: const InputDecoration(hintText: "Jenis kendaraan"),
            ),
            ElevatedButton(
              onPressed: updatePostRequest,
              child: const Text("Update Parkir"),
            ),
          ],
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
