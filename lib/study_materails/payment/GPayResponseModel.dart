class GPayResponse {
  int? apiVersion;
  int? apiVersionMinor;
  PaymentMethodData? paymentMethodData;

  GPayResponse({this.apiVersion, this.apiVersionMinor, this.paymentMethodData});

  GPayResponse.fromJson(Map<String, dynamic> json) {
    apiVersion = json['apiVersion'];
    apiVersionMinor = json['apiVersionMinor'];
    paymentMethodData = json['paymentMethodData'] != null
        ? new PaymentMethodData.fromJson(json['paymentMethodData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['apiVersion'] = this.apiVersion;
    data['apiVersionMinor'] = this.apiVersionMinor;
    if (this.paymentMethodData != null) {
      data['paymentMethodData'] = this.paymentMethodData!.toJson();
    }
    return data;
  }
}

class PaymentMethodData {
  String? description;
  Info? info;
  TokenizationData? tokenizationData;
  String? type;

  PaymentMethodData(
      {this.description, this.info, this.tokenizationData, this.type});

  PaymentMethodData.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    info = json['info'] != null ? new Info.fromJson(json['info']) : null;
    tokenizationData = json['tokenizationData'] != null
        ? new TokenizationData.fromJson(json['tokenizationData'])
        : null;
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    if (this.info != null) {
      data['info'] = this.info!.toJson();
    }
    if (this.tokenizationData != null) {
      data['tokenizationData'] = this.tokenizationData!.toJson();
    }
    data['type'] = this.type;
    return data;
  }
}

class Info {
  BillingAddress? billingAddress;
  String? cardDetails;
  String? cardNetwork;

  Info({this.billingAddress, this.cardDetails, this.cardNetwork});

  Info.fromJson(Map<String, dynamic> json) {
    billingAddress = json['billingAddress'] != null
        ? new BillingAddress.fromJson(json['billingAddress'])
        : null;
    cardDetails = json['cardDetails'];
    cardNetwork = json['cardNetwork'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.billingAddress != null) {
      data['billingAddress'] = this.billingAddress!.toJson();
    }
    data['cardDetails'] = this.cardDetails;
    data['cardNetwork'] = this.cardNetwork;
    return data;
  }
}

class BillingAddress {
  String? address1;
  String? address2;
  String? address3;
  String? administrativeArea;
  String? countryCode;
  String? locality;
  String? name;
  String? phoneNumber;
  String? postalCode;
  String? sortingCode;

  BillingAddress(
      {this.address1,
        this.address2,
        this.address3,
        this.administrativeArea,
        this.countryCode,
        this.locality,
        this.name,
        this.phoneNumber,
        this.postalCode,
        this.sortingCode});

  BillingAddress.fromJson(Map<String, dynamic> json) {
    address1 = json['address1'];
    address2 = json['address2'];
    address3 = json['address3'];
    administrativeArea = json['administrativeArea'];
    countryCode = json['countryCode'];
    locality = json['locality'];
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    postalCode = json['postalCode'];
    sortingCode = json['sortingCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['address3'] = this.address3;
    data['administrativeArea'] = this.administrativeArea;
    data['countryCode'] = this.countryCode;
    data['locality'] = this.locality;
    data['name'] = this.name;
    data['phoneNumber'] = this.phoneNumber;
    data['postalCode'] = this.postalCode;
    data['sortingCode'] = this.sortingCode;
    return data;
  }
}

class TokenizationData {
  String? token;
  String? type;

  TokenizationData({this.token, this.type});

  TokenizationData.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['type'] = this.type;
    return data;
  }
}