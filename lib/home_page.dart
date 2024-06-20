import 'package:flutter/material.dart';
import 'package:parkirku/product_card.dart';
import 'package:parkirku/product_add.dart';
import 'package:parkirku/product_edit.dart';
import 'package:http/http.dart' as http;
// import 'package:http/http.dart';
import 'dart:async';
import 'dart:convert';
import 'package:parkirku/product.dart';
// import 'product_card.dart';
// import 'products.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<Products>> fetchProducts() async {
    final response =
        await http.get(Uri.parse('http://192.168.253.102:8080/produk'));

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      var getPostsData = json.decode(response.body) as List;
      var listPosts = getPostsData.map((i) => Products.fromJson(i)).toList();
      return listPosts;
    } else {
      throw Exception('Failed to load Posts');
    }
  }

  late Future<List<Products>> futurePosts;

  void navProductAdd() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return const ProductAdd();
    }));
  }

  void navProductEdit(String data) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return ProductEdit(id: data);
    }));
  }

  Future<void> delProducts(String data) async {
    final response =
        await http.delete(Uri.parse('http://192.168.253.102:8080/produk/$data'));

    // print(response.statusCode);
    // print(response.body);

    if (response.statusCode == 200) {
      var getPostsData = json.decode(response.body);
      // print(getPostsData['messages']);
      // print(getPostsData['messages']['success']);
      showDialog<String>(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Message'),
          content: Text(getPostsData['messages']['success']),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                setState(() {
                  futurePosts = fetchProducts();
                });
                Navigator.pop(context, 'OK');
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );

      showDialog<String>(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Message'),
          content: const Text("Failed to delete product!"),
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

  @override
  void initState() {
    super.initState();
    futurePosts = fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: FutureBuilder<List<Products>>(
              future: futurePosts,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.separated(
                      itemBuilder: ((context, index) {
                        var post = (snapshot.data as List<Products>)[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ProductCard(
                              products: Products(
                                  idProduk: post.idProduk,
                                  namaProduk: post.namaProduk,
                                  hargaProduk: post.hargaProduk),
                              width: 20,
                            ),
                            Row(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    navProductEdit(post.idProduk);
                                  },
                                  child: const Icon(Icons.edit),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        title: const Text('Message'),
                                        content: const Text(
                                            "Apakah data akan di hapus?"),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context, 'Cancel');
                                            },
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context, 'OK');
                                              delProducts(post.idProduk);
                                            },
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  child: const Icon(Icons.delete),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20)
                          ],
                        );
                      }),
                      separatorBuilder: (context, index) {
                        return const Divider();
                      },
                      itemCount: (snapshot.data as List<Products>).length);
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const CircularProgressIndicator();
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: navProductAdd,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
