class CustomerModel {
  String id;
  String name;
  String email;
  String address;
  String birthday;

  CustomerModel({
    required this.id,
    required this.name,
    required this.email,
    required this.address,
    required this.birthday,
  });
}

final List<CustomerModel> customersList = List.generate(100, (index) {
  return CustomerModel(
    id: (1000000000 + index).toString(),
    name: "${index+1}${index==0?"er":""}",
    address: "Address $index, City $index, State $index",
    email: "customer$index@example.com",
    birthday: "January ${index % 31 + 1}, ${1980 + (index % 40)}",
  );
});
