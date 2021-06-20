class Autogenerated {
  late String message;
  late Data data;
  late int statusCode;

  Autogenerated({required this.message, required this.data, required this.statusCode});

  Autogenerated.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = (json['data'] != null ? new Data.fromJson(json['data']) : null)!;
    statusCode = json['status_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['status_code'] = this.statusCode;
    return data;
  }
}

class Data {
  late String version;

  Data({required this.version});

  Data.fromJson(Map<String, dynamic> json) {
    version = json['version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['version'] = this.version;
    return data;
  }
}