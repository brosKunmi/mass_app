import 'package:flutter/material.dart';
import 'package:mass_app/utilities/buttons/container_buttons.dart';
import 'package:mass_app/utilities/extensions/string_extentions.dart';

class HomeButtonRow extends StatelessWidget {
  const HomeButtonRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _buttonActions = [
      {'text': 'Become a Volunteer', 'image': 'volunteer', 'onTap': () {}},
      {'text': 'Become a Disciple', 'image': 'disciple', 'onTap': () {}},
      {'text': 'Join our Telegram', 'image': 'telegram', 'onTap': () {}},
      {'text': 'Support Us', 'image': 'donate', 'onTap': () {}},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 16, 0, 8),
          child: 'Quick Access'.bigBold,
        ),
        SizedBox(
          height: 150,
          child: MediaQuery.removePadding(
            removeBottom: true,
            removeRight: true,
            removeLeft: true,
            context: context,
            child: ListView.separated(
              shrinkWrap: true,
              clipBehavior: Clip.none,
              padding: const EdgeInsets.all(0),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return HomeRowButtons(
                    image: _buttonActions[index]['image'].toString(),
                    text: _buttonActions[index]['text'].toString(),
                    onTap: () {
                      _buttonActions[index]['onTap'];
                    });
              },
              itemCount: _buttonActions.length,
              separatorBuilder: (_, index) => const SizedBox(width: 2),
            ),
          ),
        ),
      ],
    );
  }
}
