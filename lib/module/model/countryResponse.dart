class CountryResponse {
  String? ip;
  String? type;
  dynamic hostname;
  Carrier? carrier;
  Company? company;
  Connection? connection;
  Currency? currency;
  Location? location;
  Security? security;
  TimeZone? timeZone;
  UserAgent? userAgent;

  CountryResponse(
      {this.ip,
        this.type,
        this.hostname,
        this.carrier,
        this.company,
        this.connection,
        this.currency,
        this.location,
        this.security,
        this.timeZone,
        this.userAgent});

  CountryResponse.fromJson(Map<String, dynamic> json) {
    ip = json['ip'];
    type = json['type'];
    hostname = json['hostname'];
    carrier =
    json['carrier'] != null ? new Carrier.fromJson(json['carrier']) : null;
    company =
    json['company'] != null ? new Company.fromJson(json['company']) : null;
    connection = json['connection'] != null
        ? new Connection.fromJson(json['connection'])
        : null;
    currency = json['currency'] != null
        ? new Currency.fromJson(json['currency'])
        : null;
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    security = json['security'] != null
        ? new Security.fromJson(json['security'])
        : null;
    timeZone = json['time_zone'] != null
        ? new TimeZone.fromJson(json['time_zone'])
        : null;
    userAgent = json['user_agent'] != null
        ? new UserAgent.fromJson(json['user_agent'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ip'] = this.ip;
    data['type'] = this.type;
    data['hostname'] = this.hostname;
    if (this.carrier != null) {
      data['carrier'] = this.carrier!.toJson();
    }
    if (this.company != null) {
      data['company'] = this.company!.toJson();
    }
    if (this.connection != null) {
      data['connection'] = this.connection!.toJson();
    }
    if (this.currency != null) {
      data['currency'] = this.currency!.toJson();
    }
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    if (this.security != null) {
      data['security'] = this.security!.toJson();
    }
    if (this.timeZone != null) {
      data['time_zone'] = this.timeZone!.toJson();
    }
    if (this.userAgent != null) {
      data['user_agent'] = this.userAgent!.toJson();
    }
    return data;
  }
}

class Carrier {
  Null? name;
  Null? mcc;
  Null? mnc;

  Carrier({this.name, this.mcc, this.mnc});

  Carrier.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    mcc = json['mcc'];
    mnc = json['mnc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['mcc'] = this.mcc;
    data['mnc'] = this.mnc;
    return data;
  }
}

class Company {
  String? domain;
  String? name;
  String? type;

  Company({this.domain, this.name, this.type});

  Company.fromJson(Map<String, dynamic> json) {
    domain = json['domain'];
    name = json['name'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['domain'] = this.domain;
    data['name'] = this.name;
    data['type'] = this.type;
    return data;
  }
}

class Connection {
  int? asn;
  String? domain;
  String? organization;
  String? route;
  String? type;

  Connection({this.asn, this.domain, this.organization, this.route, this.type});

  Connection.fromJson(Map<String, dynamic> json) {
    asn = json['asn'];
    domain = json['domain'];
    organization = json['organization'];
    route = json['route'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['asn'] = this.asn;
    data['domain'] = this.domain;
    data['organization'] = this.organization;
    data['route'] = this.route;
    data['type'] = this.type;
    return data;
  }
}

class Currency {
  String? code;
  String? name;
  String? nameNative;
  String? plural;
  String? pluralNative;
  String? symbol;
  String? symbolNative;
  Format? format;

  Currency(
      {this.code,
        this.name,
        this.nameNative,
        this.plural,
        this.pluralNative,
        this.symbol,
        this.symbolNative,
        this.format});

  Currency.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    nameNative = json['name_native'];
    plural = json['plural'];
    pluralNative = json['plural_native'];
    symbol = json['symbol'];
    symbolNative = json['symbol_native'];
    format =
    json['format'] != null ? new Format.fromJson(json['format']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['name'] = this.name;
    data['name_native'] = this.nameNative;
    data['plural'] = this.plural;
    data['plural_native'] = this.pluralNative;
    data['symbol'] = this.symbol;
    data['symbol_native'] = this.symbolNative;
    if (this.format != null) {
      data['format'] = this.format!.toJson();
    }
    return data;
  }
}

class Format {
  Negative? negative;
  Negative? positive;

  Format({this.negative, this.positive});

  Format.fromJson(Map<String, dynamic> json) {
    negative = json['negative'] != null
        ? new Negative.fromJson(json['negative'])
        : null;
    positive = json['positive'] != null
        ? new Negative.fromJson(json['positive'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.negative != null) {
      data['negative'] = this.negative!.toJson();
    }
    if (this.positive != null) {
      data['positive'] = this.positive!.toJson();
    }
    return data;
  }
}

class Negative {
  String? prefix;
  String? suffix;

  Negative({this.prefix, this.suffix});

  Negative.fromJson(Map<String, dynamic> json) {
    prefix = json['prefix'];
    suffix = json['suffix'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['prefix'] = this.prefix;
    data['suffix'] = this.suffix;
    return data;
  }
}

class Location {
  Continent? continent;
  Country? country;
  Continent? region;
  String? city;
  String? postal;
  double? latitude;
  double? longitude;
  Languages? language;
  bool? inEu;

  Location(
      {this.continent,
        this.country,
        this.region,
        this.city,
        this.postal,
        this.latitude,
        this.longitude,
        this.language,
        this.inEu});

  Location.fromJson(Map<String, dynamic> json) {
    continent = json['continent'] != null
        ? new Continent.fromJson(json['continent'])
        : null;
    country =
    json['country'] != null ? new Country.fromJson(json['country']) : null;
    region =
    json['region'] != null ? new Continent.fromJson(json['region']) : null;
    city = json['city'];
    postal = json['postal'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    language = json['language'] != null
        ? new Languages.fromJson(json['language'])
        : null;
    inEu = json['in_eu'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.continent != null) {
      data['continent'] = this.continent!.toJson();
    }
    if (this.country != null) {
      data['country'] = this.country!.toJson();
    }
    if (this.region != null) {
      data['region'] = this.region!.toJson();
    }
    data['city'] = this.city;
    data['postal'] = this.postal;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    if (this.language != null) {
      data['language'] = this.language!.toJson();
    }
    data['in_eu'] = this.inEu;
    return data;
  }
}

class Continent {
  String? code;
  String? name;

  Continent({this.code, this.name});

  Continent.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['name'] = this.name;
    return data;
  }
}

class Country {
  int? area;
  List<String>? borders;
  String? callingCode;
  String? capital;
  String? code;
  String? name;
  int? population;
  double? populationDensity;
  Flag? flag;
  List<Languages>? languages;
  String? tld;

  Country(
      {this.area,
        this.borders,
        this.callingCode,
        this.capital,
        this.code,
        this.name,
        this.population,
        this.populationDensity,
        this.flag,
        this.languages,
        this.tld});

  Country.fromJson(Map<String, dynamic> json) {
    area = json['area'];
    borders = json['borders'].cast<String>();
    callingCode = json['calling_code'];
    capital = json['capital'];
    code = json['code'];
    name = json['name'];
    population = json['population'];
    populationDensity = json['population_density'];
    flag = json['flag'] != null ? new Flag.fromJson(json['flag']) : null;
    if (json['languages'] != null) {
      languages = <Languages>[];
      json['languages'].forEach((v) {
        languages!.add(new Languages.fromJson(v));
      });
    }
    tld = json['tld'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['area'] = this.area;
    data['borders'] = this.borders;
    data['calling_code'] = this.callingCode;
    data['capital'] = this.capital;
    data['code'] = this.code;
    data['name'] = this.name;
    data['population'] = this.population;
    data['population_density'] = this.populationDensity;
    if (this.flag != null) {
      data['flag'] = this.flag!.toJson();
    }
    if (this.languages != null) {
      data['languages'] = this.languages!.map((v) => v.toJson()).toList();
    }
    data['tld'] = this.tld;
    return data;
  }
}

class Flag {
  String? emoji;
  String? emojiUnicode;
  String? emojitwo;
  String? noto;
  String? twemoji;
  String? wikimedia;

  Flag(
      {this.emoji,
        this.emojiUnicode,
        this.emojitwo,
        this.noto,
        this.twemoji,
        this.wikimedia});

  Flag.fromJson(Map<String, dynamic> json) {
    emoji = json['emoji'];
    emojiUnicode = json['emoji_unicode'];
    emojitwo = json['emojitwo'];
    noto = json['noto'];
    twemoji = json['twemoji'];
    wikimedia = json['wikimedia'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['emoji'] = this.emoji;
    data['emoji_unicode'] = this.emojiUnicode;
    data['emojitwo'] = this.emojitwo;
    data['noto'] = this.noto;
    data['twemoji'] = this.twemoji;
    data['wikimedia'] = this.wikimedia;
    return data;
  }
}

class Languages {
  String? code;
  String? name;
  String? native;

  Languages({this.code, this.name, this.native});

  Languages.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    native = json['native'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['name'] = this.name;
    data['native'] = this.native;
    return data;
  }
}

class Security {
  bool? isAbuser;
  bool? isAttacker;
  bool? isBogon;
  bool? isCloudProvider;
  bool? isProxy;
  bool? isRelay;
  bool? isTor;
  bool? isTorExit;
  bool? isVpn;
  bool? isAnonymous;
  bool? isThreat;

  Security(
      {this.isAbuser,
        this.isAttacker,
        this.isBogon,
        this.isCloudProvider,
        this.isProxy,
        this.isRelay,
        this.isTor,
        this.isTorExit,
        this.isVpn,
        this.isAnonymous,
        this.isThreat});

  Security.fromJson(Map<String, dynamic> json) {
    isAbuser = json['is_abuser'];
    isAttacker = json['is_attacker'];
    isBogon = json['is_bogon'];
    isCloudProvider = json['is_cloud_provider'];
    isProxy = json['is_proxy'];
    isRelay = json['is_relay'];
    isTor = json['is_tor'];
    isTorExit = json['is_tor_exit'];
    isVpn = json['is_vpn'];
    isAnonymous = json['is_anonymous'];
    isThreat = json['is_threat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_abuser'] = this.isAbuser;
    data['is_attacker'] = this.isAttacker;
    data['is_bogon'] = this.isBogon;
    data['is_cloud_provider'] = this.isCloudProvider;
    data['is_proxy'] = this.isProxy;
    data['is_relay'] = this.isRelay;
    data['is_tor'] = this.isTor;
    data['is_tor_exit'] = this.isTorExit;
    data['is_vpn'] = this.isVpn;
    data['is_anonymous'] = this.isAnonymous;
    data['is_threat'] = this.isThreat;
    return data;
  }
}

class TimeZone {
  String? id;
  String? abbreviation;
  String? currentTime;
  String? name;
  int? offset;
  bool? inDaylightSaving;

  TimeZone(
      {this.id,
        this.abbreviation,
        this.currentTime,
        this.name,
        this.offset,
        this.inDaylightSaving});

  TimeZone.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    abbreviation = json['abbreviation'];
    currentTime = json['current_time'];
    name = json['name'];
    offset = json['offset'];
    inDaylightSaving = json['in_daylight_saving'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['abbreviation'] = this.abbreviation;
    data['current_time'] = this.currentTime;
    data['name'] = this.name;
    data['offset'] = this.offset;
    data['in_daylight_saving'] = this.inDaylightSaving;
    return data;
  }
}

class UserAgent {
  String? header;
  String? name;
  String? type;
  String? version;
  String? versionMajor;
  Device? device;
  Engine? engine;
  Os? os;

  UserAgent(
      {this.header,
        this.name,
        this.type,
        this.version,
        this.versionMajor,
        this.device,
        this.engine,
        this.os});

  UserAgent.fromJson(Map<String, dynamic> json) {
    header = json['header'];
    name = json['name'];
    type = json['type'];
    version = json['version'];
    versionMajor = json['version_major'];
    device =
    json['device'] != null ? new Device.fromJson(json['device']) : null;
    engine =
    json['engine'] != null ? new Engine.fromJson(json['engine']) : null;
    os = json['os'] != null ? new Os.fromJson(json['os']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['header'] = this.header;
    data['name'] = this.name;
    data['type'] = this.type;
    data['version'] = this.version;
    data['version_major'] = this.versionMajor;
    if (this.device != null) {
      data['device'] = this.device!.toJson();
    }
    if (this.engine != null) {
      data['engine'] = this.engine!.toJson();
    }
    if (this.os != null) {
      data['os'] = this.os!.toJson();
    }
    return data;
  }
}

class Device {
  String? brand;
  String? name;
  String? type;

  Device({this.brand, this.name, this.type});

  Device.fromJson(Map<String, dynamic> json) {
    brand = json['brand'];
    name = json['name'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['brand'] = this.brand;
    data['name'] = this.name;
    data['type'] = this.type;
    return data;
  }
}

class Engine {
  String? name;
  String? type;
  String? version;
  String? versionMajor;

  Engine({this.name, this.type, this.version, this.versionMajor});

  Engine.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    type = json['type'];
    version = json['version'];
    versionMajor = json['version_major'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['type'] = this.type;
    data['version'] = this.version;
    data['version_major'] = this.versionMajor;
    return data;
  }
}

class Os {
  String? name;
  String? type;
  String? version;

  Os({this.name, this.type, this.version});

  Os.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    type = json['type'];
    version = json['version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['type'] = this.type;
    data['version'] = this.version;
    return data;
  }
}
