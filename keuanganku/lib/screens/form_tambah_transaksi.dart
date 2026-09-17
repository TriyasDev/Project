// lib/screens/form_tambah_transaksi.dart
import 'package:flutter/material.dart';
import '../models/kategori.dart';
import '../models/transaksi.dart';
import '../utils/id_generator.dart';

/// Bottom sheet buat nambah satu transaksi baru.
/// Kalau disimpan, widget ini "mengembalikan" objek Transaksi
/// lewat Navigator.pop(context, data) ke pemanggilnya.
class FormTambahTransaksi extends StatefulWidget {
  final String dompetId;
  final List<Kategori> daftarKategori;

  const FormTambahTransaksi({
    super.key,
    required this.dompetId,
    required this.daftarKategori,
  });

  @override
  State<FormTambahTransaksi> createState() => _FormTambahTransaksiState();
}

class _FormTambahTransaksiState extends State<FormTambahTransaksi> {
  final _jumlahController = TextEditingController();
  final _catatanController = TextEditingController();
  Kategori? _kategoriTerpilih;

  @override
  void dispose() {
    _jumlahController.dispose();
    _catatanController.dispose();
    super.dispose();
  }

  void _simpan() {
    final jumlah = double.tryParse(_jumlahController.text);

    if (_kategoriTerpilih == null || jumlah == null || jumlah <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pilih kategori dan isi jumlah yang benar')),
      );
      return;
    }

    final transaksiBaru = Transaksi(
      id: buatId(),
      dompetId: widget.dompetId,
      kategoriId: _kategoriTerpilih!.id,
      jumlah: jumlah,
      tanggal: DateTime.now(),
      catatan: _catatanController.text.isEmpty ? null : _catatanController.text,
    );

    Navigator.pop(context, transaksiBaru);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Tambah Transaksi', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          DropdownButtonFormField<Kategori>(
            initialValue: _kategoriTerpilih,
            decoration: const InputDecoration(labelText: 'Kategori'),
            items: widget.daftarKategori.map((k) {
              return DropdownMenuItem(value: k, child: Text(k.nama));
            }).toList(),
            onChanged: (nilai) => setState(() => _kategoriTerpilih = nilai),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _jumlahController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(labelText: 'Jumlah'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _catatanController,
            decoration: const InputDecoration(labelText: 'Catatan (opsional)'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _simpan,
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }
}