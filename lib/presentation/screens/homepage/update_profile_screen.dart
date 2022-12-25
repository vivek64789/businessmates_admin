import 'package:businessmates_admin/core/design/app_icons.dart';
import 'package:businessmates_admin/core/utils/constants.dart';
import 'package:businessmates_admin/data/models/user_profile_model.dart';
import 'package:businessmates_admin/presentation/cubits/manage_profile/manage_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/helpers/my_toast.dart';
import '../../../core/utils/validation_helper.dart';
import '../../cubits/image_cubit/image_cubit.dart';
import '../../cubits/manage_categories/manage_categories_cubit.dart';
import '../../widgets/bm_button.dart';
import '../../widgets/bm_text_form_field.dart';

class UpdateProfileScreen extends StatelessWidget {
  static const String routeName = '/update_profile_screen';
  UpdateProfileScreen({Key? key, this.userProfileModel}) : super(key: key);

  final UserProfileModel? userProfileModel;

  // form key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
// text controllers

  final TextEditingController _profileNameController = TextEditingController();
  final TextEditingController _profileAddressController =
      TextEditingController();
  final TextEditingController _profileCityController = TextEditingController();
  final TextEditingController _profileCountryController =
      TextEditingController();
  final TextEditingController _profileImageUrlController =
      TextEditingController();
  final TextEditingController _profilePhoneController = TextEditingController();
  final TextEditingController _profileStateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ManageProfileCubit manageProfileCubit = context.read<ManageProfileCubit>();
    manageProfileCubit.setUserProfileModel(userProfileModel!);
    ImageCubit imageCubit = context.read<ImageCubit>();
    _profileNameController.text = userProfileModel?.name ?? '';

    _profileAddressController.text = userProfileModel?.address ?? '';
    _profileCityController.text = userProfileModel?.city ?? '';
    _profileCountryController.text = userProfileModel?.country ?? '';
    _profileImageUrlController.text = userProfileModel?.imageUrl ?? '';
    _profilePhoneController.text = userProfileModel?.phone ?? '';
    _profileStateController.text = userProfileModel?.state ?? '';

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: FloatingActionButton(
        mini: true,
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Icon(
          BMIcon.arrow_left,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 50,
                ),
                // height: MediaQuery.of(context).size.height * 0.6,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 10,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onPrimary,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(
                            userProfileModel!.imageUrl.isNotEmpty
                                ? userProfileModel!.imageUrl
                                : Constants.placeholderImage,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: IconButton(
                        icon: Icon(BMIcon.pen,
                            color: Theme.of(context).colorScheme.primary),
                        onPressed: () async {
                          final url =
                              await imageCubit.showImageUploadSheet(context);
                          _profileImageUrlController.text = url;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10.0),
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: BMTextFormField(
                        controller: _profileNameController,
                        hintText: 'Enter Your Name',
                        validator: (value) {
                          return isEmpty(value);
                        },
                        errorColor: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10.0),
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: BMTextFormField(
                        controller: _profilePhoneController,
                        hintText: 'Enter Your Phone',
                        validator: (value) {
                          return isEmpty(value);
                        },
                        errorColor: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10.0),
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: BMTextFormField(
                        controller: _profileAddressController,
                        hintText: 'Enter Your Street Address',
                        validator: (value) {
                          return isEmpty(value);
                        },
                        errorColor: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10.0),
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: BMTextFormField(
                        controller: _profileCityController,
                        hintText: 'Enter Your City',
                        validator: (value) {
                          return isEmpty(value);
                        },
                        errorColor: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10.0),
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: BMTextFormField(
                        controller: _profileStateController,
                        hintText: 'Enter Your State',
                        validator: (value) {
                          return isEmpty(value);
                        },
                        errorColor: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10.0),
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: BMTextFormField(
                        controller: _profileCountryController,
                        hintText: 'Enter Your Country',
                        validator: (value) {
                          return isEmpty(value);
                        },
                        errorColor: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    BlocConsumer<ManageProfileCubit, ManageProfileState>(
                      listener: (context, state) {
                        if (state.manageProfileLoadingStatus ==
                            LoadingStatus.loaded) {
                          Navigator.of(context).pop();
                          myToast(
                            context: context,
                            widget: Text(userProfileModel != null
                                ? "Profile Updated Successfully"
                                : 'Profile Created Successfully'),
                          );
                        } else if (state.manageProfileLoadingStatus ==
                            LoadingStatus.error) {
                          state.failureMessageOption.fold(
                            () => null,
                            (message) => myToast(
                              context: context,
                              widget: Text(
                                message.when(
                                  serverError: (message) => message.toString(),
                                  noInternetConnection: (message) =>
                                      message.toString(),
                                  tooManyRequests: (message) =>
                                      message.toString(),
                                  deviceNotSupported: (message) =>
                                      message.toString(),
                                  alreadyExists: (message) =>
                                      message.toString(),
                                  notFound: (message) => message.toString(),
                                  unableToCreate: (message) =>
                                      message.toString(),
                                  unableToUpdate: (message) =>
                                      message.toString(),
                                  unableToDelete: (message) =>
                                      message.toString(),
                                  unableToGet: (message) => message.toString(),
                                  unableToGetAll: (message) =>
                                      message.toString(),
                                  unexpectedError: (message) =>
                                      message.toString(),
                                ),
                              ),
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        return BMButton(
                          isLoading: state.manageProfileLoadingStatus ==
                              LoadingStatus.loading,
                          text: userProfileModel != null
                              ? 'Update Profile'
                              : 'Create Profile',
                          color: Theme.of(context).colorScheme.onPrimary,
                          foregroundColor:
                              Theme.of(context).colorScheme.primary,
                          onPressed: () {
                            // validate form
                            if (_formKey.currentState!.validate()) {
                              // if the form is valid
                              if (userProfileModel != null) {
                                manageProfileCubit.updateProfile(
                                  userProfileModel:
                                      state.userProfileModel.copyWith(
                                    imageUrl: _profileImageUrlController.text,
                                    name: _profileNameController.text,
                                    phone: _profilePhoneController.text,
                                    address: _profileAddressController.text,
                                    city: _profileCityController.text,
                                    state: _profileStateController.text,
                                    country: _profileCountryController.text,
                                    email: userProfileModel!.email,
                                    
                                  ),
                                );
                              }
                            }
                          },
                        );
                      },
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
              // modern design for change email address

              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


        // role: '',
        // email: '',
        // name: '',
        // phone: '',
        // address: '',
        // city: '',
        // state: '',
        // country: '',
        // imageUrl: '',