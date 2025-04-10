import 'dart:convert';
import 'dart:html' as html; // Pour Flutter Web
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'customer_model.dart';

class PdfService {
  Future<void> printCustomersPdf(List<CustomerModel> data) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(20),
        build: (context) => [
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Archidiocèse de Brazzaville\nParoisse Sainte Rite\nMoukondo\nBP:14 511 Brazzaville',
                    style: pw.TextStyle(
                      fontSize: 14,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                    pw.Text(
                      'SUIVI DE LA QUÊTE \n ', /////*${DateTime.now().toLocal()}*/',
                      style: pw.TextStyle(fontSize: 12),
                    ),
                    pw.Text(
                        'Mois de :  Avril  ${DateTime.now().year}',
                      style: pw.TextStyle(fontSize: 12),
                    ),
                  ])
                ],
              ),
              pw.SizedBox(height: 10),
              pw.Divider(),
            ],
          ),
          pw.Table.fromTextArray(
            headers: ['JOURS', 'DATES', 'HEURES', 'MONTANT VERSE', 'SOLDE'],
            data: data
                .map((customer) => [
                      customer.id ?? '',
                      customer.name ?? '',
                      customer.email ?? '',
                      customer.address ?? '',
                      customer.birthday ?? '',
                    ])
                .toList(),
            headerStyle: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              fontSize: 12,
            ),
            cellStyle: const pw.TextStyle(fontSize: 10),
            cellAlignment: pw.Alignment.centerLeft,
            headerDecoration: const pw.BoxDecoration(
              color: PdfColors.grey300,
            ),
            cellPadding: const pw.EdgeInsets.all(5),
          ),
        ],
        footer: (context) => pw.Container(
          alignment: pw.Alignment.center,
          margin: const pw.EdgeInsets.only(top: 10),
          child: pw.Text(
            'Page ${context.pageNumber} / ${context.pagesCount}',
            style: const pw.TextStyle(fontSize: 10),
          ),
        ),
      ),
    );

    // Sauvegarder le PDF en base64 pour téléchargement web
    final bytes = await pdf.save();
    final base64Str = base64Encode(bytes);
    final blob = html.Blob([bytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..setAttribute("download", "report.pdf")
      ..click();
    html.Url.revokeObjectUrl(url);
  }
}
