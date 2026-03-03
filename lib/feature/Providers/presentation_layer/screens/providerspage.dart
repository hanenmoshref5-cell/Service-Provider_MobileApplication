import 'package:finall/feature/Providers/busness_logic_layer/providerscontroller.dart';
import 'package:finall/feature/Providers/presentation_layer/widgets/listviewproviders.dart';
import 'package:finall/common/core/homeMaster.dart';
import 'package:finall/common/widgets/appbar.dart';
import 'package:finall/common/widgets/searchBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Providerspage extends StatelessWidget {
  Providerspage({super.key});
  final Providerscontroller providerscontroller = Providerscontroller();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Appbar(
              texttitle: "Service Providers",
              onPressed: () {
                Get.to(HomeMaster());
              },
            ),
            Searchbarr(),
            SizedBox(height: 20),
            Listviewproviders(serviceproviders: providerscontroller.providers,),
          ],
        ),
      ),
    );
  }
}
