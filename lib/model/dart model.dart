class Model_class {
  String? date;
  List<Transactions>? transactions;

  Model_class({this.date, this.transactions});

  Model_class.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    if (json['transactions'] != null) {
      transactions = <Transactions>[];
      json['transactions'].forEach((v) {
        transactions!.add(new Transactions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    if (this.transactions != null) {
      data['transactions'] = this.transactions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Transactions {
  String? date;
  String? image;
  String? paymentMode;
  String? transactionType;
  String? beneficiary;
  String? amount;

  Transactions(
      {this.date,
        this.image,
        this.paymentMode,
        this.transactionType,
        this.beneficiary,
        this.amount});

  Transactions.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    image = json['image'];
    paymentMode = json['payment mode'];
    transactionType = json['transaction type'];
    beneficiary = json['beneficiary'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['image'] = this.image;
    data['payment mode'] = this.paymentMode;
    data['transaction type'] = this.transactionType;
    data['beneficiary'] = this.beneficiary;
    data['amount'] = this.amount;
    return data;
  }
}
