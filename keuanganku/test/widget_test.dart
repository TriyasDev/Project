// test/widget_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keuanganku/main.dart'; // Menghapus duplikasi import yang rusak

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // SEBELUMNYA: const MyApp()
    // SEKARANG: Diubah menjadi KeuangankuApp() sesuai dengan nama class di main.dart
    await tester.pumpWidget(const KeuangankuApp());

    // Catatan: Jika di dalam HomePage() Anda tidak memiliki counter (angka 0 dan 1) 
    // atau tombol '+', tes di bawah ini kemungkinan besar akan gagal saat dijalankan.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
