import '../models/kategori.dart';
import '../utils/id_generator.dart';

final List<Kategori> kategoriDefault = [
  Kategori(id: buatId(), nama: 'Gaji', jenis: JenisTransaksi.pemasukan),
  Kategori(id: buatId(), nama: 'Bonus', jenis: JenisTransaksi.pemasukan),
  Kategori(id: buatId(), nama: 'Lainnya (Pemasukan)', jenis: JenisTransaksi.pemasukan),
  Kategori(id: buatId(), nama: 'Makan', jenis: JenisTransaksi.pengeluaran),
  Kategori(id: buatId(), nama: 'Transportasi', jenis: JenisTransaksi.pengeluaran),
  Kategori(id: buatId(), nama: 'Tagihan', jenis: JenisTransaksi.pengeluaran),
  Kategori(id: buatId(), nama: 'Belanja', jenis: JenisTransaksi.pengeluaran),
  Kategori(id: buatId(), nama: 'Hiburan', jenis: JenisTransaksi.pengeluaran),
  Kategori(id: buatId(), nama: 'Lainnya (Pengeluaran)', jenis: JenisTransaksi.pengeluaran),
];