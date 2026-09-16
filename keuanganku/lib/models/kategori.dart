enum JenisTransaksi { pemasukan, pengeluaran }

class Kategori {
  final String id;
  final String nama;
  final JenisTransaksi jenis;

  const Kategori({
    required this.id,
    required this.nama,
    required this.jenis,
  });
}