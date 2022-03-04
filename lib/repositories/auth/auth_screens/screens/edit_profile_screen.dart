import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mass_app/repositories/auth/auth_screens/utilities/auth_buttons.dart';
import 'package:mass_app/repositories/auth/auth_screens/utilities/auth_textfields.dart';
import 'package:mass_app/repositories/auth/auth_service/auth_repo.dart';
import 'package:mass_app/repositories/auth/auth_service/auth_service.dart';
import 'package:mass_app/repositories/auth/blocs%20&%20cubits/cubit/auth_cubits_cubit.dart';
import 'package:mass_app/repositories/auth/model/auth_model.dart';
import 'package:mass_app/utilities/extensions/string_extentions.dart';
import 'package:mass_app/utilities/widgets/utility_widgets.dart';

import '../../../../utilities/colors and doubles/colors.dart';
import '../../../home/screens/home_screen.dart';

final _formKey = GlobalKey<FormState>();

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key, required this.massian}) : super(key: key);

  final Massian massian;

  @override
  Widget build(BuildContext context) {
    String _name = massian.name;
    String _number = massian.name;
    String _image = '';
    bool _imageChanged = false;
    String _state = '';
    String _age = '';
    String _gender = '';
    String _city = '';
    String _school = '';
    String _occupation = '';

    File? _fImage;

    Future _pickImage() async {
      final _picker = ImagePicker();
      final pickedImage = await _picker.pickImage(
        imageQuality: 80,
        maxHeight: 400,
        maxWidth: 400,
        source: ImageSource.gallery,
      );

      _fImage = File(pickedImage!.path);
      _imageChanged = true;
    }

    Future<String> _getImage(String username) async {
      if (_fImage != null) {
        String _image = await AuthService().getImageUrl(username, _fImage!);
        return _image;
      } else {
        return '';
      }
    }

    return RepositoryProvider(
      create: (context) => AuthUserRepo(authService: AuthService()),
      child: BlocProvider(
        create: (context) =>
            AuthLoginCubit(authUserRepo: context.read<AuthUserRepo>()),
        child: BlocConsumer<AuthLoginCubit, AuthLoginState>(
            listener: (context, state) {
          if (state.status == LoginStatus.userLoaded) {
            var snackbar = SnackBar(
              content: 'Your profile has been successfully updated!'.obText,
              backgroundColor: primaryColor,
            );

            ScaffoldMessenger.of(context).showSnackBar(snackbar);
            Future.delayed(
              (const Duration(seconds: 2)),
              () => Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => HomeScreen(userId: state.massian.id),
                ),
                ModalRoute.withName('/Home'),
              ),
            );
          }
        }, builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: utilityAppBar('Account Settings'.bigBold),
            body: GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: CircleAvatar(
                        backgroundImage: _imageChanged
                            ? FileImage(_fImage!)
                            : NetworkImage(massian.image) as ImageProvider,
                        radius: 100,
                        child: IconButton(
                          onPressed: () {
                            _pickImage();
                          },
                          icon: const FaIcon(FontAwesomeIcons.edit),
                          iconSize: 20,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Center(child: massian.email.contentText),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          AuthTextField(
                            keyboardType: TextInputType.text,
                            onSubmitted: (a) {
                              _name = a!;
                            },
                            label: 'Name',
                            initial: massian.name,
                          ),
                          AuthTextField(
                            keyboardType: TextInputType.phone,
                            onSubmitted: (a) {
                              _number = a!;
                            },
                            label: 'Phone Number',
                            initial: massian.phoneNumber,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: AuthTextField(
                                  keyboardType: TextInputType.text,
                                  onSubmitted: (a) {
                                    _state = a!;
                                  },
                                  label: 'State',
                                  initial: massian.state,
                                ),
                              ),
                              const Spacer(flex: 2),
                              Expanded(
                                flex: 2,
                                child: AuthTextField(
                                  keyboardType: TextInputType.text,
                                  onSubmitted: (a) {
                                    _city = a!;
                                  },
                                  label: 'City',
                                  initial: massian.city,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: AuthTextField(
                                  keyboardType: TextInputType.text,
                                  onSubmitted: (a) {
                                    _gender = a!;
                                  },
                                  label: 'Gender',
                                  initial: massian.gender,
                                ),
                              ),
                              const Spacer(flex: 2),
                              Expanded(
                                flex: 2,
                                child: AuthTextField(
                                  keyboardType: TextInputType.number,
                                  onSubmitted: (a) {
                                    _age = a!;
                                  },
                                  label: 'Age',
                                  initial: massian.age,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          AuthTextField(
                            keyboardType: TextInputType.name,
                            onSubmitted: (a) {
                              _school = a!;
                            },
                            label: 'School (if student)',
                            initial: massian.school,
                          ),
                          AuthTextField(
                            keyboardType: TextInputType.name,
                            onSubmitted: (a) {
                              _occupation = a!;
                            },
                            label: 'Occupation (if worker)',
                            initial: massian.occupation,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    Center(
                        child: state.status == LoginStatus.loading
                            ? loader
                            : AuthButton(
                                text: 'Update Profile',
                                onPressed: () async {
                                  _formKey.currentState!.save();
                                  FocusScope.of(context).unfocus();
                                  _image = await _getImage(massian.name);
                                  Massian _ma = Massian(
                                    name: _name,
                                    id: massian.id,
                                    phoneNumber: _number,
                                    email: massian.email,
                                    state: _state,
                                    city: _city,
                                    age: _age,
                                    gender: _gender,
                                    occupation: _occupation,
                                    school: _school,
                                    image:
                                        _imageChanged ? _image : massian.image,
                                  );
                                  context
                                      .read<AuthLoginCubit>()
                                      .updateMassian(_ma, massian.id);
                                  _formKey.currentState!.reset();
                                },
                              )),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
