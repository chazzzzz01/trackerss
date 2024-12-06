
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trackerss/core/services/injection_container.dart';
import 'package:trackerss/features/category_management/domain/entities/category.dart';
import 'package:trackerss/features/category_management/presentation/add_edit_category_page.dart';
import 'package:trackerss/features/category_management/presentation/cubit/category_cubit.dart';
import 'package:trackerss/features/category_management/presentation/view_category_row.dart';



void main() {
  runApp( const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      body:ViewCategoryPage(category: Category(
        id: "123", 
        name: 'Toy Car',
        icon: 'Birthday Gift',
        color: 'Black'))
      ),
    ));
}

class ViewCategoryPage extends StatefulWidget {
  final Category category;
  

  const ViewCategoryPage({
    super.key, 
    required this.category,
    });

  @override
  State<ViewCategoryPage> createState() => _ViewCategoryPageState();
}

class _ViewCategoryPageState extends State<ViewCategoryPage> {
  late Category _currentCategory;

  @override
  void initState() {
    super.initState();
    _currentCategory = widget.category;
  }




  @override
  Widget build(BuildContext context) {
    return  BlocListener<CategoryCubit, CategoryState>(
  listener: (context, state) {
    if (state is CategoryDeleted) {
       ScaffoldMessenger.of(context).hideCurrentSnackBar();
       Navigator.pop(context, "Category Deleted");
    }
    else if (state is CategoryError) {
       final snackBar = SnackBar(
        content: Text(state.message),
        duration: const Duration(seconds: 5),
        );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  },
    child: Scaffold(
      appBar: AppBar(title: 
      Text(_currentCategory.name), 
      actions: [
        IconButton(onPressed: () async  {
         final result = await  Navigator.push(context,
           MaterialPageRoute(
            builder:
             (context) => BlocProvider(
              create: (context) => serviceLocator<CategoryCubit>(),
              child: AddEditCategoryPage(
              category: _currentCategory,
             ),
              ),
             ));


          if (result.runtimeType == Category) {
            
            setState(() {
              _currentCategory = result;
              
            });
          }
        }, 
        icon: const Icon(Icons.edit)),
        IconButton(
          onPressed: () {
                        const snackBar = SnackBar(
                          content: Text("Deleting Event..."),
                          duration: Duration(seconds: 9),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        context.read<CategoryCubit>().deleteCategory(widget.category);
                      },
        icon: const Icon(Icons.delete)),

      ],
     ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          LabelValueRow(
            label: 'Icon', 
            value: _currentCategory.icon,
          ),
            LabelValueRow(
            label: 'Name', 
            value: _currentCategory.name,
          ),
              LabelValueRow(
            label: 'Color', 
            value: _currentCategory.color,
          ),
        ],
      ),
    ));
  }
}

