import 'package:flutter/material.dart';
import 'package:kino_app/core/theme/app_colors.dart';
import 'package:kino_app/core/theme/text_styles.dart';

class CategoryTitleWidget extends StatelessWidget {
  final String? title;
  final Function? onTap;

  const CategoryTitleWidget({Key? key, this.title, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title!, style: stySectionTitle),
              IconButton(
                iconSize: 32,
                onPressed: onTap as void Function()?,
                icon: const Icon(
                  Icons.arrow_right_alt_outlined,
                  color: clrWhite,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
