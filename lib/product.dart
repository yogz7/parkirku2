class Products {
  String idProduk;
  String namaProduk;
  String hargaProduk;

  Products(
      {required this.idProduk,
      required this.namaProduk,
      required this.hargaProduk});

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
        idProduk: json['id_produk'],
        namaProduk: json['nama_produk'],
        hargaProduk: json['harga_produk']);
  }
}
