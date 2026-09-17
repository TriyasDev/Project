// lib/utils/format_rupiah.dart
import 'package:flutter/services.dart';

/// Mengelompokkan digit jadi format ribuan ala Indonesia: "5000" -> "5.000".
/// [angkaMentah] harus berupa string yang isinya digit saja.
String formatAngkaRibuan(String angkaMentah) {
  if (angkaMentah.isEmpty) return '';

  final buffer = StringBuffer();
  final digitTerbalik = angkaMentah.split('').reversed.toList();

  for (int i = 0; i < digitTerbalik.length; i++) {
    buffer.write(digitTerbalik[i]);
    final sudahTigaDigit = (i + 1) % 3 == 0;
    final masihAdaDigitLagi = i + 1 != digitTerbalik.length;
    if (sudahTigaDigit && masihAdaDigitLagi) {
      buffer.write('.');
    }
  }

  return buffer.toString().split('').reversed.join();
}

/// Format nilai numerik jadi tampilan "Rp 5.000" (dibulatkan, tanpa desimal).
String formatRupiah(num nilai) {
  final bulat = nilai.round();
  final tandaMinus = bulat < 0 ? '-' : '';
  final digitSaja = bulat.abs().toString();
  return '${tandaMinus}Rp ${formatAngkaRibuan(digitSaja)}';
}

/// TextInputFormatter yang otomatis nambahin titik ribuan
/// tiap kali user ngetik di TextField, mis. "5000" -> "5.000".
class RupiahInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digitSaja = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (digitSaja.isEmpty) {
      return const TextEditingValue(text: '');
    }

    final tanpaLeadingZero = int.parse(digitSaja).toString();
    final teksBaru = formatAngkaRibuan(tanpaLeadingZero);

    return TextEditingValue(
      text: teksBaru,
      selection: TextSelection.collapsed(offset: teksBaru.length),
    );
  }
}