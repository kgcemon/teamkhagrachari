import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // To handle JSON decoding
import '../../data/model/leaderboard_model.dart';
import '../../data/urls..dart'; // Import for the LeaderboardUser model

class LeaderBoardController extends GetxController {

  RxBool isLoading = false.obs;

  var leaderBoardUsers = <LeaderboardUser>[].obs;

  Future<void> loadLeaderBoard() async {
    try {
      isLoading(true);

      var response = await http.get(Uri.parse(ApiUrl.leaderBordUrl));

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        isLoading(false);
        List<LeaderboardUser> users = (jsonData['data'] as List)
            .map((userJson) => LeaderboardUser.fromJson(userJson))
            .toList();
        leaderBoardUsers.assignAll(users);
      } else {
        print('Failed to load leaderboard data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error loading leaderboard: $e');
    } finally {
      isLoading(false);
    }
  }
}
