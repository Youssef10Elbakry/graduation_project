import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StudentProfileAppbar extends StatelessWidget{
  String name;
  String role;
  String imageUrl;
  StudentProfileAppbar({Key? key, required this.name, required this.imageUrl, required this.role});

  @override
  Widget build(BuildContext context) {
    return ClipPath(

      clipper: CurveClipper(),
      child: Container(
        height: 180, // Adjust height as needed
        color: Color(0xff6156C8),
        child:  Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5.0),
                child: Row(
                  children: [
                    IconButton(onPressed: (){Navigator.pop(context);},
                        icon: Icon(Icons.arrow_back_ios_new, color: Colors.white,)),
                    const Spacer(),
                    IconButton(onPressed: (){},
                        icon: Icon(Icons.settings, color: Colors.white,)),
                  ],
                ),
              ),
              SizedBox(height: 5,),
              Row(
                children: [
                  const Spacer(flex: 1,),
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(radius: 37, child: Image.asset("assets/images/deif_circle_avatar.png"),),
                      InkWell(
                        onTap: (){},
                          child: CircleAvatar(radius:16,child: SvgPicture.asset("assets/images/edit_pen_icon.svg"),))
                    ],
                  ),
                  SizedBox(width: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Deif Mohamed Ahmed", style: TextStyle(fontSize: 20,color: Colors.white, fontWeight: FontWeight.w500),),
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