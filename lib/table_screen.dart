import 'package:flutter/material.dart';
import 'package:flutter_web_pdf_generate/customer_model.dart';
import 'package:flutter_web_pdf_generate/pdf_service.dart';

class TableScreen extends StatefulWidget {
  const TableScreen({Key? key}) : super(key: key);

  @override
  State<TableScreen> createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey),
        ),
        child: SingleChildScrollView(
          child: DataTable(
            columns: const [
              DataColumn(label: Text("jour")),
              DataColumn(label: Text("date")),
              DataColumn(label: Text("heure")),
              DataColumn(label: Text("montant verse")),
              DataColumn(label: Text("solde")),
            ],
            rows: customersList.map((customer) => DataRow(cells: [
              DataCell(Center(child: Text(customer.jour))),
              DataCell(Center(child: Text(customer.date))),
              DataCell(Center(child: Text(customer.heure))),
              DataCell(Center(child: Text(customer.montant_verse))),
              DataCell(Center(child: Text(customer.solde))),
            ])).toList(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          PdfService().printCustomersPdf(customersList);
        },
        child: const Icon(Icons.print),
      ),
    );
  }
}
