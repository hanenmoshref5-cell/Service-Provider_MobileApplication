import 'package:finall/feature/Offers/busness_logic_layer/offerscontroller.dart';
import 'package:finall/feature/Offers/presentation_layer/widgets/offerCard.dart';
import 'package:finall/common/core/homeMaster.dart';
import 'package:finall/common/widgets/appbar.dart';
import 'package:finall/common/widgets/searchBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Offerspage extends StatelessWidget {
  Offerspage({super.key});

  final OfferController controller = Get.put(OfferController());

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
              texttitle: "Offers List",
              onPressed: () {
                Get.to(HomeMaster());
              },
            ),
            Searchbarr(
              onchange: (p0) {
                controller.onSearchChanged(p0);
              },
            ),
            SizedBox(height: 20),
            Obx(() {
              // if (controller.isLoading.value) {
              //   return const Center(child: CircularProgressIndicator());
              // }
              

              return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.7,
                  ),
                  semanticChildCount: 2,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: controller.offers.length,
                  itemBuilder: (context, index) {
                    return OfferCard(offer: controller.offers[index]);
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
