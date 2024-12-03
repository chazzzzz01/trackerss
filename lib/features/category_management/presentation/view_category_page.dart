
import 'package:flutter/material.dart';
import 'package:trackerss/features/category_management/domain/entities/category.dart';
import 'package:trackerss/features/category_management/presentation/add_edit_category_page.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: 
      Text(widget.category.name), 
      actions: [
        IconButton(onPressed: () {
          Navigator.push(context,
           MaterialPageRoute(
            builder:
             (context) => AddEditCategoryPage(
              category: widget.category,),
             ));
        }, 
        icon: const Icon(Icons.edit)),
        IconButton(onPressed: () {}, 
        icon: const Icon(Icons.delete)),

      ],
     ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          LabelValueRow(
            label: 'Icon', 
            value: widget.category.icon,
          ),
            LabelValueRow(
            label: 'Name', 
            value: widget.category.name,
          ),
              LabelValueRow(
            label: 'Color', 
            value: widget.category.color,
          ),
        ],
      ),
    );
  }
}

