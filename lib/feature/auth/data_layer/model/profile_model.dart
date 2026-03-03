class ProfileModel {
  final int id;
  final String firstName;
  final String lastName;
  final String phone;
  final int cityId;
  final String image;
  final CityData? city;

  ProfileModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.cityId,
    required this.image,
    this.city,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] ?? 0,
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      phone: json['phone'] ?? '',
      cityId: _parseIntValue(json['city_id']),
      image: json['image'] ?? '',
      city: json['city'] != null ? CityData.fromJson(json['city']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'first_name': firstName,
    'last_name': lastName,
    'phone': phone,
    'city_id': cityId,
    'image': image,
    'city': city?.toJson(),
  };

  // Helper method to get full name
  String getFullName() => '$firstName $lastName';

  // Helper method to get city name
  String getCityName() => city?.name ?? 'Unknown';

  // Helper method to get state name
  String getStateName() => city?.state?.name ?? 'Unknown';
}

class CityData {
  final int id;
  final String name;
  final int stateId;
  final StateData? state;

  CityData({
    required this.id,
    required this.name,
    required this.stateId,
    this.state,
  });

  factory CityData.fromJson(Map<String, dynamic> json) {
    return CityData(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      stateId: json['state_id'] ?? 0,
      state: json['state'] != null ? StateData.fromJson(json['state']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'state_id': stateId,
    'state': state?.toJson(),
  };
}

class StateData {
  final int id;
  final String name;

  StateData({required this.id, required this.name});

  factory StateData.fromJson(Map<String, dynamic> json) {
    return StateData(id: json['id'] ?? 0, name: json['name'] ?? '');
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}

/// Helper function to parse int values from either int or String
int _parseIntValue(dynamic value) {
  if (value is int) {
    return value;
  } else if (value is String) {
    return int.tryParse(value) ?? 0;
  }
  return 0;
}
