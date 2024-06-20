import 'package:flutter/material.dart';

class SetorkanSampahPage extends StatefulWidget {
  @override
  _SetorkanSampahPageState createState() => _SetorkanSampahPageState();
}

class _SetorkanSampahPageState extends State<SetorkanSampahPage> {
  String? jenisSampah;
  String? namaSampah;
  double? beratSampah;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.red.shade900,
        title: Text('Mulai Parkir'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Jenis Kendaraan',
                  prefixIcon: Icon(Icons.car_crash_sharp),
                ),
                items: ['Mobil', 'Truck', 'Bus'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    jenisSampah = newValue;
                  });
                },
                validator: (value) => value == null ? 'Pilih jenis kendaraan' : null,
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Nama Pemilik Kendaraan',
                  prefixIcon: Icon(Icons.man_2_outlined),
                ),
                onChanged: (newValue) {
                  setState(() {
                    namaSampah = newValue;
                  });
                },
                validator: (value) => value == null || value.isEmpty ? 'Masukkan Nama Anda' : null,
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Plat Nomor',
                  prefixIcon: Icon(Icons.add_card),
                ),
                keyboardType: TextInputType.number,
                onChanged: (newValue) {
                  setState(() {
                    beratSampah = double.tryParse(newValue);
                  });
                },
                validator: (value) => value == null || value.isEmpty ? 'Masukkan No. Plat' : null,
              ),
              SizedBox(height: 32.0,),
              // Colors.red,
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Handle form submission
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Data berhasil disetorkan')),
                    );
                  }
                },
                child: Text('Parkir')
              ),
            ],
          ),
        ),
      ),
    );
  }
}
