import 'package:beehive/apiservice.dart';
import 'package:flutter/material.dart';


void createUserExample() async {
  final apiService = ApiService();

  final userData = {
    "verified": true,
    "is_signed_up_by_google": true,
    "email_address": "example@mail.com",
    "created_on": DateTime.now().toIso8601String(),
    "account_type": "standard",
    "phone_number": "1234567890",
    "authorized_to_company_details": true,
    "password": "securePassword123",
    "name": "John Doe",
    "is_blocked": false,
    "is_agent_suspended": false,
    "profile_image": "https://example.com/profile.jpg",
    "profile_type": "user",
    "organization_id": 123,
    "user_logged_in": true,
  };

  try {
    final response = await apiService.createUser(userData);
    print("User created successfully: $response");
  } catch (e) {
    print("Error creating user: $e");
  }
}
