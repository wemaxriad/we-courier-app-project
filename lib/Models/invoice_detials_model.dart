class InvoiceDetailsModel {
  int? id;
  String? invoiceId;
  String? status;
  String? totalDeliverdAmount;
  String? deliveryCharge;
  String? amount;
  String? codAmount;
  String? totalReturnFee;
  String? payableAmount;
  String? invoiceDate;
  String? merchantName;
  String? merchantPhone;
  String? merchantAddress;
  int? totalParcels;
  List <Parcels>? parcels;

  InvoiceDetailsModel(
      {this.id,
        this.invoiceId,
        this.status,
        this.totalDeliverdAmount,
        this.deliveryCharge,
        this.amount,
        this.codAmount,
        this.totalReturnFee,
        this.payableAmount,
        this.invoiceDate,
        this.merchantName,
        this.merchantPhone,
        this.merchantAddress,
        this.totalParcels,
        this.parcels});

  InvoiceDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    invoiceId = json['invoice_id'];
    status = json['status'];
    totalDeliverdAmount = json['total_deliverd_amount']!=null? json['total_deliverd_amount']:'0';
    deliveryCharge = json['delivery_charge'].toString();
    codAmount = json['cod_amount'];
    amount = json['amount']!=null? json['amount']:'0';
    totalReturnFee = json['total_return_fee'].toString();
    payableAmount = json['payable_amount'].toString();
    invoiceDate = json['invoice_date'];
    merchantName = json['merchant_name'];
    merchantPhone = json['merchant_phone'];
    merchantAddress = json['merchant_address'];
    totalParcels = json['total_parcels'];
    if (json['parcels'] != null) {
      parcels = <Parcels>[];
      json['parcels'].forEach((v) {
        parcels!.add(new Parcels.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['invoice_id'] = this.invoiceId;
    data['status'] = this.status;
    data['total_deliverd_amount'] = this.totalDeliverdAmount;
    data['delivery_charge'] = this.deliveryCharge;
    data['amount'] = this.amount;
    data['cod_amount'] = this.codAmount;
    data['total_return_fee'] = this.totalReturnFee;
    data['payable_amount'] = this.payableAmount;
    data['invoice_date'] = this.invoiceDate;
    data['merchant_name'] = this.merchantName;
    data['merchant_phone'] = this.merchantPhone;
    data['merchant_address'] = this.merchantAddress;
    data['total_parcels'] = this.totalParcels;


    if (this.parcels != null) {
      data['parcels'] = this.parcels!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class Parcels {
  int? id;
  String? customerName;
  String? customerPhone;
  String? invoiceNo;
  String? trackingId;
  String? status;
  String? cashCollection;
  String? deliveryCharge;
  String? codAmount;
  String? totalDeliveryAmount;
  String? currentPayable;

  Parcels(
      {this.id,
        this.customerName,
        this.customerPhone,
        this.invoiceNo,
        this.trackingId,
        this.status,
        this.cashCollection,
        this.deliveryCharge,
        this.codAmount,
        this.totalDeliveryAmount,
        this.currentPayable});

  Parcels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerName = json['customer_name'];
    customerPhone = json['customer_phone'];
    invoiceNo = json['invoice_no'];
    trackingId = json['tracking_id'];
    status = json['statusName'].toString();
    cashCollection = json['cash_collection'];
    deliveryCharge = json['delivery_charge'];
    codAmount = json['cod_amount'];
    totalDeliveryAmount = json['total_delivery_amount'];
    currentPayable = json['current_payable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_name'] = this.customerName;
    data['customer_phone'] = this.customerPhone;
    data['invoice_no'] = this.invoiceNo;
    data['tracking_id'] = this.trackingId;
    data['status'] = this.status;
    data['cash_collection'] = this.cashCollection;
    data['delivery_charge'] = this.deliveryCharge;
    data['cod_amount'] = this.codAmount;
    data['total_delivery_amount'] = this.totalDeliveryAmount;
    data['current_payable'] = this.currentPayable;
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