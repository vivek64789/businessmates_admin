import 'package:businessmates_admin/data/models/course/course_model.dart';
import 'package:businessmates_admin/data/models/course_categories_model.dart';
import 'package:businessmates_admin/presentation/cubits/manage_course/manage_course_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/helpers/my_toast.dart';
import '../../../core/utils/validation_helper.dart';
import '../../cubits/image_cubit/image_cubit.dart';
import '../../cubits/manage_categories/manage_categories_cubit.dart';
import '../../widgets/bm_button.dart';
import '../../widgets/bm_text_form_field.dart';

class CreateNewCourseScreen extends StatefulWidget {
  const CreateNewCourseScreen({super.key, this.category, this.course});
  static const String routeName = '/create_new_course';

  final CategoriesModel? category;
  final CourseModel? course;

  @override
  State<CreateNewCourseScreen> createState() => _CreateNewCourseScreenState();
}

class _CreateNewCourseScreenState extends State<CreateNewCourseScreen> {
  // form key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

// text controllers
  final TextEditingController _categoryNameController = TextEditingController();

  final TextEditingController _courseNameController = TextEditingController();

  final TextEditingController _courseDescriptionController =
      TextEditingController();

  final TextEditingController _coursePriceController = TextEditingController();

  final TextEditingController _courseImageController = TextEditingController();
  late final ManageCourseCubit manageCourseCubit;
  late final ImageCubit imageCubit;

  @override
  void initState() {
    manageCourseCubit = context.read<ManageCourseCubit>();

    imageCubit = context.read<ImageCubit>();
    _categoryNameController.text = widget.category?.name ?? '';
    // _courseDescriptionController.text = course?.description ?? '';
    // _courseImageController.text = course?.imageUrl ?? '';
    if (widget.course != null) {
      print("I am getting called");
      manageCourseCubit.setCourseModel(widget.course!);
      _courseNameController.text = widget.course!.name;
      _courseDescriptionController.text = widget.course!.description;
      _coursePriceController.text = widget.course!.price.toString();
      _courseImageController.text = widget.course!.imageUrl;
    } else {
      manageCourseCubit.setCourseModel(CourseModel.empty());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: const [
            Text('Create New Course'),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: BlocConsumer<ManageCourseCubit, ManageCourseState>(
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
                            controller: _categoryNameController,
                            hintText: 'Category Name',
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
                            controller: _courseNameController,
                            hintText: 'Enter Course Name',
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
                            controller: _courseDescriptionController,
                            maxLines: 10,
                            hintText: 'Enter Description',
                            validator: (value) {
                              return isEmpty(value);
                            },
                            // onSaved: (value) {
                            //   manageCourseCubit.setCourseModel(
                            //     state.courseModel.copyWith(
                            //       description: value,
                            //     ),
                            //   );
                            // },
                            errorColor: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: BMTextFormField(
                            controller: _coursePriceController,
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
                            hintText: 'Enter Course Price',
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
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: TextButton.icon(
                            icon: Icon(Icons.image,
                                color: Theme.of(context).colorScheme.onPrimary),
                            label: Text('Upload Image',
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                )),
                            onPressed: () async {
                              final url = await imageCubit
                                  .showImageUploadSheet(context);
                              _courseImageController.text = url;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ListTile(
                          title: Text(
                            'Is Course New',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                          ),
                          trailing: Switch.adaptive(
                            value: manageCourseCubit.state.courseModel.isNew,
                            onChanged: (value) {
                              manageCourseCubit.setCourseModel(
                                manageCourseCubit.state.courseModel.copyWith(
                                  isNew: value,
                                ),
                              );
                            },
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Is Course Best Seller',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                          ),
                          trailing: Switch.adaptive(
                            value: manageCourseCubit
                                .state.courseModel.isBestSeller,
                            onChanged: (value) {
                              manageCourseCubit.setCourseModel(
                                manageCourseCubit.state.courseModel.copyWith(
                                  isBestSeller: value,
                                ),
                              );
                            },
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Is Course Featured',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                          ),
                          trailing: Switch.adaptive(
                            value:
                                manageCourseCubit.state.courseModel.isFeatured,
                            onChanged: (value) {
                              manageCourseCubit.setCourseModel(
                                manageCourseCubit.state.courseModel.copyWith(
                                  isFeatured: value,
                                ),
                              );
                            },
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Is Course Trending',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                          ),
                          trailing: Switch.adaptive(
                            value:
                                manageCourseCubit.state.courseModel.isTrending,
                            onChanged: (value) {
                              manageCourseCubit.setCourseModel(
                                manageCourseCubit.state.courseModel.copyWith(
                                  isTrending: value,
                                ),
                              );
                            },
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Is Course Free',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                          ),
                          trailing: Switch.adaptive(
                            value: manageCourseCubit.state.courseModel.isFree,
                            onChanged: (value) {
                              manageCourseCubit.setCourseModel(
                                manageCourseCubit.state.courseModel.copyWith(
                                  isFree: value,
                                ),
                              );
                            },
                          ),
                        ),

                        const SizedBox(
                          height: 10,
                        ),
                        BlocConsumer<ManageCourseCubit, ManageCourseState>(
                          listenWhen: (previous, current) {
                            return previous != current;
                          },
                          listener: (context, state) {
                            if (state.manageCoursesLoadingStatus ==
                                LoadingStatus.loaded) {
                              Navigator.of(context).pop();
                              myToast(
                                context: context,
                                widget: Text(widget.course != null
                                    ? "Course Updated Successfully"
                                    : 'Course Created Successfully'),
                              );
                            } else if (state.manageCoursesLoadingStatus ==
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
                              isLoading: state.manageCoursesLoadingStatus ==
                                  LoadingStatus.loading,
                              text: widget.course != null
                                  ? 'Update Course'
                                  : 'Create Course',
                              color: Theme.of(context).colorScheme.onPrimary,
                              foregroundColor:
                                  Theme.of(context).colorScheme.primary,
                              onPressed: () {
                                if (_courseImageController.text.isEmpty) {
                                  myToast(
                                    context: context,
                                    widget:
                                        const Text('Please add course image'),
                                  );
                                  return;
                                }
                                // validate form
                                if (_formKey.currentState!.validate() &&
                                    _courseImageController.text.isNotEmpty) {
                                  // if the form is valid
                                  if (widget.course != null) {
                                    manageCourseCubit.updateCourse(
                                      courseModel: state.courseModel.copyWith(
                                        imageUrl: _courseImageController.text,
                                        categoryId: widget.category!.id,
                                        name: _courseNameController.text,
                                        description:
                                            _courseDescriptionController.text,
                                        price: double.parse(
                                            _coursePriceController.text),
                                      ),
                                    );
                                  } else {
                                    manageCourseCubit.createNewCourse(
                                      courseModel: state.courseModel.copyWith(
                                        categoryId: widget.category!.id,
                                        imageUrl: _courseImageController.text,
                                        name: _courseNameController.text,
                                        description:
                                            _courseDescriptionController.text,
                                        price: double.parse(
                                            _coursePriceController.text),
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
