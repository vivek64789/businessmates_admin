import 'package:businessmates_admin/data/models/course/course_model.dart';
import 'package:businessmates_admin/data/models/course/course_section_model.dart';
import 'package:businessmates_admin/data/models/course_categories_model.dart';
import 'package:businessmates_admin/presentation/cubits/manage_course_section/manage_course_section_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/helpers/my_toast.dart';
import '../../../core/utils/validation_helper.dart';
import '../../cubits/manage_categories/manage_categories_cubit.dart';
import '../../widgets/bm_button.dart';
import '../../widgets/bm_text_form_field.dart';

class CreateNewCourseSectionScreen extends StatefulWidget {
  const CreateNewCourseSectionScreen(
      {super.key, this.category, this.course, this.section});
  static const String routeName = '/create_new_course_section';

  final CategoriesModel? category;
  final CourseModel? course;
  final CourseSectionModel? section;

  @override
  State<CreateNewCourseSectionScreen> createState() =>
      _CreateNewCourseSectionScreenState();
}

class _CreateNewCourseSectionScreenState
    extends State<CreateNewCourseSectionScreen> {
  // form key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

// text controllers

  final TextEditingController _courseNameController = TextEditingController();
  final TextEditingController _sectionNameController = TextEditingController();

  final TextEditingController _sectionDescriptionController =
      TextEditingController();

  late final ManageCourseSectionCubit manageCourseSectionCubit;

  @override
  void initState() {
    manageCourseSectionCubit = context.read<ManageCourseSectionCubit>();

    _courseNameController.text = widget.course?.name ?? '';
    // _courseDescriptionController.text = course?.description ?? '';
    // _courseImageController.text = course?.imageUrl ?? '';
    if (widget.section != null) {
      manageCourseSectionCubit.setCourseSectionModel(widget.section!);
      _courseNameController.text = widget.course!.name;
      _sectionNameController.text = widget.section!.name;
      _sectionDescriptionController.text = widget.section!.shortDescription;
    } else {
      manageCourseSectionCubit
          .setCourseSectionModel(CourseSectionModel.empty());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.section != null ? 'Update Section' : 'Create New Section'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child:
              BlocConsumer<ManageCourseSectionCubit, ManageCourseSectionState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              return Column(
                children: [
                  // design for the top of the screen
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
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
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: BMTextFormField(
                            controller: _courseNameController,
                            hintText: 'Course Name',
                            validator: (value) {
                              return isEmpty(value);
                            },
                            readonly: true,
                            errorColor: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: BMTextFormField(
                            controller: _sectionNameController,
                            hintText: 'Enter Section Name',
                            validator: (value) {
                              return isEmpty(value);
                            },
                            errorColor: Theme.of(context).colorScheme.onPrimary,
                            // onSaved: (value) {
                            //   manageCourseCubit.setCourseModel(
                            //     state.courseModel.copyWith(
                            //       name: value,
                            //     ),
                            //   );
                            // },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: BMTextFormField(
                            controller: _sectionDescriptionController,
                            maxLines: 10,
                            hintText: 'Enter Description',
                            validator: (value) {
                              return isEmpty(value);
                            },
                            errorColor: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ListTile(
                          title: Text(
                            'Is Preview Available for Free',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                          ),
                          trailing: Switch.adaptive(
                            value: manageCourseSectionCubit
                                .state.courseSectionModel.isLocked,
                            onChanged: (value) {
                              manageCourseSectionCubit.setCourseSectionModel(
                                manageCourseSectionCubit
                                    .state.courseSectionModel
                                    .copyWith(
                                  isLocked: value,
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        BlocConsumer<ManageCourseSectionCubit,
                            ManageCourseSectionState>(
                          listenWhen: (previous, current) {
                            return previous != current;
                          },
                          listener: (context, state) {
                            if (state.manageCourseSectionLoadingStatus ==
                                LoadingStatus.loaded) {
                              Navigator.of(context).pop();
                              myToast(
                                context: context,
                                widget: Text(widget.section != null
                                    ? "Section Updated Successfully"
                                    : 'Section Created Successfully'),
                              );
                            } else if (state.manageCourseSectionLoadingStatus ==
                                LoadingStatus.error) {
                              state.failureMessageOption.fold(
                                () => null,
                                (message) => myToast(
                                  context: context,
                                  widget: Text(
                                    message.when(
                                      serverError: (message) =>
                                          message.toString(),
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
                                      unableToGet: (message) =>
                                          message.toString(),
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
                              isLoading:
                                  state.manageCourseSectionLoadingStatus ==
                                      LoadingStatus.loading,
                              text: widget.section != null
                                  ? 'Update Section'
                                  : 'Create Section',
                              color: Theme.of(context).colorScheme.onPrimary,
                              foregroundColor:
                                  Theme.of(context).colorScheme.primary,
                              onPressed: () {
                                // validate form
                                if (_formKey.currentState!.validate()) {
                                  // if the form is valid
                                  if (widget.section != null) {
                                    manageCourseSectionCubit
                                        .updateCourseSection(
                                      courseSectionModel:
                                          state.courseSectionModel.copyWith(
                                        categoryId: widget.category!.id,
                                        name: _sectionNameController.text,
                                        shortDescription:
                                            _sectionDescriptionController.text,
                                      ),
                                    );
                                  } else {
                                    manageCourseSectionCubit
                                        .createNewCourseSection(
                                      courseSectionModel:
                                          state.courseSectionModel.copyWith(
                                        categoryId: widget.category!.id,
                                        name: _sectionNameController.text,
                                        shortDescription:
                                            _sectionDescriptionController.text,
                                        courseId: widget.course!.id,
                                      ),
                                    );
                                  }
                                }
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  // modern design for change email address

                  const SizedBox(
                    height: 20,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
