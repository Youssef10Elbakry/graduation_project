import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graduation_project/models/recent_transaction_model.dart';
import 'package:graduation_project/ui/providers/wallet_tab_provider.dart';
import 'package:graduation_project/ui/screens/amount_screens/testing_screen.dart';
import 'package:graduation_project/ui/screens/main_screen/wallet_tab/child_action_button.dart';
import 'package:graduation_project/ui/screens/main_screen/wallet_tab/student_transaction_row.dart';
import 'package:graduation_project/ui/screens/main_screen/wallet_tab/visa_container.dart';
import 'package:graduation_project/ui/screens/transactions_details/transactions_details.dart';
import 'package:provider/provider.dart';

import '../widgets/child_avatar.dart';

class WalletTab extends StatefulWidget {
  const WalletTab({super.key});

  @override
  State<WalletTab> createState() => _WalletTabState();
}

class _WalletTabState extends State<WalletTab> {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  late WalletTabProvider screenProvider;
  void initState() {
    super.initState();

    final provider = Provider.of<WalletTabProvider>(context, listen: false);
    provider.requestBottomSheet = (String childId, String username, String imageUrl){
      showAmountSheet(context, "0", childId, username, imageUrl);
    };
    // provider.requestBottomSheet = (message){Navigator.pushNam};
    Future.microtask(() async {
      final String token = (await secureStorage.read(key: "authentication_key"))!;
      Provider.of<WalletTabProvider>(context, listen: false).getChildren();
      Provider.of<WalletTabProvider>(context, listen: false).getRecentTransactions();
      Provider.of<WalletTabProvider>(context, listen: false).getParentProfileData();
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
              CircleAvatar(backgroundImage: NetworkImage(provider.parentProfilePictureLink),),

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
          padding:  EdgeInsets.symmetric(vertical: 0, horizontal: width*0.04136),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // SizedBox(width: width*0.089,),
              const Text("Children", style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w600,
                  fontSize: 30
              ),),
              // Spacer(),
              //
              // Column(
              //   children: [
              //     ChildActionButton(text: "Transaction History"),
              //     SizedBox(height: 10,),
              //     ChildActionButton(text: "Send Money")
              //   ],
              // )
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
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>TransactionsDetailsScreen()));
                },
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
