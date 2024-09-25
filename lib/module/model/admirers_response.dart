class AdmirersResponse {
  int? status;
  List<AdmirersData>? data;
  String? message;

  AdmirersResponse({this.status, this.data, this.message});

  AdmirersResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <AdmirersData>[];
      json['data'].forEach((v) {
        data!.add(new AdmirersData.fromJson(v));
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

class AdmirersData {
  int? id;
  int? admireTo;
  String? status;
  String? createdAt;
  String? updatedAt;
  AdmireBy? admireBy;

  AdmirersData(
      {this.id,
        this.admireTo,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.admireBy});

  AdmirersData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    admireTo = json['admire_to'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    admireBy = json['AdmireBy'] != null
        ? new AdmireBy.fromJson(json['AdmireBy'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['admire_to'] = this.admireTo;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.admireBy != null) {
      data['AdmireBy'] = this.admireBy!.toJson();
    }
    return data;
  }
}

class AdmireBy {
  int? id;
  String? name;
  String? userName;
  dynamic age;
  dynamic country;
  dynamic employment;
  List<UserImagesWhileSignup>? userImagesWhileSignup;

  AdmireBy(
      {this.id,
        this.name,
        this.userName,
        this.age,
        this.country,
        this.employment,
        this.userImagesWhileSignup});

  AdmireBy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    userName = json['user_name'];
    age = json['age'];
    country = json['country'];
    employment = json['employment'];
    if (json['user_images_while_signup'] != null) {
      userImagesWhileSignup = <UserImagesWhileSignup>[];
      json['user_images_while_signup'].forEach((v) {
        userImagesWhileSignup!.add(new UserImagesWhileSignup.fromJson(v));
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
    if (this.userImagesWhileSignup != null) {
      data['user_images_while_signup'] =
          this.userImagesWhileSignup!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class UserImagesWhileSignup {
  String? imageUrl;

  UserImagesWhileSignup({this.imageUrl});

  UserImagesWhileSignup.fromJson(Map<String, dynamic> json) {
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image_url'] = this.imageUrl;
    return data;
  }
}