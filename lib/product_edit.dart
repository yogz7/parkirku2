import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
// import 'package:api/api/home_page.dart';
// import 'package:parkirku/home_page.dart';
import 'package:parkirku/home_page.dart';

class ProductEdit extends StatefulWidget {
  const ProductEdit({super.key, required this.id});

  final String id;

  @override
  State<ProductEdit> createState() => _ProductEditState();
}

class _ProductEditState extends State<ProductEdit> {
  late String idProduk;
  final apiUrl = "http://192.168.253.102:8080/produk/edit/";
  TextEditingController namaController = TextEditingController();
  TextEditingController hargaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    idProduk = widget.id;
    fetchProducts(idProduk);
  }

  Future<void> fetchProducts(String data) async {
    final response =
        await http.get(Uri.parse('http://192.168.253.102:8080/produk/$data'));
    // print(response.statusCode);
    // print(response.body);

    if (response.statusCode == 200) {
      var getPostsData = json.decode(response.body);
      setState(() {
        namaController.text = getPostsData['nama_produk'];
        hargaController.text = getPostsData['harga_produk'];
      });
    } else {
      throw Exception('Failed to load Posts');
    }
  }

  Future<void> updatePostRequest() async {
    var map = <String, dynamic>{};
    map['nama_produk'] = namaController.text;
    map['harga_produk'] = hargaController.text;
    var response = await http.post(Uri.parse(apiUrl + idProduk), body: map);
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
        title: const Text("Ubah Produk"),
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
              onPressed: updatePostRequest,
              child: const Text("Update Product"),
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
