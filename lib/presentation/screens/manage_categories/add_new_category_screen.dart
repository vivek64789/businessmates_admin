import 'package:businessmates_admin/core/helpers/my_toast.dart';
import 'package:businessmates_admin/core/utils/validation_helper.dart';
import 'package:businessmates_admin/data/models/course_categories_model.dart';
import 'package:businessmates_admin/presentation/cubits/image_cubit/image_cubit.dart';
import 'package:businessmates_admin/presentation/cubits/manage_categories/manage_categories_cubit.dart';
import 'package:businessmates_admin/presentation/widgets/bm_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/bm_button.dart';

class CreateNewCategoryScreen extends StatelessWidget {
  static const String routeName = '/create_new_category';
  CreateNewCategoryScreen({super.key, this.category});
  final CategoriesModel? category;

  // form key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
// text controllers

  final TextEditingController _categoryNameController = TextEditingController();
  final TextEditingController _categoryDescriptionController =
      TextEditingController();
  final TextEditingController _categoryImageController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    ManageCategoriesCubit manageCategoriesCubit =
        context.read<ManageCategoriesCubit>();

    ImageCubit imageCubit = context.read<ImageCubit>();
    _categoryDescriptionController.text = category?.description ?? '';
    _categoryNameController.text = category?.name ?? '';
    _categoryImageController.text = category?.imageUrl ?? '';
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: const [
            Text('Create New Category'),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
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
                      offset: const Offset(0, 3), // changes position of shadow
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
                        hintText: 'Enter Category Name',
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
                        controller: _categoryDescriptionController,
                        maxLines: 10,
                        hintText: 'Enter Description',
                        validator: (value) {
                          return isEmpty(value);
                        },
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
                              color: Theme.of(context).colorScheme.onPrimary,
                            )),
                        onPressed: () async {
                          final url =
                              await imageCubit.showImageUploadSheet(context);
                          _categoryImageController.text = url;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    BlocConsumer<ManageCategoriesCubit, ManageCategoriesState>(
                      listener: (context, state) {
                        if (state.manageCategoriesLoadingStatus ==
                            LoadingStatus.loaded) {
                          Navigator.of(context).pop();
                          myToast(
                            context: context,
                            widget: Text(category != null
                                ? "Category Updated Successfully"
                                : 'Category Created Successfully'),
                          );
                        } else if (state.manageCategoriesLoadingStatus ==
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
                                  categoryAlreadyExists: (message) =>
                                      message.toString(),
                                  noCategoriesFound: (message) =>
                                      message.toString(),
                                ),
                              ),
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        return BMButton(
                          isLoading: state.manageCategoriesLoadingStatus ==
                              LoadingStatus.loading,
                          text: category != null
                              ? 'Update Category'
                              : 'Create Category',
                          color: Theme.of(context).colorScheme.onPrimary,
                          foregroundColor:
                              Theme.of(context).colorScheme.primary,
                          onPressed: () {
                            // validate form
                            if (_formKey.currentState!.validate() &&
                                _categoryImageController.text.isNotEmpty) {
                              // if the form is valid
                              if (category != null) {
                                manageCategoriesCubit.updateCourseCategory(
                                  categoriesModel: category!.copyWith(
                                    description:
                                        _categoryDescriptionController.text,
                                    imageUrl: _categoryImageController.text,
                                    name: _categoryNameController.text,
                                  ),
                                );
                              } else {
                                manageCategoriesCubit.createCourseCategory(
                                  name: _categoryNameController.text,
                                  description:
                                      _categoryDescriptionController.text,
                                  imageUrl: _categoryImageController.text,
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
          ),
        ),
      ),
    );
  }
}
