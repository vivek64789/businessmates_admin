import 'package:auto_route/auto_route.dart';
import 'package:businessmates_admin/core/design/app_icons.dart';
import 'package:businessmates_admin/data/models/course/course_model.dart';
import 'package:businessmates_admin/data/models/course_categories_model.dart';
import 'package:businessmates_admin/presentation/cubits/manage_course/manage_course_cubit.dart';
import 'package:businessmates_admin/presentation/widgets/bm_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/helpers/my_shimmer.dart';
import '../../../routes.gr.dart';

class ManageCoursesScreen extends StatefulWidget {
  static const String routeName = '/manage_courses';
  const ManageCoursesScreen({
    super.key,
    this.category,
  });
  final CategoriesModel? category;

  @override
  State<ManageCoursesScreen> createState() => _ManageCoursesScreenState();
}

class _ManageCoursesScreenState extends State<ManageCoursesScreen> {
  late final ManageCourseCubit manageCourseCubit;
  @override
  void initState() {
    super.initState();
    manageCourseCubit = context.read<ManageCourseCubit>();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _buildList(AsyncSnapshot<List<CourseModel>> snapshot) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.05),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                onTap: () {
                  context.router.push(
                    ManageCourseSectionsScreenRoute(
                      course: snapshot.data![index],
                      category: widget.category,
                    ),
                  );
                },
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                    snapshot.data![index].imageUrl,
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                title: Text(
                  snapshot.data![index].name,
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(color: Theme.of(context).colorScheme.primary),
                ),
                subtitle: Text(snapshot.data![index].description),
                trailing: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.23,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(
                          BMIcon.trash,
                          color: Theme.of(context).colorScheme.error,
                        ),
                        onPressed: () async {
                          final confirm = await showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Delete Course'),
                              content: const Text(
                                  'Are you sure you want to delete this Course?'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(true);
                                    },
                                    child: const Text('Yes')),
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(false);
                                    },
                                    child: const Text('No')),
                              ],
                            ),
                          );
                          if (confirm == true) {
                            manageCourseCubit.deleteCourse(
                              courseModel: snapshot.data![index],
                            );
                          } else {
                            return;
                          }
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          BMIcon.pen,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        onPressed: () {
                          context.router.push(
                            CreateNewCourseScreenRoute(
                              category: widget.category,
                              course: snapshot.data![index],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Courses of ${widget.category!.name}}'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          // TODO: Ui to create a new category
          // create a new category
          BMButton(
              onPressed: () {
                context.router.push(CreateNewCourseScreenRoute(
                  category: widget.category,
                ));
              },
              text: "Create New Course"),
          const SizedBox(
            height: 20,
          ),
          // lable
          Text(
            'All Available Courses of ${widget.category!.name}',
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const SizedBox(
            height: 20,
          ),
          StreamBuilder(
            stream: manageCourseCubit.streamAllCoursesOfCategory(
                categoryId: widget.category!.id),
            builder: ((context, snapshot) {
              return snapshot.hasData
                  ? _buildList(snapshot)
                  : Center(
                      child: MyShimmer(
                        height: 10,
                      ),
                    );
            }),
          ),
        ],
      ),
    );
  }
}
