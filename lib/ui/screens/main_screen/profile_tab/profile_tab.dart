import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graduation_project/ui/screens/main_screen/profile_tab/profile_tab_textfield.dart';
import 'package:provider/provider.dart';

import 'package:flutter_svg/flutter_svg.dart';

import '../../../providers/user_profile_provider.dart';



class ProfileTab extends StatefulWidget {
  static const String screenName = "Profile Screen";

  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  late String token;

  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();

    // Delay API call to avoid triggering setState during widget build
    Future.microtask(() async {
      token = (await secureStorage.read(key: "authentication_key"))!;
      Provider.of<UserProfileProvider>(context, listen: false).fetchUserData(token);
      print("Token: $token");
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProfileProvider = Provider.of<UserProfileProvider>(context);
    final isLoading = userProfileProvider.isLoading;
    final userProfile = userProfileProvider.userProfile;

    return Stack(
        children: [
          Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: double.infinity,
                    child:
                    SvgPicture.asset(
                      "assets/images/Rectangle-background.svg",
                      fit: BoxFit.fill,
                    ),
                  ),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.arrow_back_ios,
                                    color: Colors.white, size: 30),
                                  onPressed: () {
                                  Navigator.pop(context);
                                  },
                              ),
                              IconButton(
                                icon: const Icon(Icons.settings,
                                    color: Colors.white, size: 30),
                                  onPressed: () {},
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          const Text(
                            "Profile",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.bold,
                              fontSize: 45,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(40),
                          child: Column(
                            children: [
                              if (userProfile != null) ...[
                                Column(
                                  children: [
                                    Text(
                                      userProfile.fullName,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Text(
                                      "Parent",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                ProfileTabTextField(
                                  labelText: "Full Name",
                                  infoText: userProfile.fullName,
                                ),
                                ProfileTabTextField(
                                  labelText: "Age",
                                  infoText: userProfile.age.toString(),
                                ),
                                ProfileTabTextField(
                                  labelText: "Number of Children",
                                  infoText: userProfile.numberOfChildren.toString(),
                                ),
                                ProfileTabTextField(
                                  labelText: "Phone Number",
                                  infoText: userProfile.phoneNumber,
                                ),
                                ProfileTabTextField(
                                  labelText: "Email",
                                  infoText: userProfile.email,
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
              ),
            ],
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.25,
            left: MediaQuery.of(context).size.width * 0.35,
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: userProfile?.profilePhoto.isNotEmpty ?? false
                      ? NetworkImage(userProfile!.profilePhoto) // Use NetworkImage for API photo
                      : const AssetImage("assets/images/white_screen.jpg") as ImageProvider, // Fallback for no photo
                  backgroundColor: Colors.transparent,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey[200]!,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.edit, color: Colors.black, size: 20),
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
  }
}
