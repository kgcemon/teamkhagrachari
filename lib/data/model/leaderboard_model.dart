import 'dart:convert';

class LeaderboardUser {
  final String id;
  final String email;
  final String name;
  final String image;
  final int balance;
  final String upazila;

  LeaderboardUser({
    required this.id,
    required this.email,
    required this.name,
    required this.image,
    required this.balance,
    required this.upazila,
  });

  // Factory method to create a LeaderboardUser from JSON
  factory LeaderboardUser.fromJson(Map<String, dynamic> json) {
    return LeaderboardUser(
      id: json['_id'],
      email: json['email'],
      upazila: json['upazila'],
      name: json['name'],
      image: json['image'],
      balance: json['balance'],
    );
  }

  // Method to convert a LeaderboardUser object to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'email': email,
      'name': name,
      'image': image,
      'balance': balance,
    };
  }
}

// Example of decoding a JSON response and converting it into a list of LeaderboardUser objects
List<LeaderboardUser> parseLeaderboardUsers(String responseBody) {
  final parsed = json.decode(responseBody);
  final List<dynamic> data = parsed['data'];

  return data.map<LeaderboardUser>((json) => LeaderboardUser.fromJson(json)).toList();
}
