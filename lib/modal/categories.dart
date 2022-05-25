class Categoriesmodal {
  String? status;
  String? response;
  String? error;

  Categoriesmodal.withError(String errorMessage) {
    error = errorMessage;
  }
  Categoriesmodal({this.status, this.response});

  Categoriesmodal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    response = json['response'];
  }
}
