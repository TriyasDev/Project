// lib/data/dompet_default.dart
import '../models/dompet.dart';
import '../utils/id_generator.dart';

final Dompet dompetDefault = Dompet(
  id: buatId(),
  nama: 'Cash',
  saldoAwal: 0,
);