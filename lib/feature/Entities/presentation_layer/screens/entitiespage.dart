import 'package:finall/common/core/homeMaster.dart';
import 'package:finall/common/widgets/appbar.dart';
import 'package:finall/common/widgets/searchBar.dart';
import 'package:finall/feature/Home/presentation_layer/widgets/ministryCardGridvie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Entitiespage extends StatelessWidget {
  const Entitiespage({super.key});
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 30,

          children: [
            Appbar(
              texttitle: "Government entities",
              onPressed: () {
                Get.to(HomeMaster());
              },
            ),
            Searchbarr(),
            SizedBox(height: 20),
            ministryCardGridvie(),


            // SizedBox(
            //   height: MediaQuery.of(context).size.height,
            //   child: GridView.builder(
            //     shrinkWrap: true,
            //     physics: NeverScrollableScrollPhysics(),
            //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //       crossAxisCount: 2,
            //       mainAxisSpacing: 15,
            //       crossAxisSpacing: 15,
            //       childAspectRatio: 1,
            //     ),
            //     semanticChildCount: 2,
            //     padding: const EdgeInsets.symmetric(horizontal: 16),
            //     itemCount: offersImages.length,
            //     itemBuilder: (context, index) {
            //       return InkWell(
            //         onTap: () {},
            //         child: Container(
            //           width: 143,
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(16),
            //             image: DecorationImage(
            //               image: AssetImage(offersImages[index]),
            //               fit: BoxFit.cover,
            //             ),
            //           ),
            //         ),
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
