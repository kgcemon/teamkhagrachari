import 'dart:convert';
import 'dart:math';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_radio_version_plugin/get_radio_version_plugin.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unique_identifier/unique_identifier.dart';
import 'package:vpn_connection_detector/vpn_connection_detector.dart';
import '../utils/color.dart';
import 'main_nav_screen.dart';

class VotingScreen extends StatefulWidget {
  const VotingScreen({super.key});

  @override
  State<VotingScreen> createState() => _VotingScreenState();
}

class _VotingScreenState extends State<VotingScreen> {
  String deviceID = '';
  String model = '';
  bool isLoading = false;
  List data = [];
  bool voteClickLoading = false;

  final vpnDetector = VpnConnectionDetector();

  @override
  void initState() {
    super.initState();
    getDeviceId();
  }






  //e51300fad3f9afb9
  Future<void> loadAllParticipate() async {
      try {
        setState(() {
          isLoading = true;
        });




        var urls = Uri.parse(
            "https://lottery.khagrachariplus.com/api/participates/$deviceID");

        print(deviceID);
       var radioVersion = await GetRadioVersionPlugin.radioVersion ?? 'Unknown radio version';

        if(radioVersion == '1.0.0.0' || radioVersion == ''|| radioVersion == null){

        } else {
          PackageInfo.fromPlatform().then((value) async {
            if(value.version == "1.8.0"){
              var response = await http.get(urls);
              print(urls);
              if (response.statusCode == 200) {
                var resData = jsonDecode(response.body);
                setState(() {
                  data = resData;
                  // Sort by votes in descending order
                  data.sort((a, b) => b['votes'].compareTo(a['votes']));
                });
              } else {
                Get.snackbar("Error", "Failed to load data. Please try again.");
              }
            }

          });
        }
      } catch (e) {
        Get.snackbar("Error", "An error occurred while loading data.");
      } finally {
        setState(() {
          isLoading = false;
        });
      }

  }

  Future<void> getDeviceId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

    var dataDeviceID = prefs.getString("deviceID");
    var dataModel = prefs.getString("deviceID");

    if(dataDeviceID != null && dataModel != null){
      print("have data");
      model = prefs.getString("model") ?? "";
      deviceID = prefs.getString("deviceID") ?? "";
    }else{
      print("No data");
      model =  androidInfo.brand+androidInfo.model;
      deviceID  = await UniqueIdentifier.serial ?? androidInfo.id+androidInfo.data['incremental'];
      await prefs.setString("model", model);
      await prefs.setString("deviceID", deviceID);
    }

    setState(() {
      print(deviceID);
      print(androidInfo.brand.toUpperCase()+androidInfo.model);
      print(model);
    });
    await loadAllParticipate();
  }



  Future<void> castVote(int index) async {
    if (data[index]['alreadyVote'] == false) {
      Get.defaultDialog(
          title: 'ভোট দিন',
          content: Column(
            children: [
              CircleAvatar(
                radius: 45,
                backgroundImage: NetworkImage(data[index]['image']),
              ),
              Text(
                data[index]['name'] ?? "",
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: "banglafont",
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                data[index]['address'] ?? "",
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontFamily: "banglafont",
                ),
                textAlign: TextAlign.center,
              ),
              ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          minimumSize: const Size(80, 40)),
                      onPressed: () async {
                        voteClickLoading = true;
                        bool isVpnConnected = await VpnConnectionDetector.isVpnActive();
                        String makeModel = "${generateRandomText(10)}e51300fad3f9afb9${model.toLowerCase().trim().replaceAll(" ", "")}e51300fad3f9afb9${generateRandomText(10)}==";
                        print(makeModel);
                        setState(() {
                        });
                        Get.back();
                        if(!isVpnConnected){
                          var res = await http.post(
                              headers: {
                                "Device-ID": deviceID,
                                "User-ID": data[index]['id'].toString()
                              },
                              body: {
                                "decryptData": makeModel,
                              },
                              Uri.parse(
                                  "https://lottery.khagrachariplus.com/api/votes"));
                          Map resData = jsonDecode(res.body);
                          if (res.statusCode == 200 &&
                              resData['success'] == true) {
                            Get.to(() => ThanksVoteScreen(
                              image: data[index]['image'] ?? "",
                            ));
                            voteClickLoading = false;
                            setState(() {
                            });
                            loadAllParticipate();
                          } else {
                            Get.back();
                            Get.snackbar("Error", "Unable to cast your vote.");
                          }
                        }else{
                          Get.back();
                          Get.snackbar(backgroundColor: Colors.red,"Warning", "আপনি অবৈধ ভাবে চেস্টা করছেন বারবার চেস্টায় আপনার একাউন্ট ব্যান হতে পারে");
                        }
                      },
                      child: const Text("Vote",
                          style: TextStyle(color: Colors.white)),
                    ),
            ],
          ));
    } else {
      Get.snackbar("Notice", "You have already voted.");
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth > 600 ? 4 : 3;
    final aspectRatio = screenWidth > 600 ? 2 / 3 : 2 / 3.3;

    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        backgroundColor: MyColors.secenderyColor,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: const Text(
          "ভোট দিন",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: voteClickLoading
          ?  CircularProgressIndicator(color: MyColors.white,)
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: RefreshIndicator(
          onRefresh: () => loadAllParticipate(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                      "https://khagrachariplus.com/wp-content/uploads/2024/12/Smaprton-Ads.jpg"),
                ),
                const SizedBox(
                  height: 10,
                ),
                isLoading
                    ? const Center(child: CircularProgressIndicator(color: Colors.white,))
                    :  GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: data.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossAxisCount,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: aspectRatio,
                            ),
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: () => castVote(index),
                              child: Container(
                                padding: const EdgeInsets.only(
                                    top: 12, right: 4, left: 4),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.13),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: CircleAvatar(
                                        radius: 35,
                                        backgroundImage:
                                            NetworkImage(data[index]['image']),
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Expanded(
                                      child: Text(
                                        data[index]['name'],
                                        maxLines: 1,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                          color: Colors.orange,
                                          fontFamily: "banglafont",
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        data[index]['address'] ?? "",
                                        maxLines: 1,
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.white.withOpacity(0.5),
                                          fontFamily: "banglafont",
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        "Total Vote: ${data[index]['votes'].toString()}",
                                        maxLines: 1,
                                        style: const TextStyle(
                                          fontSize: 10,
                                          color: Colors.grey,
                                          fontFamily: "banglafont",
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            data[index]['alreadyVote'] == false
                                                ? Colors.green
                                                : Colors.grey.shade700,
                                        minimumSize: const Size(80, 27),
                                      ),
                                      onPressed: () => castVote(index),
                                      child: const Text(
                                        "Vote",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String generateRandomText(int length) {
    const characters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    Random random = Random();
    return String.fromCharCodes(Iterable.generate(
        length, (_) => characters.codeUnitAt(random.nextInt(characters.length))));
  }
}

class ThanksVoteScreen extends StatelessWidget {
  String image;

  ThanksVoteScreen({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        backgroundColor: MyColors.secenderyColor,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: const Text(
          "ধন্যবাদ",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Column(
              children: [
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.green,
                        border: Border.all(color: Colors.green, width: 3),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(90))),
                    child: const Icon(
                      Icons.done,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                CircleAvatar(
                  radius: 100,
                  backgroundImage: NetworkImage(image),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              "ধন্যবাদ আপনার মূল্যবান ভোট প্রদানের জন্যে",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
            TextButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(90, 35),
                  backgroundColor: MyColors.secenderyColor),
              onPressed: () => Get.offAll(
                  () => const MainNavScreen(title: 'Khagrachari Plus')),
              child: const Text(
                "Home",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const Spacer(),
            Container(
                height: 80,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: const BorderRadius.all(Radius.circular(8))),
                child: Image.asset(
                  "Assets/images/Smarton.png",
                  fit: BoxFit.fitWidth,
                )),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
