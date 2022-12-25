import 'package:auto_route/auto_route.dart';
import 'package:businessmates_admin/core/design/app_icons.dart';
import 'package:businessmates_admin/data/models/course/course_model.dart';
import 'package:businessmates_admin/data/models/course/course_section_model.dart';
import 'package:businessmates_admin/data/models/course_categories_model.dart';
import 'package:businessmates_admin/presentation/cubits/manage_course_section/manage_course_section_cubit.dart';
import 'package:businessmates_admin/presentation/widgets/bm_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/helpers/my_shimmer.dart';
import '../../../routes.gr.dart';

class ManageCourseSectionsScreen extends StatefulWidget {
  static const String routeName = '/manage_course_sections';
  const ManageCourseSectionsScreen({
    super.key,
    this.category,
    this.course,
  });
  final CategoriesModel? category;
  final CourseModel? course;

  @override
  State<ManageCourseSectionsScreen> createState() =>
      _ManageCourseSectionsScreenState();
}

class _ManageCourseSectionsScreenState
    extends State<ManageCourseSectionsScreen> {
  late final ManageCourseSectionCubit manageCourseSectionCubit;
  @override
  void initState() {
    super.initState();
    manageCourseSectionCubit = context.read<ManageCourseSectionCubit>();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _buildList(AsyncSnapshot<List<CourseSectionModel>> snapshot) {
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
                    ManageCourseLessonsScreenRoute(
                      category: widget.category,
                      course: widget.course,
                      section: snapshot.data![index],
                    ),
                  );
                },
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
                subtitle: Text(snapshot.data![index].shortDescription),
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
                              title: const Text('Delete Section'),
                              content: const Text(
                                  'Are you sure you want to delete this Section?'),
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
                            manageCourseSectionCubit.deleteCourseSection(
                              courseSectionModel: snapshot.data![index],
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
                            CreateNewCourseSectionScreenRoute(
                              category: widget.category,
                              course: widget.course,
                              section: snapshot.data![index],
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
        title: Text('Manage Sections of ${widget.course!.name}'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),

          BMButton(
              onPressed: () {
                context.router.push(CreateNewCourseSectionScreenRoute(
                  category: widget.category,
                  course: widget.course,
                ));
              },
              text: "Create New Section"),
          const SizedBox(
            height: 20,
          ),
          // lable
          Text(
            'All Available Section of ${widget.course!.name}',
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const SizedBox(
            height: 20,
          ),
          StreamBuilder(
            stream: manageCourseSectionCubit.streamAllSectionsOfCourse(
                courseModel: widget.course!),
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
