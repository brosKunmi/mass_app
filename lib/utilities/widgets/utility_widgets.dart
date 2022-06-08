import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mass_app/utilities/colors%20and%20doubles/colors.dart';
import 'package:mass_app/utilities/colors%20and%20doubles/doubles.dart';
import 'package:mass_app/utilities/extensions/string_extentions.dart';
import 'package:shimmer/shimmer.dart';

final loader = SpinKitCubeGrid(
  color: primaryColor,
  size: 40,
);

Widget shimshim(String title) {
  return Shimmer.fromColors(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 12, 0, 4),
          child: title.bigBold,
        ),
        Container(
          margin: const EdgeInsets.all(6.0),
          child: ClipRRect(
            child: Image.asset(
              'disciple'.png,
              fit: BoxFit.cover,
            ),
            borderRadius: otherBR,
          ),
          height: 200,
          width: 200,
          decoration: BoxDecoration(borderRadius: otherBR),
        ),
      ],
    ),
    enabled: true,
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade300,
  );
}

AppBar utilityAppBar(Widget title, {Color? color}) {
  return AppBar(
    elevation: 0,
    title: title,
    backgroundColor: Colors.transparent,
    actions: [
      Card(
        elevation: 0,
        color: Colors.transparent,
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: color ?? primaryColor, width: 0.5),
          borderRadius: otherBR,
        ),
        child: IconButton(
          onPressed: () {},
          padding: const EdgeInsets.all(0),
          icon: FaIcon(
            FontAwesomeIcons.solidBookmark,
            color: color ?? primaryColor,
            size: 20,
          ),
        ),
      ),
    ],
    leading: Card(
      elevation: 0,
      color: Colors.transparent,
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: color ?? primaryColor, width: 0.5),
        borderRadius: otherBR,
      ),
      child: BackButton(
        color: color ?? primaryColor,
      ),
    ),
  );
}
