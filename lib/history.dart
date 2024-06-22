import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:parkirku/parkir.dart';
import 'package:parkirku/parkir_card.dart';
import 'package:parkirku/parkir_add.dart';
import 'package:parkirku/parkir_edit.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  Future<List<Parkir>> fetchParkir() async {
    final response =
        await http.get(Uri.parse('http://192.168.253.102:8080/parkir'));

    // print(response.statusCode);
    // print(response.body);

    if (response.statusCode == 200) {
      var getPostsData = json.decode(response.body) as List;
      var listPosts = getPostsData.map((i) => Parkir.fromJson(i)).toList();
      return listPosts;
    } else {
      throw Exception('Failed to load Posts');
    }
  }

  late Future<List<Parkir>> futurePosts;
  void navParkirAdd() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return const ParkirAdd();
    }));
  }

  void navParkirEdit(String data) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return ParkirEdit(id: data);
    }));
  }

  Future<void> delParkir(String data) async {
    final response =
        await http.delete(Uri.parse('http://192.168.253.102:8080/parkir/$data'));

    //print(response.statusCode);
    //print(response.body);

    if (response.statusCode == 200) {
      var getPostsData = json.decode(response.body);
      // print(getPostsData)['messages']);
      // print(getPostsData)['messages']['success']);
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
                          futurePosts = fetchParkir();
                        });
                        Navigator.pop(context, 'OK');
                      },
                      child: const Text('OK'))
                ],
              ));
    } else {
      showDialog<String>(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Message'),
          content: const Text("Failed to delete report!"),
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
    futurePosts = fetchParkir();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Riwayat',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.red.shade900,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          child: FutureBuilder<List<Parkir>>(
              future: futurePosts,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.separated(
                      itemBuilder: ((context, index) {
                        var get = (snapshot.data as List<Parkir>)[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ParkirCard(
                              parkir: Parkir(
                                idParkir: get.idParkir,
                                namaPengguna: get.namaPengguna,
                                nomorPlat: get.nomorPlat,
                                jenisKendaraan: get.jenisKendaraan,
                              ),
                              width: 20,
                            ),
                            Row(
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      navParkirEdit(get.idParkir);
                                    },
                                    child: const Icon(Icons.edit)),
                                ElevatedButton(
                                  onPressed: () {
                                    showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                              title: const Text('Message'),
                                              content: const Text(
                                                  "Apakah data akan dihapus?"),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(
                                                        context, 'Cancel');
                                                  },
                                                  child: const Text('Cancel'),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(
                                                        context, 'OK');
                                                    delParkir(get.idParkir);
                                                  },
                                                  child: const Text('OK'),
                                                ),
                                              ],
                                            ));
                                  },
                                  child: const Icon(Icons.delete),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5)
                          ],
                        );
                      }),
                      separatorBuilder: (context, index) {
                        return const Divider();
                      },
                      itemCount: (snapshot.data as List<Parkir>).length);
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const CircularProgressIndicator();
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: navParkirAdd,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
        ),
    );
  }
}
