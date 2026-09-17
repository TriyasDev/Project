import '../models/dompet.dart';
import '../models/kategori.dart';
import '../models/transaksi.dart';

double hitungSaldo(
  Dompet dompet,
  List<Transaksi> daftarTransaksi,
  List<Kategori> daftarKategori,
) {
  double totalPerubahan = 0;

  for (final t in daftarTransaksi) {
    if (t.dompetId != dompet.id) continue;

    final kategori = daftarKategori.firstWhere((k) => k.id == t.kategoriId);
    if (kategori.jenis == JenisTransaksi.pemasukan) {
      totalPerubahan += t.jumlah;
    } else {
      totalPerubahan -= t.jumlah;
    }
  }

  return dompet.saldoAwal + totalPerubahan;
}