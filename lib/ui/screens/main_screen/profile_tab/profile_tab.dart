import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graduation_project/ui/screens/main_screen/profile_tab/profile_tab_textfield.dart';
import 'package:graduation_project/ui/screens/settings_screen/settings_screen.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import 'package:flutter_svg/flutter_svg.dart';

import '../../../providers/user_profile_provider.dart';
import '../../../../models/user_profile_model.dart';

class ProfileTab extends StatefulWidget {
  static const String screenName = "Profile Screen";

  const ProfileTab({super.key});

  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  late String token;
  bool isEditMode = false;

  Widget _buildShimmerLoading() {
    return SingleChildScrollView(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            children: [
              // Header section with background
              Stack(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.35,
                    width: double.infinity,
                    child: SvgPicture.asset(
                      "assets/images/Rectangle-background.svg",
                      fit: BoxFit.fill,
                    ),
                  ),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "Profile",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.bold,
                              fontSize: 35,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.settings,
                                color: Colors.white, size: 30),
                            onPressed: () {
                              Navigator.pushNamed(context, SettingsScreen.screenName);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              // Content section with shimmer
              Container(
                width: double.infinity,
                color: Colors.grey[50],
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 80),
                      // Name and Parent shimmer
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Column(
                          children: [
                            Container(
                              width: 200,
                              height: 28,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              width: 80,
                              height: 18,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      // Text fields shimmer
                      ...List.generate(5, (index) => Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            width: double.infinity,
                            height: 56,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      )),
                      const SizedBox(height: 120),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Shimmer profile picture
          Positioned(
            top: MediaQuery.of(context).size.height * 0.25,
            left: MediaQuery.of(context).size.width * 0.5 - 60,
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: const CircleAvatar(
                radius: 60,
                backgroundColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Controllers for text fields
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController numberOfChildrenController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  // Track which fields are in edit mode
  Map<String, bool> fieldEditStates = {
    'fullName': false,
    'age': false,
    'numberOfChildren': false,
    'phoneNumber': false,
    'email': false,
  };

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
  void dispose() {
    fullNameController.dispose();
    ageController.dispose();
    numberOfChildrenController.dispose();
    phoneNumberController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void _updateControllers(UserProfile userProfile) {
    fullNameController.text = userProfile.fullName;
    ageController.text = userProfile.age.toString();
    numberOfChildrenController.text = userProfile.numberOfChildren.toString();
    phoneNumberController.text = userProfile.phoneNumber;
    emailController.text = userProfile.email;
  }

  void _toggleFieldEdit(String fieldName) {
    setState(() {
      fieldEditStates[fieldName] = !fieldEditStates[fieldName]!;
      
      // If any field is in edit mode, show update button
      isEditMode = fieldEditStates.values.any((isEdit) => isEdit);
    });
  }

  Future<void> _updateProfile() async {
    final userProfileProvider = Provider.of<UserProfileProvider>(context, listen: false);
    
    final success = await userProfileProvider.updateUserProfile(
      token,
      fullName: fullNameController.text,
      age: ageController.text,
      numberOfChildren: numberOfChildrenController.text,
      phoneNumber: phoneNumberController.text,
      email: emailController.text,
    );

    if (success) {
      setState(() {
        // Reset all edit states
        fieldEditStates.updateAll((key, value) => false);
        isEditMode = false;
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile updated successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to update profile. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProfileProvider = Provider.of<UserProfileProvider>(context);
    final isLoading = userProfileProvider.isLoading;
    final userProfile = userProfileProvider.userProfile;
    final isUpdating = userProfileProvider.isUpdating;

    // Update controllers when userProfile data is available
    if (userProfile != null && fullNameController.text.isEmpty) {
      _updateControllers(userProfile);
    }

    return Scaffold(
      body: isLoading
          ? _buildShimmerLoading()
          : RefreshIndicator(
              onRefresh: () async {
                await Provider.of<UserProfileProvider>(context, listen: false).fetchUserData(token);
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Column(
                      children: [
                        // Header section with background only
                        Stack(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.35,
                              width: double.infinity,
                              child: SvgPicture.asset(
                                "assets/images/Rectangle-background.svg",
                                fit: BoxFit.fill,
                              ),
                            ),
                            SafeArea(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Profile",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 35,
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.settings,
                                          color: Colors.white, size: 30),
                                      onPressed: () {
                                        Navigator.pushNamed(context, SettingsScreen.screenName);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Content section
                        Container(
                          width: double.infinity,
                          color: Colors.grey[50],
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24.0),
                            child: Column(
                              children: [
                                if (userProfile != null) ...[
                                  // Add spacing for the floating profile image
                                  const SizedBox(height: 80),
                                  Column(
                                    children: [
                                      Text(
                                        userProfile.fullName,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      const Text(
                                        "Parent",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 32),
                                  ProfileTabTextField(
                                    labelText: "Full Name",
                                    infoText: userProfile.fullName,
                                    isEditable: fieldEditStates['fullName']!,
                                    controller: fullNameController,
                                    onEditPressed: () => _toggleFieldEdit('fullName'),
                                  ),
                                  const SizedBox(height: 16),
                                  ProfileTabTextField(
                                    labelText: "Age",
                                    infoText: userProfile.age.toString(),
                                    isEditable: fieldEditStates['age']!,
                                    controller: ageController,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                    onEditPressed: () => _toggleFieldEdit('age'),
                                  ),
                                  const SizedBox(height: 16),
                                  ProfileTabTextField(
                                    labelText: "Number of Children",
                                    infoText: userProfile.numberOfChildren.toString(),
                                    isEditable: false,
                                    controller: numberOfChildrenController,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                    onEditPressed: null,
                                  ),
                                  const SizedBox(height: 16),
                                  ProfileTabTextField(
                                    labelText: "Phone Number",
                                    infoText: userProfile.phoneNumber,
                                    isEditable: fieldEditStates['phoneNumber']!,
                                    controller: phoneNumberController,
                                    onEditPressed: () => _toggleFieldEdit('phoneNumber'),
                                  ),
                                  const SizedBox(height: 16),
                                  ProfileTabTextField(
                                    labelText: "Email",
                                    infoText: userProfile.email,
                                    isEditable: fieldEditStates['email']!,
                                    controller: emailController,
                                    onEditPressed: () => _toggleFieldEdit('email'),
                                  ),
                                  if (isEditMode) ...[
                                    const SizedBox(height: 32),
                                    SizedBox(
                                      width: double.infinity,
                                      height: 55,
                                      child: ElevatedButton(
                                        onPressed: isUpdating ? null : _updateProfile,
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blue,
                                          foregroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                        ),
                                        child: isUpdating
                                            ? const CircularProgressIndicator(color: Colors.white)
                                            : const Text(
                                                'Update',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                      ),
                                    ),
                                  ],
                                  // Add bottom padding to ensure content doesn't get cut off
                                  const SizedBox(height: 120),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Floating profile picture that scrolls with content
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.25,
                      left: MediaQuery.of(context).size.width * 0.5 - 60,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 3,
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.grey[200],
                              backgroundImage: userProfile?.profilePhoto.isNotEmpty ?? false
                                  ? NetworkImage(userProfile!.profilePhoto)
                                  : null,
                              child: userProfile?.profilePhoto.isEmpty ?? true
                                  ? Icon(
                                      Icons.person,
                                      size: 90,
                                      color: Colors.grey[500],
                                    )
                                  : null,
                            ),
                            Positioned(
                              bottom: 5,
                              right: 5,
                              child: Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300]!,
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  icon: const Icon(Icons.edit, color: Colors.black, size: 18),
                                  onPressed: () {},
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}