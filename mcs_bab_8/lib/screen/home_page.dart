import 'package:flutter/material.dart';
import 'package:mcs_bab_8/provider/app_provider.dart';
import 'package:mcs_bab_8/widget/custom_servo_button.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Provider.of<AppProvider>(context, listen: false).getUid();
    Provider.of<AppProvider>(context, listen: false).getServoStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, appProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Flutter Servo & Cards Control',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Color(0xff0B192C),
          ),
          body: Column(
            children: [
              const SizedBox(height: 50),

              CustomServoButton(
                textLeftButton: appProvider.textLeftButton,
                textRightButton: appProvider.textRightButton,
                colorLeftButton: appProvider.colorLeftButton,
                colorRightButton: appProvider.colorRightButton,
                onTapLeftButton: () =>
                    appProvider.changeServoStatus(status: "0"),
                onTapRightButton: () =>
                    appProvider.changeServoStatus(status: "1"),
              ),

              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Servo Status : ", style: const TextStyle(fontSize: 20)),
                  StreamBuilder(
                    stream: appProvider.getServoStatus(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text("-");
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text("Error => ${snapshot.error}"),
                        );
                      } else {
                        appProvider.servoStatus = appProvider
                            .servoStatusModel!
                            .result[0]
                            .srvStatus
                            .toString();
                        return Text(appProvider.servoStatus);
                      }
                    },
                  ),
                ],
              ),

              const SizedBox(height: 40),

              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(width: 3, color: Colors.black),
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: const Column(
                  children: [SizedBox(height: 30), Text("Card ID Register:")],
                ),
              ),

              Expanded(
                child: StreamBuilder(
                  stream: appProvider.getUid(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text("Error to get ID: ${snapshot.error}"),
                      );
                    } else if (snapshot.data == null || !snapshot.hasData) {
                      return const Center(child: Text("No data to display"));
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: appProvider.cardBridgeModel!.result.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 40,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  appProvider.cardBridgeModel!.result[index].id,
                                ),
                                GestureDetector(
                                  child: const Icon(Icons.delete),
                                  onTap: () {
                                    appProvider.deleteUid(
                                      uid: appProvider
                                          .cardBridgeModel!
                                          .result[index]
                                          .id,
                                    );
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
