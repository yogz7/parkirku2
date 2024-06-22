import 'package:flutter/material.dart';

class akun extends StatefulWidget {
  const akun({Key? key}) : super(key: key);

  @override
  _akunState createState() => _akunState();
}

class _akunState extends State<akun> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Halaman Akun', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red.shade900,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'NAMA',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(
                labelText: 'NOMOR HP',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: addressController,
              decoration: InputDecoration(
                labelText: 'ALAMAT',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                // Aksi logout bisa ditambahkan di sini
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Log Out'),
                      content: Text('Anda yakin ingin log out?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Batal'),
                        ),
                        TextButton(
                          onPressed: () {
                            // Log out action
                            Navigator.of(context).pop();
                          },
                          child: Text('Ya'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Log Out'),
            ),
          ],
        ),
      ),
    );
  }
}
