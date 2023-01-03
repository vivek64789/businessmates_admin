import 'package:auto_route/auto_route.dart';
import 'package:businessmates_admin/core/design/app_icons.dart';
import 'package:businessmates_admin/core/helpers/my_shimmer.dart';
import 'package:businessmates_admin/data/models/course_categories_model.dart';
import 'package:businessmates_admin/presentation/cubits/manage_categories/manage_categories_cubit.dart';
import 'package:businessmates_admin/presentation/widgets/bm_button.dart';
import 'package:businessmates_admin/routes.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_new_category_screen.dart';

class ManageCategoriesScreen extends StatefulWidget {
  static const String routeName = '/manage_categories';
  const ManageCategoriesScreen({super.key});

  @override
  State<ManageCategoriesScreen> createState() => _ManageCategoriesScreenState();
}

class _ManageCategoriesScreenState extends State<ManageCategoriesScreen> {
  late final ManageCategoriesCubit manageCategoriesCubit;
  @override
  void initState() {
    super.initState();
    manageCategoriesCubit = context.read<ManageCategoriesCubit>();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _buildList(AsyncSnapshot<List<CategoriesModel>> snapshot) {
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
                onTap: () => context.router.push(
                  ManageCoursesScreenRoute(
                    category: snapshot.data![index],
                  ),
                ),
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
                  // width: MediaQuery.of(context).size.width * 0.25,
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
                              title: const Text('Delete Category'),
                              content: const Text(
                                  'Are you sure you want to delete this category?'),
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
                            manageCategoriesCubit.deleteCourseCategory(
                                id: snapshot.data![index].id);
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
                            CreateNewCategoryScreenRoute(
                              category: snapshot.data![index],
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
        title: const Text('Manage Categories'),
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
                context.router.pushNamed(CreateNewCategoryScreen.routeName);
              },
              text: "Create New Category"),
          const SizedBox(
            height: 20,
          ),
          // lable
          Text(
            'All Available Categories',
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const SizedBox(
            height: 20,
          ),
          StreamBuilder(
            stream: manageCategoriesCubit.streamAllCourseCategories(),
            builder: ((context, snapshot) => snapshot.hasData
                ? _buildList(snapshot)
                : Center(
                    child: MyShimmer(
                      height: 10,
                    ),
                  )),
          ),
          // BlocConsumer<ManageCategoriesCubit, ManageCategoriesState>(
          //   builder: (context, state) {
          //     return SizedBox(
          //       height: MediaQuery.of(context).size.height * 0.6,
          //       child: ListView.builder(
          //           physics: const BouncingScrollPhysics(),
          //           itemCount: state.categories.length,
          //           itemBuilder: (context, index) {
          //             return Card(
          //               child: state.categories.isNotEmpty
          //                   ? Dismissible(
          //                       onDismissed: (direction) {
          //                         if (direction ==
          //                             DismissDirection.endToStart) {
          //                           manageCategoriesCubit.deleteCourseCategory(
          //                               id: state.categories[index].id);
          //                         }
          //                       },
          //                       background: Container(
          //                         color: Colors.red,
          //                         child: const Icon(
          //                           Icons.delete,
          //                           color: Colors.white,
          //                         ),
          //                       ),
          //                       key: Key(state.categories[index].id.toString()),
          //                       child: ListTile(
          //                         onTap: () {},
          //                         title: Text(state.categories[index].name),
          //                         subtitle:
          //                             Text(state.categories[index].description),
          //                         leading: CircleAvatar(
          //                           backgroundImage: NetworkImage(
          //                             state.categories[index].imageUrl
          //                                 .toString(),
          //                           ),
          //                         ),
          //                       ),
          //                     )
          //                   : const Center(
          //                       child: Text('No Categories Found'),
          //                     ),
          //             );
          //           }),
          //     );
          //   },
          //   listener: (context, state) {
          //     if (state.manageCategoriesLoadingStatus == LoadingStatus.error) {
          //       state.failureMessageOption.fold(
          //         () => null,
          //         (message) => myToast(
          //           context: context,
          //           widget: Text(
          //             message.when(
          //               serverError: (m) => m.toString(),
          //               noInternetConnection: (m) => m.toString(),
          //               tooManyRequests: (m) => m.toString(),
          //               deviceNotSupported: (m) => m.toString(),
          //               categoryAlreadyExists: (m) => m.toString(),
          //               noCategoriesFound: (m) => m.toString(),
          //             ),
          //           ),
          //         ),
          //       );
          //     }
          //   },
          // ),

          // TODO: Ui to list all categories
        ],
      ),
    );
  }
}
