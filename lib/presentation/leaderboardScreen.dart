import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/leaderboardController.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  final leaderBoardController = Get.put(LeaderBoardController());

  @override
  void initState() {
    load();
    super.initState();
  }

  load() async {
    await leaderBoardController.loadLeaderBoard();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent, // Background color
      body: RefreshIndicator(
        onRefresh: () async => await leaderBoardController.loadLeaderBoard(),
        child: Obx(
          () => leaderBoardController.leaderBoardUsers.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 300,
                        decoration: const BoxDecoration(
                          color: Color(0xFF2D1B7B),
                          image: DecorationImage(
                            image: AssetImage('Assets/images/bg.jpg'),
                            // Add your background image
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 80),
                            _buildTopThreePlayers(),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 250,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xff0131AF).withOpacity(0.10),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: ListView.builder(
                          itemCount:
                              leaderBoardController.leaderBoardUsers.length,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: const Color(0xff0131AF),
                                  borderRadius: BorderRadius.circular(10)),
                              child: ListTile(
                                leading: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("${index+1}"),
                                    const SizedBox(width: 10,),
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          leaderBoardController
                                              .leaderBoardUsers[index].image),
                                      radius: 25,
                                    ),
                                  ],
                                ),
                                title: Text(
                                    leaderBoardController
                                        .leaderBoardUsers[index].name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                                subtitle: Row(
                                  children: [
                                    const Icon(
                                      CupertinoIcons.location_solid,
                                      color: Colors.orange,
                                      size: 16,
                                    ),
                                    Text(
                                        ' ${leaderBoardController.leaderBoardUsers[index].upazila}'),
                                  ],
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      CupertinoIcons.star_circle_fill,
                                      color: Colors.orange,
                                      size: 16,
                                    ),
                                    Text(" ${leaderBoardController.leaderBoardUsers[index].balance}"),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildTopThreePlayers() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildPlayerRank(
              leaderBoardController.leaderBoardUsers[1].name,
              leaderBoardController.leaderBoardUsers[1].image,
              2,
              leaderBoardController.leaderBoardUsers[1].balance),
          _buildPlayerRank(
              leaderBoardController.leaderBoardUsers[0].name,
              leaderBoardController.leaderBoardUsers[0].image,
              1,
              leaderBoardController.leaderBoardUsers[0].balance,
              isFirst: true),
          _buildPlayerRank(
              leaderBoardController.leaderBoardUsers[2].name,
              leaderBoardController.leaderBoardUsers[2].image,
              3,
              leaderBoardController.leaderBoardUsers[2].balance),
        ],
      ),
    );
  }

  Widget _buildPlayerRank(String name, String imagePath, int rank, int score,
      {bool isFirst = false}) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 3),
                  borderRadius: BorderRadius.circular(90)),
              child: CircleAvatar(
                radius: isFirst ? 50 : 40,
                backgroundImage: NetworkImage(imagePath),
              ),
            ),
            if (isFirst)
              const Positioned(
                top: -35,
                right: 33,
                child: Image(
                    height: 40, image: AssetImage("Assets/images/king.png")),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Text(name, style: const TextStyle(color: Colors.white, fontSize: 11)),
        Text('$score',
            style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
      ],
    );
  }
}
