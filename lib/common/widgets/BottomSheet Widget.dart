import 'package:finall/common/filter/filter_option.dart';
import 'package:finall/common/filter/filter_type.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showFilterBottomSheet({
  required BuildContext context,
  required String title,
  required List<FilterOption> options,
  required Function(FilterType) onSelected,
}) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(
                  icon:  Icon(Icons.close),
                  onPressed: () => Get.back(),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Column(
            //   children: options.map((option) {
            //     return ListTile(
            //       leading: Icon(option.icon),
            //       title: Text(option.title),
            //       onTap: () {
            //         onSelected(option.type);
            //         Get.back();
            //       },
            //     );
            //   }).toList(),
            // ),
          ],
        ),
      );
    },
  );
}
