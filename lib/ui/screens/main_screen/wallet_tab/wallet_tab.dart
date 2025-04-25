import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graduation_project/models/recent_transaction_model.dart';
import 'package:graduation_project/ui/providers/wallet_tab_provider.dart';
import 'package:graduation_project/ui/screens/main_screen/wallet_tab/student_transaction_row.dart';
import 'package:graduation_project/ui/screens/main_screen/wallet_tab/visa_container.dart';
import 'package:provider/provider.dart';

import '../widgets/child_avatar.dart';

class WalletTab extends StatefulWidget {
  const WalletTab({super.key});

  @override
  State<WalletTab> createState() => _WalletTabState();
}

class _WalletTabState extends State<WalletTab> {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  void initState() {
    super.initState();

    
    Future.microtask(() async {
      final String token = (await secureStorage.read(key: "authentication_key"))!;
      Provider.of<WalletTabProvider>(context, listen: false).getChildren();
      Provider.of<WalletTabProvider>(context, listen: false).getRecentTransactions();
      print("Token: $token");
    });
  }
late WalletTabProvider provider;
  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Padding(
          padding:  EdgeInsets.symmetric(vertical: height*0.021, horizontal: width*0.0446),
          child: Row(
            children: [
              Text("Wallet", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35, fontFamily: "Montserrat"),),
              Spacer(),
              CircleAvatar(backgroundImage: AssetImage("assets/images/mahmoud_home.png"),),

            ],
          ),

        ),
        SizedBox(height: height*0.04727),
        Row(
          children: [
            Spacer(),
            VisaContainer(balance: 500,),
            Spacer()
          ],
        ),
        SizedBox(height: height*0.021,),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: width*0.049),
          child: Row(
            children: [
              // SizedBox(width: width*0.089,),
              const Text("Children", style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w600,
                  fontSize: 30
              ),),
              const Spacer(),
              SizedBox(
                height: height*0.0336,
                  width: width*0.390625,
                  child: ElevatedButton(onPressed: (){},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffE8E8E8), // Change background color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8), // Set border radius
                          side: const BorderSide(color: Color(0xffE8E8E8), width: 1), // Set border
                        ),
                      ),

                      child: Row(
                        children: [
                          const Text("Transaction History",
                            style: TextStyle(fontSize: 12, color: Color(0xffA8AAAF)),),
                          const Spacer(),
                          Icon(Icons.arrow_forward_ios, color: const Color(0xffA8AAAF),size: width*0.03571,)
                        ],
                      )))
            ],
          ),
        ),
        SizedBox(height: height*0.02626,),
        provider.isLoadingChildren?const Row(
          children: [
            Spacer(),
            CircularProgressIndicator(),
            Spacer()
          ],
        ):
        SizedBox(
            height: height*0.084,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: EdgeInsets.only(left: width*0.089),
                child: Row(
                  // mainAxisSize: MainAxisSize.max,
                    children: List.generate(provider.children.length, (index) {
                      return ChildAvatar(childModel: provider.children[index], inHomeTab: false,);
                    })
                ),
              ),
            )),
        SizedBox(height: height*0.042,),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: width*0.049),
          child: Row(
            children: [
              const Text("Recent Transactions", style: TextStyle(fontFamily: 'Poppins',fontSize: 16, fontWeight: FontWeight.w600),),
              const Spacer(),
              InkWell(
                onTap: (){},
                  child: const Text("View All", style: TextStyle(color: Color(0xff3491DB), fontFamily: 'Poppins', fontSize: 16, fontWeight: FontWeight.w500),)),


            ],
          ),

        ),
        SizedBox(height: height*0.0084,),
        provider.isLoadingRecentTransactions?
            const Row(children: [
              Spacer(), CircularProgressIndicator(), Spacer()
            ],):
        Expanded(child: ListView.builder( itemCount:provider.recentTransactions.length, itemBuilder: (_, index)=>StudentTransactionRow(recentTransaction: provider.recentTransactions[index])))
      ],
    );
  }


}
