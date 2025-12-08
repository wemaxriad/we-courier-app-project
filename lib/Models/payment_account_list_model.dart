class PaymentAccountListModel {
  bool? success;
  String? message;
  PaymentAccountListData? data;

  PaymentAccountListModel({this.success, this.message, this.data});

  PaymentAccountListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new PaymentAccountListData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class PaymentAccountListData {
  List<Accounts>? accounts;
  List<String>? methods;
  MobileBanks? mobileBanks;
  MobileBanks? banks;

  PaymentAccountListData({this.accounts, this.methods, this.mobileBanks, this.banks});

  PaymentAccountListData.fromJson(Map<String, dynamic> json) {
    if (json['accounts'] != null) {
      accounts = <Accounts>[];
      json['accounts'].forEach((v) {
        accounts!.add(new Accounts.fromJson(v));
      });
    }
    methods = json['methods'].cast<String>();
    mobileBanks = json['mobile_banks'] != null
        ? new MobileBanks.fromJson(json['mobile_banks'])
        : null;
    banks =
    json['banks'] != null ? new MobileBanks.fromJson(json['banks']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.accounts != null) {
      data['accounts'] = this.accounts!.map((v) => v.toJson()).toList();
    }
    data['methods'] = this.methods;
    if (this.mobileBanks != null) {
      data['mobile_banks'] = this.mobileBanks!.toJson();
    }
    if (this.banks != null) {
      data['banks'] = this.banks!.toJson();
    }
    return data;
  }
}

class Accounts {
  int? id;
  String? merchantId;
  String? paymentMethod;
  String? paymentMethodName;
  dynamic bankId;
  dynamic bankName;
  String? holderName;
  String? accountNo;
  String? branchName;
  String? routingNo;
  dynamic mobileBankId;
  dynamic mobileCompany;
  String? mobileNo;
  String? accountType;
  int? status;
  String? statusName;
  String? createdAt;
  String? updatedAt;

  Accounts(
      {this.id,
        this.merchantId,
        this.paymentMethod,
        this.paymentMethodName,
        this.bankId,
        this.bankName,
        this.holderName,
        this.accountNo,
        this.branchName,
        this.routingNo,
        this.mobileBankId,
        this.mobileCompany,
        this.mobileNo,
        this.accountType,
        this.status,
        this.statusName,
        this.createdAt,
        this.updatedAt});

  Accounts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    merchantId = json['merchant_id'];
    paymentMethod = json['payment_method'];
    paymentMethodName = json['paymentMethodName'];
    bankId = json['bank_id'];
    bankName = json['bank_name'];
    holderName = json['holder_name'];
    accountNo = json['account_no'];
    branchName = json['branch_name'];
    routingNo = json['routing_no'];
    mobileBankId = json['mobile_bank_id'];
    mobileCompany = json['mobile_company'];
    mobileNo = json['mobile_no'];
    accountType = json['account_type'];
    status = json['status'];
    statusName = json['statusName'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['merchant_id'] = this.merchantId;
    data['payment_method'] = this.paymentMethod;
    data['paymentMethodName'] = this.paymentMethodName;
    data['bank_id'] = this.bankId;
    data['bank_name'] = this.bankName;
    data['holder_name'] = this.holderName;
    data['account_no'] = this.accountNo;
    data['branch_name'] = this.branchName;
    data['routing_no'] = this.routingNo;
    data['mobile_bank_id'] = this.mobileBankId;
    data['mobile_company'] = this.mobileCompany;
    data['mobile_no'] = this.mobileNo;
    data['account_type'] = this.accountType;
    data['status'] = this.status;
    data['statusName'] = this.statusName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class MobileBanks {
  int? currentPage;
  List<BankData>? data;
  String? firstPageUrl;
  dynamic from;
  dynamic lastPage;
  String? lastPageUrl;
  List<Links>? links;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  MobileBanks(
      {this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.links,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total});

  MobileBanks.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <BankData>[];
      json['data'].forEach((v) {
        data!.add(new BankData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class BankData {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;

  BankData({this.id, this.name, this.createdAt, this.updatedAt});

  BankData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
    return data;
  }
}
