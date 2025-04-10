class CustomerModel {
  String jour;
  String date;
  String heure;
  String montant_verse;
  String solde;

  CustomerModel({
    required this.jour,
    required this.date,
    required this.heure,
    required this.montant_verse,
    required this.solde,
  });
}

final List<CustomerModel> customersList = List.generate(5, (index) {
  return CustomerModel(
    jour: (1000000000 + index).toString(),
    date: "${index+1}${index==0?"er":""}",
    heure: "Address $index, City $index, State $index",
    montant_verse: "customer$index@example.com",
    solde: "January ${index % 31 + 1}, ${1980 + (index % 40)}",
  );
});
