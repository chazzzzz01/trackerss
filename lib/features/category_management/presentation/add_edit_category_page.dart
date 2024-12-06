import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:trackerss/features/category_management/domain/entities/category.dart';
import 'package:trackerss/features/category_management/presentation/cubit/category_cubit.dart';



void main() {
  runApp( const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      body:AddEditCategoryPage(
        category: Category(
        id: "123", 
        name: 'Toy Car',
        icon: 'Birthday Gift',
        color: 'Black')),
      ),
    ));
}
 
class AddEditCategoryPage extends StatefulWidget {
  final Category? category;

  const AddEditCategoryPage({super.key, this.category});

  @override
  State<AddEditCategoryPage> createState() => _AddEditCategoryPageState();
}

class _AddEditCategoryPageState extends State<AddEditCategoryPage> {
  final _formkey = GlobalKey<FormBuilderState>();
  bool _isPerforming = false;



  @override
  Widget build(BuildContext context) {
    String appBarTitle = 
    widget.category == null ? 'Add new category' : 'Edit category';
    String buttonLabel = 
    widget.category == null ? 'Add category' : 'Edit category';

    List<String> iconOptions = [
      'Birthday Gift', 'Wedding Gift', 'Anniversarry Gift', 'Christmas Gift'];

    final initialValues = {
      'name': widget.category?.name.toString(),
      'icon': widget.category?.icon,
      'color': widget.category?.color,
      
      };



    return BlocListener<CategoryCubit, CategoryState>(
  listener: (context, state) {
    if (state is CategoryAdded) {
      Navigator.pop(context, "Category Added");
    }
     else if (state is CategoryError) {
      final snackBar = SnackBar(
        content: Text(state.message),
        duration: const Duration(seconds: 5),
        );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      setState(() {
        _isPerforming = false;
      });
    }
    else if (state is CategoryUpdated) {
       Navigator.pop(context, state.newCategory);
    }
     else if (state is CategoryDeleted) {
          Navigator.pop(context, "Category Deleted Successfully.");
        }

  },
  child: Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        ),
    body: Column(
      children: [
       Expanded(
        child: FormBuilder(
          key: _formkey,
          initialValue: initialValues,
          child: ListView(
            padding: const EdgeInsets.all(8.0),
            children: [
              FormBuilderTextField(
                name: 'name', 
                decoration: const InputDecoration(

                   border: OutlineInputBorder(),

                   labelText: 'Name'

                ),
               
               keyboardType: TextInputType.text,
               validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),  
                  (value) {
      // Custom validation logic for general text
      if (value != null && value.isNotEmpty && value.contains(RegExp(r'[^\w\s]'))) {
        return 'Text should not contain special characters.';
      }
      return null;
    }
                //  FormBuilderValidators.maxLength(100), 

                ]),
              ),
              const SizedBox(
                height: 16,
              ),
              FormBuilderDropdown(name: 'icon',
               items: iconOptions.map(
                (icon) =>DropdownMenuItem(
                  value: icon, child: Text(icon))
                ).toList(),


                 decoration: const InputDecoration(
                   border: OutlineInputBorder(),
                   labelText: 'Icon',
                   hintText: 'Select icon'
                ),
                validator: FormBuilderValidators.compose([
                   FormBuilderValidators.required(),
                ]),

              ),

              const SizedBox(
                height: 16,
              ),
               FormBuilderTextField(
                name: 'color', 
                decoration: const InputDecoration(

                   border: OutlineInputBorder(),

                   labelText: 'Color'

                ),
               
               keyboardType: TextInputType.text,
               validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),  
                FormBuilderValidators.alphabetical(),  
                FormBuilderValidators.alphabetical(),  

                ]),
              ),
              const SizedBox(
                height: 16,
              ),

            ],
            ),
          )),

         Padding(
           padding: const EdgeInsets.all(8.0),
           child: Row(
            children: [
           Expanded(
            child: OutlinedButton(
              onPressed: () {
                Navigator.pop(context);

              }, 
              child: const Text("Cancel"),
              ),),
           const SizedBox(width: 16.0),
           Expanded(
            child: ElevatedButton(
              onPressed: _isPerforming? null : () {
                bool isValid = _formkey.currentState!.validate();
                final inputs = _formkey.currentState!.instantValue;

                if (isValid) {
                  setState(() {
                    _isPerforming = true;

                  });




                  final newCategory =
                   Category(
                    id: widget.category?.id?? "",
                    name: inputs["name"],
                    icon: inputs["icon"], 
                    color: inputs["color"]
                    );

                if (widget.category == null) {
                  context.read<CategoryCubit>().createCategory(newCategory);
                }
                else {
                   context
                   .read<CategoryCubit>()
                   .updateCategory(newCategory);
                }


                }
              }, 
              child:
               _isPerforming ? 
               const SizedBox(
                width: 16, 
                height: 16, 
                child: CircularProgressIndicator(), 
                ) 
                : Text(buttonLabel),
               ),),
           ],),
        ),
      ],), )
    );
  }
}