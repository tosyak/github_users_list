import 'package:github_test_app/data/models/user_detail_model.dart';
import 'package:github_test_app/data/models/user_model.dart';
import 'package:github_test_app/data/network/api_service.dart';

class UsersListRepository {
  // ApiService instance for making network calls
  final ApiService apiService;

  // Number of users fetched per API request
  static const int perPage = 25;

  // URL for the next page of users, initially empty
  String nextUrl = '';

  // Flag to indicate if it's the first API request
  bool initialLoad = true;

  UsersListRepository({
    required this.apiService,
  });

  // Fetches a list of users from GitHub API
  Future<List<User>> getUsersListResponse() async {
    try {
      // Construct the URL based on initial load or pagination
      final url = initialLoad
          ? 'https://api.github.com/users?per_page=$perPage&since=0'
          : nextUrl;

      // Make the API call using ApiService
      final dynamic response = await apiService.getApiResponse(url);

      // Update initialLoad flag after first call
      initialLoad = false;

      // Parse the Link header for pagination (if available)
      _parseLinkHeader(response.headers['link']?.first); // Safer null-check

      // Extract data from the response
      final data = (response.data as List<dynamic>);

      // Convert data to a list of User objects
      final userList = data.map((e) => User.fromJson(e)).toList();

      return userList;
    } catch (e, stackTrace) {
      // Re-throw a descriptive exception for better error handling
      throw Exception(
          'Api repository getUsersListResponse error: $e, stackTrace: $stackTrace');
    }
  }

  // Parse the Link header to extract the next page URL (if exists)
  void _parseLinkHeader(String? linkHeader) {
    if (linkHeader != null && linkHeader.isNotEmpty) {
      // Use RegExp to extract the next URL from Link header
      final regExp = RegExp(r'<(.*?)>; rel="next"');
      final match = regExp.firstMatch(linkHeader);
      if (match != null) {
        nextUrl = match.group(1)!;
      }
    }
  }
}

class UserDetailsRepository {
  // ApiService instance for making network calls
  final ApiService apiService;

  UserDetailsRepository({
    required this.apiService,
  });

  // Fetches details of a specific user from GitHub API
  Future<UserDetails> getUserDetailsResponse(String userName) async {
    try {
      // Construct the URL for the user
      String url = 'https://api.github.com/users/$userName';

      // Make the API call using ApiService
      final response = await apiService.getApiResponse(url);

      // Extract data from the response
      final data = response.data as Map<String, dynamic>;

      // Convert data to a UserDetails object
      final UserDetails userDetails = UserDetails.fromJson(data);

      return userDetails;
    } catch (e, stackTrace) {
      // Re-throw a descriptive exception for better error handling
      throw Exception(
          'Api repository getUserDetailsResponse error: $e, stackTrace: $stackTrace');
    }
  }
}
