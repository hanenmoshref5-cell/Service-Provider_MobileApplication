import 'package:finall/feature/Providers/busness_logic_layer/providerscontroller.dart';
import 'package:finall/feature/categories/data_layer/models/categoryClass.dart';
import 'package:finall/common/widgets/appbar.dart';
import 'package:finall/common/widgets/searchBar.dart';
import 'package:finall/feature/subcategory/business_logic_layer/subcategorycontroller.dart';
import 'package:finall/feature/subcategory/presentation_layer/widgets/listsubprovider.dart';
import 'package:finall/feature/subcategory/presentation_layer/widgets/rowsubcategory.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Subpage extends StatefulWidget {
  final CategoryClass category;

  const Subpage({super.key, required this.category});

  @override
  State<Subpage> createState() => _SubpageState();
}

class _SubpageState extends State<Subpage> {
  final Providerscontroller providerscontroller = Get.put(
    Providerscontroller(),
  );
  final Subcategorycontroller subcategorycontroller = Get.put(
    Subcategorycontroller(),
  );

  @override
  void initState() {
    super.initState();
    subcategorycontroller.loadsubCategories(widget.category.id);
    subcategorycontroller.loadsubprovider(widget.category.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Appbar(
              texttitle: widget.category.name,
              onPressed: () => Get.back(),
            ),
            Searchbarr(),
            Rowsubcategory(categoryId: widget.category.id),
            Listsubproviders(subCategoryId: widget.category.id),
          ],
        ),
      ),
    );
  }
}
