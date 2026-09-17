// lib/screens/home_page.dart
import 'package:flutter/material.dart';
import '../models/dompet.dart';
import '../models/kategori.dart';
import '../models/transaksi.dart';
import '../data/kategori_default.dart';
import '../data/dompet_default.dart';
import '../logic/saldo.dart';
import 'form_tambah_transaksi.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Dompet _dompet = dompetDefault;
  final List<Kategori> _daftarKategori = kategoriDefault;
  final List<Transaksi> _daftarTransaksi = [];

  Kategori _kategoriDari(String id) {
    return _daftarKategori.firstWhere((k) => k.id == id);
  }

  Future<void> _bukaFormTambah() async {
    final transaksiBaru = await showModalBottomSheet<Transaksi>(
      context: context,
      isScrollControlled: true,
      builder: (context) => FormTambahTransaksi(
        dompetId: _dompet.id,
        daftarKategori: _daftarKategori,
      ),
    );

    if (transaksiBaru != null) {
      setState(() {
        _daftarTransaksi.add(transaksiBaru);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final saldo = hitungSaldo(_dompet, _daftarTransaksi, _daftarKategori);
    final transaksiTerurut = _daftarTransaksi.reversed.toList(); // terbaru di atas

    return Scaffold(
      appBar: AppBar(title: const Text('Keuanganku')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(_dompet.nama, style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 4),
                Text(
                  'Rp ${saldo.toStringAsFixed(0)}',
                  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: transaksiTerurut.isEmpty
                ? const Center(child: Text('Belum ada transaksi'))
                : ListView.builder(
                    itemCount: transaksiTerurut.length,
                    itemBuilder: (context, index) {
                      final t = transaksiTerurut[index];
                      final kategori = _kategoriDari(t.kategoriId);
                      final isPemasukan = kategori.jenis == JenisTransaksi.pemasukan;

                      return ListTile(
                        title: Text(kategori.nama),
                        subtitle: t.catatan != null ? Text(t.catatan!) : null,
                        trailing: Text(
                          '${isPemasukan ? '+' : '-'} Rp ${t.jumlah.toStringAsFixed(0)}',
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _bukaFormTambah,
        child: const Icon(Icons.add),
      ),
    );
  }
}