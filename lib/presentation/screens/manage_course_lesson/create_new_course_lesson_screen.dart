import 'package:businessmates_admin/data/models/course/course_lesson_model.dart';
import 'package:businessmates_admin/data/models/course/course_model.dart';
import 'package:businessmates_admin/data/models/course/course_section_model.dart';
import 'package:businessmates_admin/data/models/course_categories_model.dart';
import 'package:businessmates_admin/presentation/cubits/manage_course_lesson/manage_course_lesson_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/helpers/my_toast.dart';
import '../../../core/utils/validation_helper.dart';
import '../../cubits/image_cubit/image_cubit.dart';
import '../../cubits/manage_categories/manage_categories_cubit.dart';
import '../../widgets/bm_button.dart';
import '../../widgets/bm_text_form_field.dart';

class CreateNewCourseLessonScreen extends StatefulWidget {
  const CreateNewCourseLessonScreen(
      {super.key, this.category, this.course, this.section, this.lesson});
  static const String routeName = '/create_new_course_lesson';

  final CategoriesModel? category;
  final CourseModel? course;
  final CourseSectionModel? section;
  final CourseLessonModel? lesson;

  @override
  State<CreateNewCourseLessonScreen> createState() =>
      _CreateNewCourseLessonScreenState();
}

class _CreateNewCourseLessonScreenState
    extends State<CreateNewCourseLessonScreen> {
  // form key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

// text controllers
  final TextEditingController _sectionNameController = TextEditingController();

  final TextEditingController _lessonNameController = TextEditingController();

  final TextEditingController _lessonShortDescriptionController =
      TextEditingController();
  final TextEditingController _lessonDescriptionController =
      TextEditingController();
  final TextEditingController _lessonVideoUrlController =
      TextEditingController();
  final TextEditingController _lessonImageUrlController =
      TextEditingController();
  final TextEditingController _lessonDurationController =
      TextEditingController();

  late final ManageCourseLessonCubit manageCourseLessonCubit;
  late final ImageCubit imageCubit;

  @override
  void initState() {
    manageCourseLessonCubit = context.read<ManageCourseLessonCubit>();

    imageCubit = context.read<ImageCubit>();
    _sectionNameController.text = widget.section!.name.isNotEmpty
        ? "Section Name: ${widget.section!.name}"
        : '';
    // _courseDescriptionController.text = course?.description ?? '';
    // _courseImageController.text = course?.imageUrl ?? '';
    if (widget.lesson != null) {
      manageCourseLessonCubit.setCourseLessonModel(widget.lesson!);
      _lessonNameController.text = widget.lesson!.name;
      _lessonDescriptionController.text = widget.lesson!.description;
      _lessonShortDescriptionController.text = widget.lesson!.shortDescription;
      _lessonVideoUrlController.text = widget.lesson!.videoUrl;
      _lessonImageUrlController.text = widget.lesson!.imageUrl;
      _lessonDurationController.text = widget.lesson!.duration.toString();
    } else {
      manageCourseLessonCubit.setCourseLessonModel(CourseLessonModel.empty());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: const [
            Text('Create New Lesson'),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: BlocConsumer<ManageCourseLessonCubit, ManageCourseLessonState>(
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
                            controller: _sectionNameController,
                            hintText: 'Section Name',
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
                            controller: _lessonNameController,
                            hintText: 'Enter Lesson Name',
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
                            controller: _lessonShortDescriptionController,
                            maxLines: 10,
                            hintText: 'Enter Short Description',
                            validator: (value) {
                              return isEmpty(value);
                            },
                            errorColor: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: BMTextFormField(
                            controller: _lessonDescriptionController,
                            maxLines: 10,
                            hintText: 'Enter your content here',
                            validator: (value) {
                              return isEmpty(value);
                            },
                            errorColor: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: BMTextFormField(
                            controller: _lessonVideoUrlController,
                            hintText: 'Enter Youtube Video URL (Optional)',

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
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: TextButton.icon(
                            icon: Icon(Icons.image,
                                color: Theme.of(context).colorScheme.onPrimary),
                            label: Text('Upload Lesson Image (Optional)',
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                )),
                            onPressed: () async {
                              final url = await imageCubit
                                  .showImageUploadSheet(context);
                              _lessonImageUrlController.text = url;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: BMTextFormField(
                            controller: _lessonDurationController,
                            // onSaved: (value) {
                            //   manageCourseCubit.setCourseModel(
                            //     state.courseModel.copyWith(
                            //       price: double.parse(value),
                            //     ),
                            //   );
                            // },
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9.]')),
                            ],
                            hintText: 'Enter Lesson Duration in Minutes',
                            validator: (value) {
                              return isEmpty(value);
                            },
                            keyboardType: TextInputType.number,
                            errorColor: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                        // image upload ui modern

                        const SizedBox(
                          height: 10,
                        ),
                        ListTile(
                          title: Text(
                            'Is Course Available for Preview for free ',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                          ),
                          trailing: Switch.adaptive(
                            value: state.courseLessonModel.isLocked,
                            onChanged: (value) {
                              manageCourseLessonCubit.setCourseLessonModel(
                                manageCourseLessonCubit.state.courseLessonModel
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
                        BlocConsumer<ManageCourseLessonCubit,
                            ManageCourseLessonState>(
                          listenWhen: (previous, current) {
                            return previous != current;
                          },
                          listener: (context, state) {
                            if (state.manageCourseLessonLoadingStatus ==
                                LoadingStatus.loaded) {
                              Navigator.of(context).pop();
                              myToast(
                                context: context,
                                widget: Text(widget.lesson != null
                                    ? "Lesson Updated Successfully"
                                    : 'Lesson Created Successfully'),
                              );
                            } else if (state.manageCourseLessonLoadingStatus ==
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
                                  state.manageCourseLessonLoadingStatus ==
                                      LoadingStatus.loading,
                              text: widget.lesson != null
                                  ? 'Update Lesson'
                                  : 'Create Lesson',
                              color: Theme.of(context).colorScheme.onPrimary,
                              foregroundColor:
                                  Theme.of(context).colorScheme.primary,
                              onPressed: () {
                                // validate form
                                if (_formKey.currentState!.validate()) {
                                  // if the form is valid
                                  if (widget.lesson != null) {
                                    manageCourseLessonCubit.updateCourseLesson(
                                      courseLessonModel:
                                          state.courseLessonModel.copyWith(
                                        imageUrl:
                                            _lessonImageUrlController.text,
                                        videoUrl:
                                            _lessonVideoUrlController.text,
                                        courseId: widget.course!.id,
                                        sectionId: widget.section!.id,
                                        shortDescription:
                                            _lessonShortDescriptionController
                                                .text,
                                        categoryId: widget.category!.id,
                                        name: _lessonNameController.text,
                                        description:
                                            _lessonDescriptionController.text,
                                        duration:
                                            _lessonDurationController.text,
                                      ),
                                    );
                                  } else {
                                    manageCourseLessonCubit
                                        .createNewCourseLesson(
                                      courseLessonModel:
                                          state.courseLessonModel.copyWith(
                                        courseId: widget.course!.id,
                                        sectionId: widget.section!.id,
                                        videoUrl:
                                            _lessonVideoUrlController.text,
                                        categoryId: widget.category!.id,
                                        imageUrl:
                                            _lessonImageUrlController.text,
                                        name: _lessonNameController.text,
                                        description:
                                            _lessonDescriptionController.text,
                                        duration:
                                            _lessonDurationController.text,
                                        shortDescription:
                                            _lessonDescriptionController.text,
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
