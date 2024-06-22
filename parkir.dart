class  Parkir{
  String idParkir;
  String namaPengguna;
  String nomorPlat;
  String jenisKendaraan;

  Parkir(
      {required this.idParkir,
      required this.namaPengguna,
      required this.nomorPlat,
      required this.jenisKendaraan,
      });
    
  factory Parkir.fromJson(Map<String, dynamic> json) {
    return Parkir(
      idParkir: json['id_parkir'],
      namaPengguna: json['nama_pengguna'],
      nomorPlat: json['nomor_plat'],
      jenisKendaraan: json['jenis_kendaraan'],
    );
  }
}
