class Usermodal {
  String? address;
  dynamic? phone;
  String? name;
  String? email;

  Usermodal({this.address, this.phone, this.name, this.email});

  Usermodal.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    phone = json['phone'];
    name = json['name'];
    email = json['email'];
  }
}
