import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
// import 'package:api/api/home_page.dart';
import 'package:parkirku/home_page.dart';


class ProductAdd extends StatefulWidget {
  const ProductAdd({super.key});

  @override
  State<ProductAdd> createState() => _ProductAddState();
}

class _ProductAddState extends State<ProductAdd> {
  final apiUrl = "http://192.168.253.102:8080/produk/create";
  final namaController = TextEditingController();
  final hargaController = TextEditingController();

  Future<void> sendPostRequest() async {
    var map = <String, dynamic>{};
    map['nama_produk'] = namaController.text;
    map['harga_produk'] = hargaController.text;
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
                navHomePage();
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
          content: const Text("Failed to create product!"),
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

  void navHomePage() {
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return const HomePage();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Produk "),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: namaController,
              decoration: const InputDecoration(hintText: "Nama Produk"),
            ),
            TextField(
              controller: hargaController,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              decoration: const InputDecoration(hintText: "Harga Produk"),
            ),
            ElevatedButton(
              onPressed: sendPostRequest,
              child: const Text("Add Product"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: navHomePage,
        tooltip: 'Increment',
        child: const Icon(Icons.home),
      ),
    );
  }
}
