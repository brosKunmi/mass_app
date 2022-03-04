import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mass_app/repositories/auth/auth_screens/utilities/auth_buttons.dart';
import 'package:mass_app/repositories/auth/auth_screens/utilities/auth_textfields.dart';
import 'package:mass_app/repositories/events/bloc/event_bloc.dart';
import 'package:mass_app/repositories/events/models/event_model.dart';
import 'package:mass_app/repositories/events/service/event_repo.dart';
import 'package:mass_app/repositories/events/service/event_service.dart';

import 'package:mass_app/utilities/extensions/string_extentions.dart';
import 'package:mass_app/utilities/widgets/utility_widgets.dart';

import '../../../utilities/colors and doubles/colors.dart';

final _formKey = GlobalKey<FormState>();

class AttendEvent extends StatelessWidget {
  const AttendEvent({Key? key, required this.event}) : super(key: key);

  final MassEvent event;
  @override
  Widget build(BuildContext context) {
    double _tHeight = MediaQuery.of(context).size.height;

    String states = '';
    String city = '';
    String name = '';
    String email = '';
    String phoneNumber = '';
    String school = '';
    String occupation = '';

    return RepositoryProvider(
      create: (context) => MassEventRepository(service: EventService()),
      child: BlocProvider(
        create: (context) =>
            EventBloc(eventRepo: context.read<MassEventRepository>()),
        child: BlocConsumer<EventBloc, EventState>(
          listener: (context, state) {
            if (state.status == EventStatus.loaded) {
              var snackbar = SnackBar(
                content: 'Registration successful!'.obText,
                backgroundColor: primaryColor,
              );

              ScaffoldMessenger.of(context).showSnackBar(snackbar);
              Future.delayed(
                (const Duration(seconds: 2)),
                () => Navigator.of(context).pop(),
              );
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: utilityAppBar('Attend ${event.title}'.bigBold),
              resizeToAvoidBottomInset: false,
              body: GestureDetector(
                onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Hero(
                          tag: event.title,
                          child: ExtendedImage.network(
                            event.image,
                            width: double.infinity,
                            height: _tHeight * 0.3,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const FaIcon(
                              FontAwesomeIcons.calendar,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            '${event.date}, ${event.time}'.authText,
                            const Spacer(),
                            const FaIcon(
                              FontAwesomeIcons.locationArrow,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            event.venue.contentText,
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Divider(
                          thickness: 0.8,
                        ),
                        'Please fill the form below to register'.profText,
                        const SizedBox(height: 8),
                        AuthTextField(
                          keyboardType: TextInputType.text,
                          onSubmitted: (a) {
                            name = a!;
                          },
                          label: 'Name',
                        ),
                        AuthTextField(
                          keyboardType: TextInputType.text,
                          onSubmitted: (a) {
                            email = a!;
                          },
                          label: 'Email',
                        ),
                        AuthTextField(
                          keyboardType: TextInputType.phone,
                          onSubmitted: (a) {
                            phoneNumber = a!;
                          },
                          label: 'Phone Number',
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: AuthTextField(
                                keyboardType: TextInputType.text,
                                onSubmitted: (a) {
                                  states = a!;
                                },
                                label: 'State',
                              ),
                            ),
                            const Spacer(flex: 2),
                            Expanded(
                              flex: 2,
                              child: AuthTextField(
                                keyboardType: TextInputType.text,
                                onSubmitted: (a) {
                                  city = a!;
                                },
                                label: 'City',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        AuthTextField(
                          keyboardType: TextInputType.name,
                          onSubmitted: (a) {
                            school = a!;
                          },
                          label: 'School (if student)',
                        ),
                        AuthTextField(
                          keyboardType: TextInputType.name,
                          onSubmitted: (a) {
                            occupation = a!;
                          },
                          label: 'Occupation (if worker)',
                        ),
                        const SizedBox(height: 16),
                        Center(
                          child: state.status == EventStatus.loading
                              ? loader
                              : AuthButton(
                                  text: 'SUBMIT',
                                  onPressed: () {
                                    _formKey.currentState!.save();
                                    EventAttendee _attendee = EventAttendee(
                                        name: name,
                                        email: email,
                                        phoneNumber: phoneNumber,
                                        state: states,
                                        city: city,
                                        school: school,
                                        occupation: occupation);
                                    context
                                        .read<EventBloc>()
                                        .add(RegisterForEvent(_attendee));
                                  },
                                ),
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
