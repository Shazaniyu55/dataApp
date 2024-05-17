// ignore_for_file: use_super_parameters, sized_box_for_whitespace, avoid_unnecessary_containers, unused_element, prefer_interpolation_to_compose_strings, unnecessary_string_interpolations

import 'package:dataapp/constant/colors.dart';
import 'package:dataapp/controller/appController.dart';
import 'package:dataapp/model/walletBalace.dart';
import 'package:dataapp/screens/choosetoken/choosetoken.dart';
import 'package:dataapp/services/utilservice.dart';
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
        ///backgroundColor: primaryColor.value,
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0.0),
          child: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle(
              // Status bar color
              statusBarColor: primaryColor.value,

              // Status bar brightness (optional)
              statusBarIconBrightness: Brightness.light,
              statusBarBrightness: Brightness.dark,
            ),
            elevation: 0,
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
                          const SizedBox(
                            height: 30,
                          ),
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
                                const SizedBox(
                                  height: 20,
                                ),
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
                            // Use Wrap instead of Row to handle overflow
                            Wrap(
                              spacing: 10, // spacing between the cards
                              runSpacing: 10, // spacing between the rows
                              children: [
                                _buildCard(
                                    context, "images/phone.png", "Buy Airtime"),
                                _buildCard(
                                    context, "images/wifi.png", "Buy Data"),
                                _buildCard(
                                    context, "images/wifi.png", "Buy Data"),
                                _buildCard(
                                    context, "images/phone.png", "Buy Airtime"),
                                _buildCard(
                                    context, "images/wifi.png", "Buy Data"),
                                _buildCard(
                                    context, "images/wifi.png", "Buy Data"),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
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
                          boxShadow: appShadow),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      child: Row(
                        children: [
                          _dashBTns(
                              svg: 'pin',
                              btnText: 'Utility',
                              onTap: () {
                                //Get.to(ChooseToken(fromPage: 'send',));
                                CommonWidgets()
                                    .selectWithdrawBottomSheet(context);
                              }),
                          const SizedBox(
                            width: 20,
                          ),
                          _dashBTns(
                              svg: 'util',
                              btnText: 'Data',
                              onTap: () {
                                String address;
                                Get.to(const ChooseToken(
                                  fromPage: 'receive',
                                ))?.then((value) {
                                  if (value != null) {
                                    address = (value.networkName == 'Tron')
                                        ? (appController.userBalance.value
                                                .wallet?.tronAddress ??
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
                                    _qrBottomSheeet(
                                        context, address, value.symbol);
                                  }
                                });
                              }),
                          _dashBTns(
                              svg: 'call',
                              btnText: 'Airtime',
                              onTap: () {
                                //Get.to(ChooseToken(fromPage: 'send',));
                                CommonWidgets()
                                    .selectWithdrawBottomSheet(context);
                              }),
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

  Widget _coinRow(
      {String? coinName,
      String? amountInEth,
      String? amountInUSD,
      String? percentage,
      String? priceInUSD,
      String? imgName,
      required bool increment,
      Balance? token}) {
    return GestureDetector(
      onTap: () {
        //Get.to(CoinHistory(token: token!,));
      },
      child: Container(
        width: Get.width,
        padding: const EdgeInsets.symmetric(vertical: 10),
        color: Colors.transparent,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      color: lightColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    clipBehavior: Clip.antiAlias,
                  ),
                  const SizedBox(
                    width: 14,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '$coinName',
                            style: TextStyle(
                              fontFamily: 'sfpro',
                              color: headingColor.value,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0,
                              letterSpacing: 0.37,
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Text(
                            '${0.0}',
                            style: TextStyle(
                              fontFamily: 'sfpro',
                              color: placeholderColor,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                              fontSize: 14.0,
                              letterSpacing: 0.44,
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          increment == true
                              ? Text(
                                  '+ $percentage%',
                                  style: TextStyle(
                                      fontFamily: 'sfpro',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13.0,
                                      letterSpacing: 0.44,
                                      color: greenCardColor.value),
                                )
                              : Text(
                                  ' $percentage%',
                                  style: TextStyle(
                                      fontFamily: 'sfpro',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13.0,
                                      letterSpacing: 0.44,
                                      color: redCardColor.value),
                                ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Text(
                        '$amountInEth',
                        style: TextStyle(
                          fontFamily: 'sfpro',
                          color: headingColor.value,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                          letterSpacing: 0.37,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '${0.0}',
                    style: TextStyle(
                      fontFamily: 'sfpro',
                      color: placeholderColor,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                      fontSize: 14.0,
                      letterSpacing: 0.44,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper function to build a card
  Widget _buildCard(BuildContext context, String imagePath, String text) {
    return Card(
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
                backgroundColor: Colors.amber,
                child: ClipOval(
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    width: 44.0,
                    height: 44.0,
                  ),
                ),
              ),
            ),
            Text(text),
          ],
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
                      color: inputFieldTextColor.value,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                '$btnText',
                style: TextStyle(
                  fontFamily: 'sfpro',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                  fontSize: 16.0,
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

  Future _qrBottomSheeet(
      BuildContext context, String address, String coinSymbol) {
    return Get.bottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.black26,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      Container(
        padding: const EdgeInsets.all(20),
        height: Get.height * 0.63,
        decoration: BoxDecoration(
            color: primaryBackgroundColor.value,
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20))),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Receive",
                  style: TextStyle(
                      fontFamily: 'sfpro',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w600,
                      fontSize: 26.0,
                      letterSpacing: 0.44,
                      color: headingColor.value),
                ),
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.clear,
                      color: headingColor.value,
                    ))
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), color: lightColor),
              padding: const EdgeInsets.all(6),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Send only ($coinSymbol) to this address.\nSending any other coins may result in permanent loss.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'sfpro',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                  fontSize: 11.0,
                  letterSpacing: 0.44,
                  color: placeholderColor),
            ),
            const SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {
                UtilService().copyToClipboard(address);
              },
              child: Container(
                height: 30,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: bSheetbtnColor),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ImageIcon(
                      const AssetImage("assets/imgs/Icons1.png"),
                      color: primaryColor.value,
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Text(
                      '${address.substring(0, 5) + '...' + address.substring(address.length - 4)}',
                      style: TextStyle(
                          fontFamily: 'sfpro',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                          fontSize: 14.0,
                          letterSpacing: 0.44,
                          color: primaryColor.value),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
