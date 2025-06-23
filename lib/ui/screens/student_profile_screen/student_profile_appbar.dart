import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../amount_screens/testing_screen.dart';
import '../settings_screen/settings_screen.dart';

class StudentProfileAppbar extends StatelessWidget{
  String? name;
  String role;
  String? imageUrl;
  StudentProfileAppbar({Key? key, required this.name, required this.imageUrl, required this.role});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return ClipPath(

      clipper: CurveClipper(),
      child: Container(
        height: height*0.197, // Adjust height as needed
        color: const Color(0xff6156C8),
        child:  Column(
            children: [
              SizedBox(height: height*0.022,),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: width*0.012),
                child: Row(
                  children: [
                    IconButton(onPressed: (){

                      Navigator.pop(context);
                      },
                        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white,)),
                    const Spacer(),
                    IconButton(onPressed: (){Navigator.pushNamed(context, SettingsScreen.screenName);},
                        icon: const Icon(Icons.settings, color: Colors.white,)),
                  ],
                ),
              ),
              SizedBox(height: height*0.0055,),
              Row(
                children: [
                  const Spacer(flex: 1,),
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      ClipOval(
                        child: Image.network(
                          imageUrl!,
                          width: width*0.18,
                          height: height*0.08,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return SvgPicture.asset(
                              'assets/images/no_image_found.svg', // Your local placeholder image
                              width: width*0.18,
                              height: height*0.08,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      )

                      // InkWell(
                      //   onTap: (){},
                      //     child: CircleAvatar(radius:16,child: SvgPicture.asset("assets/images/edit_pen_icon.svg"),))
                    ],
                  ),
                  SizedBox(width: width*0.024,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name!, style: TextStyle(fontSize: 20,color: Colors.white, fontWeight: FontWeight.w500),),
                      Text("Student", style: TextStyle(fontSize: 12,color: Colors.white, fontWeight: FontWeight.w400))
                    ],
                  ),
                  const Spacer(flex: 2,)

                ],
              )
            ],
          ),

      ),
    );
  }

}

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 40);
    path.quadraticBezierTo(size.width / 2, size.height + 20, size.width, size.height - 40);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}