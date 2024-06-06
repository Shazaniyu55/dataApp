// ignore_for_file: use_super_parameters, sized_box_for_whitespace, deprecated_member_use

import 'package:dataapp/constant/colors.dart';
import 'package:dataapp/controller/appController.dart';
import 'package:dataapp/helper/navigator.dart';
import 'package:dataapp/model/walletBalace.dart';
import 'package:dataapp/screens/airtime.dart';
import 'package:dataapp/screens/choosetoken/choosetoken.dart';
import 'package:dataapp/widgets/commonwidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int currentMax = 1;
  AppController appController = Get.find<AppController>();
  var selectedCoinToBalanceModel = Balance().obs;
  var selectCoin = 0.obs;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: appBgGradient,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: primaryColor.value,
          systemOverlayStyle: SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: primaryColor.value,
            // Status bar brightness (optional)
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.dark,
          ),
        ),
        drawer: Drawer(
          backgroundColor: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const UserAccountsDrawerHeader(
                accountName: Text(
                  "Shazaniyu Gbadamosi",
                  style: TextStyle(color: Colors.white),
                ),
                accountEmail: Text("shazaniyu@gmail.com",
                    style: TextStyle(color: Colors.white)),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://res.cloudinary.com/damufjozr/image/upload/v1717407985/niyu_icuuru.jpg"),
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment(0.8, 1),
                    colors: <Color>[
                      Color(0xff1f005c),
                      Color.fromARGB(255, 59, 15, 219),
                      Color.fromARGB(255, 65, 129, 223),
                      Color.fromARGB(255, 21, 132, 192),
                      Color.fromARGB(255, 55, 132, 225),
                      Color.fromARGB(255, 100, 123, 239),
                      Color.fromARGB(255, 44, 47, 227),
                      Color.fromARGB(255, 107, 171, 255),
                    ],
                  ),
                  image: DecorationImage(
                    image: NetworkImage(
                        "https://res.cloudinary.com/damufjozr/image/upload/v1717407985/niyu_icuuru.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const ListTile(
                leading: Icon(
                  Icons.person_3,
                  size: 30,
                ),
                title: Text("Profile"),
              ),
              const SizedBox(height: 10),
              const ListTile(
                leading: Icon(
                  Icons.wallet,
                  size: 30,
                ),
                title: Text("Wallet"),
              ),
              const SizedBox(height: 10),
              ListTile(
                leading: const Icon(
                  Icons.exit_to_app,
                  size: 30,
                ),
                title: const Text("Log out"),
                onTap: () async {},
              ),
            ],
          ),
        ),
        body: Obx(
          () => Container(
            height: Get.height,
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 210,
                      padding:
                          const EdgeInsets.only(top: 30, left: 16, right: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const SizedBox(height: 30),
                          Container(
                            width: Get.width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Wallet Balance',
                                  style: TextStyle(
                                    fontFamily: 'sfpro',
                                    color: lightColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.0,
                                    letterSpacing: 0.37,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  '₦${0.0}',
                                  style: TextStyle(
                                    fontFamily: 'sfpro',
                                    color: lightColor,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 40.0,
                                    letterSpacing: 0.36,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        decoration: BoxDecoration(
                          color: primaryBackgroundColor.value,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 60),
                            Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: [
                                _buildCard(
                                    context, "images/phone.png", "Airtime", () {
                                  changeScreen(context, const AirtimeScreen());
                                }),
                                _buildCard(context, "images/data.png",
                                    "Buy Data", () {}),
                                _buildCard(context, "images/light.png", "Bills",
                                    () {}),
                                _buildCard(
                                    context, "images/tv.png", "Cable", () {}),
                                _buildCard(context, "images/data.png",
                                    "Buy Data", () {}),
                                _buildCard(context, "images/print.png",
                                    "Recharge", () {}),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 170,
                  left: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      width: Get.width - 32,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: cardColor.value,
                        boxShadow: appShadow,
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      child: Row(
                        children: [
                          _dashBTns(
                            svg: 'wallet',
                            btnText: 'Fund wallet',
                            onTap: () {
                              CommonWidgets()
                                  .selectWithdrawBottomSheet(context);
                            },
                          ),
                          const SizedBox(width: 20),
                          _dashBTns(
                            svg: 'transac',
                            btnText: 'Transactions',
                            onTap: () {
                              String address;
                              Get.to(const ChooseToken(fromPage: 'receive'))
                                  ?.then((value) {
                                if (value != null) {
                                  address = (value.networkName == 'Tron')
                                      ? (appController.userBalance.value.wallet
                                              ?.tronAddress ??
                                          '')
                                      : (value.networkName == 'Bitcoin' ||
                                              value.networkName ==
                                                  'Bitcoin (Testnet)')
                                          ? (appController.userBalance.value
                                                  .wallet?.btcAddress ??
                                              '')
                                          : (appController.userBalance.value
                                                  .wallet?.evmAddress ??
                                              '');
                                  _qrBottomSheet(
                                      context, address, value.symbol);
                                }
                              });
                            },
                          ),
                          _dashBTns(
                            svg: 'sum',
                            btnText: 'Wallet Summary',
                            onTap: () {
                              CommonWidgets()
                                  .selectWithdrawBottomSheet(context);
                            },
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

  Widget _buildCard(
      BuildContext context, String imagePath, String text, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          child: Container(
            padding: const EdgeInsets.all(16),
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).cardColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xffD8D9E4)),
                  ),
                  child: CircleAvatar(
                    radius: 22.0,
                    backgroundColor: primaryColor.value,
                    child: ClipOval(
                      child: Image.asset(
                        imagePath,
                        fit: BoxFit.cover,
                        width: 20.0,
                        height: 20.0,
                      ),
                    ),
                  ),
                ),
                Text(text),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _dashBTns({String? svg, String? btnText, Function? onTap}) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          onTap?.call();
        },
        child: Container(
          color: Colors.transparent,
          child: Column(
            children: [
              Column(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    child: Image.asset(
                      'images/$svg.png',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                '$btnText',
                style: TextStyle(
                  fontFamily: 'sfpro',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                  fontSize: 12.0,
                  letterSpacing: 0.37,
                  color: inputFieldTextColor.value,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _qrBottomSheet(BuildContext context, String address, String symbol) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.4,
          minChildSize: 0.3,
          maxChildSize: 0.8,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Receive $symbol',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: 200,
                    height: 200,
                    child: Image.network(
                      'https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=$address',
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Address: $address',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
