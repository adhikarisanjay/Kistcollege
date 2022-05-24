class AuthUser {
  int? id;
  String? firstName;
  String? middleName;
  String? lastName;
  Null? address;
  String? email;
  Null? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  Null? dob;
  String? error;

  AuthUser.withError(String errorMessage) {
    error = errorMessage;
  }
  AuthUser(
      {this.id,
      this.firstName,
      this.middleName,
      this.lastName,
      this.address,
      this.email,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt,
      this.dob});

  AuthUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    address = json['address'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    dob = json['dob'];
  }
}
