class FirebaseError {
  Error? error;

  FirebaseError({this.error});

  FirebaseError.fromJson(Map<String, dynamic> json) {
    error = json['error'] != null ? Error.fromJson(json['error']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (error != null) {
      data['error'] = error!.toJson();
    }
    return data;
  }
}

class Error {
  List<Errors>? errors;
  int? code;
  String? message;

  Error({this.errors, this.code, this.message});

  Error.fromJson(Map<String, dynamic> json) {
    if (json['errors'] != null) {
      errors = <Errors>[];
      json['errors'].forEach((v) {
        errors!.add(Errors.fromJson(v));
      });
    }
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (errors != null) {
      data['errors'] = errors!.map((v) => v.toJson()).toList();
    }
    data['code'] = code;
    data['message'] = message;
    return data;
  }
}

class Errors {
  String? domain;
  String? reason;
  String? message;

  Errors({this.domain, this.reason, this.message});

  Errors.fromJson(Map<String, dynamic> json) {
    domain = json['domain'];
    reason = json['reason'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['domain'] = domain;
    data['reason'] = reason;
    data['message'] = message;
    return data;
  }
}
