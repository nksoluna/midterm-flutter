import 'package:flutter/material.dart';

import 'package:midterm/employees.dart' ;

class EmployeeDialog extends StatefulWidget {
  final Employee employee;
  final Function(String name, String pos, int salary , bool isWrong ) onClickedDone;

  const EmployeeDialog({
    Key key,
    this.employee,
    this.onClickedDone,
  }) : super(key: key);

  @override
  _EmployeeDialogState createState() => _EmployeeDialogState();
}

class _EmployeeDialogState extends State<EmployeeDialog> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final positionController = TextEditingController();
  final salaryController = TextEditingController();

  bool isWrong = true;

  @override
  void initState() {
    super.initState();

    if (widget.employee != null) {
      final employee = widget.employee;

      nameController.text = employee.name;
      positionController.text = employee.position;
      salaryController.text = employee.salary.toString();
      isWrong = employee.isWrong;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    positionController.dispose() ;
    salaryController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.employee != null;
    final title = isEditing ? 'Edit employee' : 'Add employee';

    return AlertDialog(
      title: Text(title),
      content: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 8),
              buildName(),
              SizedBox(height: 8),
              buildSalary(),
              SizedBox(height: 8),
              buildPosition() ,
               SizedBox(height: 8),
              buildRadioButtons(),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        buildCancelButton(context),
        buildAddButton(context, isEditing: isEditing),
      ],
    );
  }

  Widget buildName() => TextFormField(
        controller: nameController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter Name',
        ),
        validator: (name) =>
            name != null && name.isEmpty ? 'Enter a name' : null,
      );

       Widget buildPosition() => TextFormField(
        controller: positionController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter Position',
        ),
        validator: (position) =>
            position != null && position.isEmpty ? 'Enter a position' : null,
      );

  Widget buildSalary() => TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter Salary',
        ),
        keyboardType: TextInputType.number,
        validator: (salary) => salary != null && int.tryParse(salary) == null
            ? 'Enter a valid number'
            : null,
        controller: salaryController,
      );

  Widget buildRadioButtons() => Column(
        children: [
          RadioListTile<bool>(
            title: Text('Mistake'),
            value: true,
            groupValue: isWrong,
            onChanged: (value) => setState(() => isWrong = value),
          ),
          RadioListTile<bool>(
            title: Text('Perfect'),
            value: false,
            groupValue: isWrong,
            onChanged: (value) => setState(() => isWrong = value),
          ),
        ],
      );

  Widget buildCancelButton(BuildContext context) => TextButton(
        child: Text('Cancel'),
        onPressed: () => Navigator.of(context).pop(),
      );

  Widget buildAddButton(BuildContext context, {bool isEditing}) {
    final text = isEditing ? 'Save' : 'Add';

    return TextButton(
      child: Text(text),
      onPressed: () async {
        final isValid = formKey.currentState.validate();

        if (isValid) {
          final name = nameController.text;
          final salary = int.tryParse(salaryController.text) ?? 0;
          final pos = positionController.text ;

          widget.onClickedDone(name, pos , salary, isWrong);

          Navigator.of(context).pop();
        }
      },
    );
  }
}
