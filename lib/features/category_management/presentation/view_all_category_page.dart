import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trackerss/core/services/injection_container.dart';
import 'package:trackerss/core/widgets/empty_state_list.dart';
import 'package:trackerss/core/widgets/error_state_list.dart';
import 'package:trackerss/core/widgets/loading_state_shimmer_list.dart';
 import 'package:trackerss/features/category_management/presentation/add_edit_category_page.dart';
import 'package:trackerss/features/category_management/presentation/cubit/category_cubit.dart';
import 'package:trackerss/features/category_management/presentation/view_category_page.dart';



class ViewAllCategoryPage extends StatefulWidget {
  const ViewAllCategoryPage({super.key});

  @override
  State<ViewAllCategoryPage> createState() => _ViewAllCategoryPageState();
}

class _ViewAllCategoryPageState extends State<ViewAllCategoryPage> {
  @override
  void initState() {
    super.initState();

    context.read<CategoryCubit>().getAllCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Category"),
      ),
      body: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, state) {
          if (state is CategoryLoading) {
            return const LoadingStateShimmerList();
          } else if (state is CategoryLoaded) {
            if (state.categories.isEmpty) {
              return const EmptyStateList(
                imageAssetName: 'assets/images/designer.png',
                title: 'Oops... There are no categories here ',
                description: "Tap '+' button to add a new category",
              );
            }
            return ListView.builder(
              itemCount: state.categories.length,
              itemBuilder: (context, index) {
                final currentCategory = state.categories[index];

                return Card(
                  child: ListTile(
                    title: Text("Occasion ${currentCategory.icon}"),
                    subtitle: Text(currentCategory.name),
                    onTap: () async {
                    final result  = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (context) => serviceLocator<CategoryCubit>(),
                              child:ViewCategoryPage(category: currentCategory),
                            ),
                          ));
                      context
                      .read<CategoryCubit>()
                      .getAllCategories();

                    
              if (result.runtimeType == String) {
                final snackBar = SnackBar(content: Text(result));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }

                    },
                  ),
                );
              },
            );
          } else if (state is CategoryError) {
            return ErrorStateList(
              imageAssetName: 'assets/images/error.png',
              errorMessage: state.message,
              onRetry: () {
                context.read<CategoryCubit>().getAllCategories();
              },
            );
          } else {
            return const EmptyStateList(
              imageAssetName: 'assets/images/Designer.png',
              title: 'Oops... There are no categories here ',
              description: "Tap '+' button to add a new category",
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
         final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) => serviceLocator<CategoryCubit>(),
                  child: const AddEditCategoryPage(),
                ),
              ));


              context
              .read<CategoryCubit>()
              .getAllCategories();


              if (result.runtimeType == String) {
                final snackBar = SnackBar(content: Text(result));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }

        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
