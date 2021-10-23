import 'dart:convert';

List<Order> modelUserFromJson(String str) => List<Order>.from(json.decode(str).map((x) => Order.fromJson(x)));

String modelUserToJson(List<Order> ordersdata) => json.encode(List<dynamic>.from(ordersdata.map((x) => x.toJson())));

class Order {
  String orderid;
  String transactionid;
  String transaction_date;
  String  product;
  String  brand;
  String  item;
  String price;
  String quantity;
  String amount;
  String  invoice;
  String invoicename;
  String shipping;
  String specification;

  Order({
    this.orderid ,
    this.transactionid,
    this.transaction_date,
    this. product,
    this.brand,
    this.item,
    this.price,
    this.quantity,
    this.amount,
    this.invoice,
    this.invoicename,
    this.shipping,
    this.specification
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
      orderid: json["orderid"],
      transactionid: json["transactionid"],
      transaction_date: json["transaction_date"],
      product: json["product"],
      brand: json["brand"],
      item: json["item"],
      price: json["price"],
      quantity: json["quantity"],
      amount: json["amount"],
      invoice: json["invoice"],
      invoicename: json["invoicename"],
      shipping: json["shipping"],
      specification:json["specification"]

  );

  Map<String, dynamic> toJson() => {
    "orderid": orderid,
    "transactionid": transactionid,
    "transaction_date": transaction_date,
    "product":  product,
    "brand":  brand,
    "item":  item,
    "price":  price,
    "quantity":  quantity,
    "amount": amount,
    "invoice":  invoice,
    "invoicename":invoicename,
    "shipping": shipping,
    "specification": specification,

  };
}
