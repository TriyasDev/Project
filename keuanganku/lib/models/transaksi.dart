class Transaksi {
  final String id;
  final String dompetId;
  final String kategoriId;
  final double jumlah;
  final DateTime tanggal;
  final String? catatan;

  const Transaksi({
    required this.id,
    required this.dompetId,
    required this.kategoriId,
    required this.jumlah,
    required this.tanggal,
    this.catatan,
  });
}