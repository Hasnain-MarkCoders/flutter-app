class BlockResponse {
  int? status;
  List<BlockData>? data;
  String? message;

  BlockResponse({this.status, this.data, this.message});

  BlockResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <BlockData>[];
      json['data'].forEach((v) {
        data!.add(new BlockData.fromJson(v));
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

class BlockData {
  int? id;
  bool? status;
  int? blockBy;
  int? blockToId;
  String? createdAt;
  String? updatedAt;
  BlockTo? blockTo;

  BlockData(
      {this.id,
        this.status,
        this.blockBy,
        this.blockToId,
        this.createdAt,
        this.updatedAt,
        this.blockTo});

  BlockData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    blockBy = json['block_by'];
    blockToId = json['block_to'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    blockTo =
    json['blockTo'] != null ? new BlockTo.fromJson(json['blockTo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['block_by'] = this.blockBy;
    data['block_to'] = this.blockTo;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.blockTo != null) {
      data['blockTo'] = this.blockTo!.toJson();
    }
    return data;
  }
}

class BlockTo {
  int? id;
  String? userName;
  String? email;
  String? password;
  String? referCode;
  String? deviceType;
  dynamic deviceToken;
  String? name;
  String? age;
  String? gender;
  String? interestedIn;
  String? status;
  String? bodyType;
  String? height;
  String? education;
  String? employment;
  String? residenceCountry;
  String? state;
  String? city;
  String? nationality;
  String? religion;
  String? yourTribe;
  String? tribeIrrelevant;
  String? ageRangeForDate;
  String? tribeToDate;
  String? lookingFor;
  int? profileStatus;
  String? aboutMe;
  String? userPhysicalSize;
  String? userPhysicalFront;
  String? userPhysicalHeight;
  String? userPhysicalGlasses;
  String? userPhysicalBackend;
  String? userPhysicalFacial;
  String? characterAmPrude;
  String? characterAmForgiving;
  String? characterAmDecisional;
  String? characterAmJudgemental;
  String? characterAmPeoplePerson;
  String? characterAmBestUnderPressure;
  String? characterAmStrongWilledPerson;
  String? characterFolksSeeMeAsGoodguy;
  String? characterAttractionInIndividual;
  String? characterAmDependableAndReliable;
  String? characterAttractionInRelationship;
  String? characterAmRebelNeverDoThingsNormalWay;
  String? characterCannotDateBelowMySocioEconomic;
  String? characterIDontCareWhatPeopleSayAboutme;
  String? characterAmOutgoingAndMakeAnywhereExciting;
  String? chooseAnyOne;
  bool? floorStatus;
  Verification? verification;
  String? country;
  bool? facebookVerificationStatus;
  bool? governmentIdVerificationStatus;
  bool? poseVerificationStatus;
  bool? photoVerificationStatus;
  bool? mobileNumberVerificationStatus;
  String? photosForVerification;
  String? activeAt;
  bool? subscriptionStatus;
  String? subscriptionValidationStatus;
  bool? isEmailVerified;
  bool? isUserVerified;
  String? mobileNumber;
  int? otpVerification;
  String? contryCode;
  String? suspendedDate;
  bool? isAdmin;
  String? userStatus;
  String? userVerification;
  dynamic attributeStatus;
  bool? createpostIMOTF;
  bool? resolveByAdmin;
  bool? deleteByAdmin;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  List<UserImagesWhileSignup>? userImagesWhileSignup;

  BlockTo(
      {this.id,
        this.userName,
        this.email,
        this.password,
        this.referCode,
        this.deviceType,
        this.deviceToken,
        this.name,
        this.age,
        this.gender,
        this.interestedIn,
        this.status,
        this.bodyType,
        this.height,
        this.education,
        this.employment,
        this.residenceCountry,
        this.state,
        this.city,
        this.nationality,
        this.religion,
        this.yourTribe,
        this.tribeIrrelevant,
        this.ageRangeForDate,
        this.tribeToDate,
        this.lookingFor,
        this.profileStatus,
        this.aboutMe,
        this.userPhysicalSize,
        this.userPhysicalFront,
        this.userPhysicalHeight,
        this.userPhysicalGlasses,
        this.userPhysicalBackend,
        this.userPhysicalFacial,
        this.characterAmPrude,
        this.characterAmForgiving,
        this.characterAmDecisional,
        this.characterAmJudgemental,
        this.characterAmPeoplePerson,
        this.characterAmBestUnderPressure,
        this.characterAmStrongWilledPerson,
        this.characterFolksSeeMeAsGoodguy,
        this.characterAttractionInIndividual,
        this.characterAmDependableAndReliable,
        this.characterAttractionInRelationship,
        this.characterAmRebelNeverDoThingsNormalWay,
        this.characterCannotDateBelowMySocioEconomic,
        this.characterIDontCareWhatPeopleSayAboutme,
        this.characterAmOutgoingAndMakeAnywhereExciting,
        this.chooseAnyOne,
        this.floorStatus,
        this.verification,
        this.country,
        this.facebookVerificationStatus,
        this.governmentIdVerificationStatus,
        this.poseVerificationStatus,
        this.photoVerificationStatus,
        this.mobileNumberVerificationStatus,
        this.photosForVerification,
        this.activeAt,
        this.subscriptionStatus,
        this.subscriptionValidationStatus,
        this.isEmailVerified,
        this.isUserVerified,
        this.mobileNumber,
        this.otpVerification,
        this.contryCode,
        this.suspendedDate,
        this.isAdmin,
        this.userStatus,
        this.userVerification,
        this.attributeStatus,
        this.createpostIMOTF,
        this.resolveByAdmin,
        this.deleteByAdmin,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.userImagesWhileSignup});

  BlockTo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['user_name'];
    email = json['email'];
    password = json['password'];
    referCode = json['refer_code'];
    deviceType = json['device_type'];
    deviceToken = json['device_token'];
    name = json['name'];
    age = json['age'];
    gender = json['gender'];
    interestedIn = json['interested_in'];
    status = json['status'];
    bodyType = json['body_type'];
    height = json['height'];
    education = json['education'];
    employment = json['employment'];
    residenceCountry = json['residence_country'];
    state = json['state'];
    city = json['city'];
    nationality = json['nationality'];
    religion = json['religion'];
    yourTribe = json['your_tribe'];
    tribeIrrelevant = json['tribe_irrelevant'];
    ageRangeForDate = json['age_range_for_date'];
    tribeToDate = json['tribe_to_date'];
    lookingFor = json['looking_for'];
    profileStatus = json['profile_status'];
    aboutMe = json['about_me'];
    userPhysicalSize = json['user_physical_size'];
    userPhysicalFront = json['user_physical_front'];
    userPhysicalHeight = json['user_physical_height'];
    userPhysicalGlasses = json['user_physical_glasses'];
    userPhysicalBackend = json['user_physical_backend'];
    userPhysicalFacial = json['user_physical_facial'];
    characterAmPrude = json['character_am_prude'];
    characterAmForgiving = json['character_am_forgiving'];
    characterAmDecisional = json['character_am_decisional'];
    characterAmJudgemental = json['character_am_judgemental'];
    characterAmPeoplePerson = json['character_am_people_person'];
    characterAmBestUnderPressure = json['character_am_best_under_pressure'];
    characterAmStrongWilledPerson = json['character_am_strong_willed_person'];
    characterFolksSeeMeAsGoodguy = json['character_folks_see_me_as_goodguy'];
    characterAttractionInIndividual =
    json['character_attraction_in_individual'];
    characterAmDependableAndReliable =
    json['character_am_dependable_and_reliable'];
    characterAttractionInRelationship =
    json['character_attraction_in_relationship'];
    characterAmRebelNeverDoThingsNormalWay =
    json['character_am_rebel_never_do_things_normal_way'];
    characterCannotDateBelowMySocioEconomic =
    json['character_cannot_date_below_my_socio_economic'];
    characterIDontCareWhatPeopleSayAboutme =
    json['character_i_dont_care_what_people_say_aboutme'];
    characterAmOutgoingAndMakeAnywhereExciting =
    json['character_am_outgoing_and_make_anywhere_exciting'];
    chooseAnyOne = json['choose_any_one'];
    floorStatus = json['floor_status'];
    verification = json['verification'] != null
        ? new Verification.fromJson(json['verification'])
        : null;
    country = json['country'];
    facebookVerificationStatus = json['facebook_verification_status'];
    governmentIdVerificationStatus = json['government_id_verification_status'];
    poseVerificationStatus = json['pose_verification_status'];
    photoVerificationStatus = json['photo_verification_status'];
    mobileNumberVerificationStatus = json['mobile_number_verification_status'];
    photosForVerification = json['photos_for_verification'];
    activeAt = json['active_at'];
    subscriptionStatus = json['subscription_status'];
    subscriptionValidationStatus = json['subscription_validation_status'];
    isEmailVerified = json['isEmailVerified'];
    isUserVerified = json['isUserVerified'];
    mobileNumber = json['mobile_number'];
    otpVerification = json['otp_verification'];
    contryCode = json['contry_code'];
    suspendedDate = json['suspended_date'];
    isAdmin = json['is_admin'];
    userStatus = json['user_status'];
    userVerification = json['user_verification'];
    attributeStatus = json['attributeStatus'];
    createpostIMOTF = json['createpostIMOTF'];
    resolveByAdmin = json['resolve_by_admin'];
    deleteByAdmin = json['delete_by_admin'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
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
    data['user_name'] = this.userName;
    data['email'] = this.email;
    data['password'] = this.password;
    data['refer_code'] = this.referCode;
    data['device_type'] = this.deviceType;
    data['device_token'] = this.deviceToken;
    data['name'] = this.name;
    data['age'] = this.age;
    data['gender'] = this.gender;
    data['interested_in'] = this.interestedIn;
    data['status'] = this.status;
    data['body_type'] = this.bodyType;
    data['height'] = this.height;
    data['education'] = this.education;
    data['employment'] = this.employment;
    data['residence_country'] = this.residenceCountry;
    data['state'] = this.state;
    data['city'] = this.city;
    data['nationality'] = this.nationality;
    data['religion'] = this.religion;
    data['your_tribe'] = this.yourTribe;
    data['tribe_irrelevant'] = this.tribeIrrelevant;
    data['age_range_for_date'] = this.ageRangeForDate;
    data['tribe_to_date'] = this.tribeToDate;
    data['looking_for'] = this.lookingFor;
    data['profile_status'] = this.profileStatus;
    data['about_me'] = this.aboutMe;
    data['user_physical_size'] = this.userPhysicalSize;
    data['user_physical_front'] = this.userPhysicalFront;
    data['user_physical_height'] = this.userPhysicalHeight;
    data['user_physical_glasses'] = this.userPhysicalGlasses;
    data['user_physical_backend'] = this.userPhysicalBackend;
    data['user_physical_facial'] = this.userPhysicalFacial;
    data['character_am_prude'] = this.characterAmPrude;
    data['character_am_forgiving'] = this.characterAmForgiving;
    data['character_am_decisional'] = this.characterAmDecisional;
    data['character_am_judgemental'] = this.characterAmJudgemental;
    data['character_am_people_person'] = this.characterAmPeoplePerson;
    data['character_am_best_under_pressure'] =
        this.characterAmBestUnderPressure;
    data['character_am_strong_willed_person'] =
        this.characterAmStrongWilledPerson;
    data['character_folks_see_me_as_goodguy'] =
        this.characterFolksSeeMeAsGoodguy;
    data['character_attraction_in_individual'] =
        this.characterAttractionInIndividual;
    data['character_am_dependable_and_reliable'] =
        this.characterAmDependableAndReliable;
    data['character_attraction_in_relationship'] =
        this.characterAttractionInRelationship;
    data['character_am_rebel_never_do_things_normal_way'] =
        this.characterAmRebelNeverDoThingsNormalWay;
    data['character_cannot_date_below_my_socio_economic'] =
        this.characterCannotDateBelowMySocioEconomic;
    data['character_i_dont_care_what_people_say_aboutme'] =
        this.characterIDontCareWhatPeopleSayAboutme;
    data['character_am_outgoing_and_make_anywhere_exciting'] =
        this.characterAmOutgoingAndMakeAnywhereExciting;
    data['choose_any_one'] = this.chooseAnyOne;
    data['floor_status'] = this.floorStatus;
    if (this.verification != null) {
      data['verification'] = this.verification!.toJson();
    }
    data['country'] = this.country;
    data['facebook_verification_status'] = this.facebookVerificationStatus;
    data['government_id_verification_status'] =
        this.governmentIdVerificationStatus;
    data['pose_verification_status'] = this.poseVerificationStatus;
    data['photo_verification_status'] = this.photoVerificationStatus;
    data['mobile_number_verification_status'] =
        this.mobileNumberVerificationStatus;
    data['photos_for_verification'] = this.photosForVerification;
    data['active_at'] = this.activeAt;
    data['subscription_status'] = this.subscriptionStatus;
    data['subscription_validation_status'] = this.subscriptionValidationStatus;
    data['isEmailVerified'] = this.isEmailVerified;
    data['isUserVerified'] = this.isUserVerified;
    data['mobile_number'] = this.mobileNumber;
    data['otp_verification'] = this.otpVerification;
    data['contry_code'] = this.contryCode;
    data['suspended_date'] = this.suspendedDate;
    data['is_admin'] = this.isAdmin;
    data['user_status'] = this.userStatus;
    data['user_verification'] = this.userVerification;
    data['attributeStatus'] = this.attributeStatus;
    data['createpostIMOTF'] = this.createpostIMOTF;
    data['resolve_by_admin'] = this.resolveByAdmin;
    data['delete_by_admin'] = this.deleteByAdmin;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deletedAt'] = this.deletedAt;
    if (this.userImagesWhileSignup != null) {
      data['user_images_while_signup'] =
          this.userImagesWhileSignup!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Verification {
  String? seriousCrime;
  String? takingHardDrugs;
  String? criminalActivity;
  String? domesticViolence;
  String? sexualHarassment;
  String? additionalDetails;
  String? anyCriminalActivityHardDrugsAndFinancialCrimes;
  String? activityInvolvingSexualHarassmentDomesticViolence;

  Verification(
      {this.seriousCrime,
        this.takingHardDrugs,
        this.criminalActivity,
        this.domesticViolence,
        this.sexualHarassment,
        this.additionalDetails,
        this.anyCriminalActivityHardDrugsAndFinancialCrimes,
        this.activityInvolvingSexualHarassmentDomesticViolence});

  Verification.fromJson(Map<String, dynamic> json) {
    seriousCrime = json['serious_crime'];
    takingHardDrugs = json['Taking_hard_drugs'];
    criminalActivity = json['criminal_activity'];
    domesticViolence = json['domestic_violence'];
    sexualHarassment = json['sexual_harassment'];
    additionalDetails = json['additional_details'];
    anyCriminalActivityHardDrugsAndFinancialCrimes =
    json['any_criminal_activity_hard_drugs_and_financial_crimes'];
    activityInvolvingSexualHarassmentDomesticViolence =
    json['activity_involving_sexual_harassment_domestic_violence'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['serious_crime'] = this.seriousCrime;
    data['Taking_hard_drugs'] = this.takingHardDrugs;
    data['criminal_activity'] = this.criminalActivity;
    data['domestic_violence'] = this.domesticViolence;
    data['sexual_harassment'] = this.sexualHarassment;
    data['additional_details'] = this.additionalDetails;
    data['any_criminal_activity_hard_drugs_and_financial_crimes'] =
        this.anyCriminalActivityHardDrugsAndFinancialCrimes;
    data['activity_involving_sexual_harassment_domestic_violence'] =
        this.activityInvolvingSexualHarassmentDomesticViolence;
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
