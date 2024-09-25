class AdmiringDataResponse {
  int? status;
  List<AdmiringData>? data;
  String? message;

  AdmiringDataResponse({this.status, this.data, this.message});

  AdmiringDataResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <AdmiringData>[];
      json['data'].forEach((v) {
        data!.add(new AdmiringData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class AdmiringData {
  int? id;
  int? admireBy;
  int? admireToValue;
  String? status;
  String? createdAt;
  String? updatedAt;
  AdmireTo? admireTo;

  AdmiringData(
      {this.id,
        this.admireBy,
        this.admireToValue,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.admireTo});

  AdmiringData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    admireBy = json['admire_by'];
    admireToValue = json['admire_to'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    admireTo = json['AdmireTo'] != null
        ? new AdmireTo.fromJson(json['AdmireTo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['admire_by'] = this.admireBy;
    data['admire_to'] = this.admireToValue;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.admireTo != null) {
      data['AdmireTo'] = this.admireTo!.toJson();
    }
    return data;
  }
}

class AdmireTo {
  int? id;
  String? name;
  String? userName;
  String? age;
  String? country;
  String? employment;
  bool? subscriptionStatus;
  List<UserImagesWhileSignup>? userImagesWhileSignup;
  List<Subscriptions>? subscriptions;

  AdmireTo(
      {this.id,
        this.name,
        this.userName,
        this.age,
        this.country,
        this.employment,
        this.subscriptionStatus,
        this.userImagesWhileSignup,
        this.subscriptions});

  AdmireTo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    userName = json['user_name'];
    age = json['age'];
    country = json['country'];
    employment = json['employment'];
    subscriptionStatus = json['subscription_status'];
    if (json['user_images_while_signup'] != null) {
      userImagesWhileSignup = <UserImagesWhileSignup>[];
      json['user_images_while_signup'].forEach((v) {
        userImagesWhileSignup!.add(new UserImagesWhileSignup.fromJson(v));
      });
    }
    if (json['Subscriptions'] != null) {
      subscriptions = <Subscriptions>[];
      json['Subscriptions'].forEach((v) {
        subscriptions!.add(new Subscriptions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['user_name'] = this.userName;
    data['age'] = this.age;
    data['country'] = this.country;
    data['employment'] = this.employment;
    data['subscription_status'] = this.subscriptionStatus;
    if (this.userImagesWhileSignup != null) {
      data['user_images_while_signup'] =
          this.userImagesWhileSignup!.map((v) => v.toJson()).toList();
    }
    if (this.subscriptions != null) {
      data['Subscriptions'] =
          this.subscriptions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserImagesWhileSignup {
  int? id;
  int? userId;
  String? imageUrl;
  dynamic position;
  String? createdAt;
  String? updatedAt;

  UserImagesWhileSignup(
      {this.id,
        this.userId,
        this.imageUrl,
        this.position,
        this.createdAt,
        this.updatedAt});

  UserImagesWhileSignup.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    imageUrl = json['image_url'];
    position = json['position'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['image_url'] = this.imageUrl;
    data['position'] = this.position;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Subscriptions {
  int? id;
  int? userId;
  String? productId;
  dynamic purchaseDateMs;
  dynamic actualPrice;
  String? amount;
  dynamic purchaseDate;
  dynamic endDate;
  dynamic expireDateMs;
  bool? supscriptionStatus;
  dynamic appleSupscriptionGroupIdentifier;
  String? originalTransactionId;
  dynamic transactionId;
  String? platform;
  String? purchaseType;
  String? supscriptionType;
  dynamic currentInAppPurchaseStatus;
  String? subscriptionCode;
  String? currentStatus;
  String? customerCode;
  String? subscriptionValidationStatus;
  String? createdAt;
  String? updatedAt;

  Subscriptions(
      {this.id,
        this.userId,
        this.productId,
        this.purchaseDateMs,
        this.actualPrice,
        this.amount,
        this.purchaseDate,
        this.endDate,
        this.expireDateMs,
        this.supscriptionStatus,
        this.appleSupscriptionGroupIdentifier,
        this.originalTransactionId,
        this.transactionId,
        this.platform,
        this.purchaseType,
        this.supscriptionType,
        this.currentInAppPurchaseStatus,
        this.subscriptionCode,
        this.currentStatus,
        this.customerCode,
        this.subscriptionValidationStatus,
        this.createdAt,
        this.updatedAt});

  Subscriptions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    productId = json['product_id'];
    purchaseDateMs = json['purchase_date_ms'];
    actualPrice = json['actual_price'];
    amount = json['amount'];
    purchaseDate = json['purchase_date'];
    endDate = json['end_date'];
    expireDateMs = json['expire_date_ms'];
    supscriptionStatus = json['supscription_status'];
    appleSupscriptionGroupIdentifier =
    json['apple_supscription_group_identifier'];
    originalTransactionId = json['original_transaction_id'];
    transactionId = json['transaction_id'];
    platform = json['platform'];
    purchaseType = json['purchase_type'];
    supscriptionType = json['supscription_type'];
    currentInAppPurchaseStatus = json['current_InAppPurchase_status'];
    subscriptionCode = json['subscription_code'];
    currentStatus = json['current_status'];
    customerCode = json['customer_code'];
    subscriptionValidationStatus = json['subscription_validation_status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['product_id'] = this.productId;
    data['purchase_date_ms'] = this.purchaseDateMs;
    data['actual_price'] = this.actualPrice;
    data['amount'] = this.amount;
    data['purchase_date'] = this.purchaseDate;
    data['end_date'] = this.endDate;
    data['expire_date_ms'] = this.expireDateMs;
    data['supscription_status'] = this.supscriptionStatus;
    data['apple_supscription_group_identifier'] =
        this.appleSupscriptionGroupIdentifier;
    data['original_transaction_id'] = this.originalTransactionId;
    data['transaction_id'] = this.transactionId;
    data['platform'] = this.platform;
    data['purchase_type'] = this.purchaseType;
    data['supscription_type'] = this.supscriptionType;
    data['current_InAppPurchase_status'] = this.currentInAppPurchaseStatus;
    data['subscription_code'] = this.subscriptionCode;
    data['current_status'] = this.currentStatus;
    data['customer_code'] = this.customerCode;
    data['subscription_validation_status'] = this.subscriptionValidationStatus;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
