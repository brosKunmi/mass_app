import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mass_app/repositories/events/bloc/event_bloc.dart';
import 'package:mass_app/repositories/events/widgets/no_event_tile.dart';
import 'package:mass_app/repositories/events/widgets/attend_page.dart';

import 'package:mass_app/utilities/buttons/circular_button.dart';
import 'package:mass_app/utilities/colors%20and%20doubles/colors.dart';

import 'package:mass_app/utilities/colors%20and%20doubles/doubles.dart';
import 'package:mass_app/utilities/extensions/string_extentions.dart';
import 'package:mass_app/utilities/widgets/utility_widgets.dart';

class EventTile extends StatelessWidget {
  const EventTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventBloc, EventState>(
      builder: (context, state) {
        if (state.status == EventStatus.loading) {
          return shimshim('Checking upcoming event');
        } else if (state.status == EventStatus.error) {
          return const NoEventTile();
        } else if (state.status == EventStatus.loaded) {
          var _event = state.event;

          return Hero(
            tag: _event.title,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 16, 0, 8),
                  child: 'Upcoming Events'.bigBold,
                ),
                Center(
                  child: Container(
                    margin: const EdgeInsets.all(6.0),
                    height: 250,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      borderRadius: buttonBR,
                      boxShadow: kBoxShadow,
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: commonR,
                            topRight: commonR,
                          ),
                          child: ExtendedImage.network(
                            _event.image,
                            height: 132,
                            width: MediaQuery.of(context).size.width * 0.9,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _event.title.tileText,
                                  const SizedBox(height: 8.0),
                                  Row(
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.calendar,
                                        size: 12,
                                        color: primaryColor,
                                      ),
                                      const SizedBox(width: 2),
                                      _event.date.buttonText,
                                      const SizedBox(width: 12.0),
                                      FaIcon(
                                        FontAwesomeIcons.clock,
                                        size: 12,
                                        color: primaryColor,
                                      ),
                                      const SizedBox(width: 2),
                                      _event.time.buttonText,
                                      const Spacer(),
                                      FaIcon(
                                        FontAwesomeIcons.locationArrow,
                                        size: 12,
                                        color: primaryColor,
                                      ),
                                      const SizedBox(width: 2.0),
                                      _event.venue.buttonText
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        CircularButton(
                          filled: false,
                          text: 'ATTEND',
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (c) => AttendEvent(event: _event),
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}
