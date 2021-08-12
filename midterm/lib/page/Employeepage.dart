import 'package:flutter/material.dart';
import 'package:midterm/employees.dart';
import 'package:midterm/page/boxes.dart';
import 'Employeedialog.dart';


Widget buildContent(List<Employee> employees) {
    if (employees.isEmpty) {
      return Center(
        child: Text(
          'No Employee yet!',
          style: TextStyle(fontSize: 24),
        ),
      );
    } else {
      final netExpense = employees.fold<double>(
        0,
        (previousValue, employee) => employee.isWrong
            ? previousValue + (employee.salary*0.9
                       )           : previousValue + (employee.salary*1.2),
      );
      final newExpenseString = '\฿${netExpense.toStringAsFixed(2)}';
      final color = netExpense > 0 ? Colors.green : Colors.red;

      return Column(
        children: [
          SizedBox(height: 24),
          Text(
            'Net Salary: $newExpenseString',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: color,
            ),
          ),
          SizedBox(height: 24),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: employees.length,
              itemBuilder: (BuildContext context, int index) {
                final employee= employees[index];

                return buildEmployee(context, employee);
              },
            ),
          ),
        ],
      );
    }
  }

  Widget buildEmployee(
    BuildContext context,
    Employee employee,
  ) {
    final color = employee.isWrong ? Colors.red : Colors.green;
    var salary = '\฿' + employee.salary.toStringAsFixed(2);
   if (color == Colors.red) {
       salary = '\฿' + (employee.salary*0.9).toStringAsFixed(2); 
   }
   else {
     salary = '\฿' + (employee.salary*1.2).toStringAsFixed(2); 
   }

    return Card(
      color: Colors.white,
      child: ExpansionTile(
        tilePadding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        title: Text(
          employee.name,
          maxLines: 2,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Text(employee.position),
        trailing: Text(
          salary,
          style: TextStyle(
              color: color, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        children: [
          buildButtons(context, employee),
        ],
      ),
    );
  }

  Widget buildButtons(BuildContext context, Employee employee) => Row(
        children: [
          Expanded(
            child: TextButton.icon(
              label: Text('Edit'),
              icon: Icon(Icons.edit),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => EmployeeDialog(
                    employee: employee,
                    onClickedDone: (name, position ,  salary, isWrong) =>
                        editEmployee(employee, name, position, salary, isWrong),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: TextButton.icon(
              label: Text('Delete'),
              icon: Icon(Icons.delete),
              onPressed: () => deleteEmployee(employee),
            ),
          )
        ],
      );

  Future addEmployee(String name, String position, int salary, bool isWrong) async {
    final employee= Employee()
      ..name = name
      ..position = position
      ..salary = salary
      ..isWrong = isWrong;

    final box = Boxes.getEmployees();
    box.add(employee);
    //box.put('mykey', employee);

    // final mybox = Boxes.getemployees();
    // final myemployee= mybox.get('key');
    // mybox.values;
    // mybox.keys;
  }

  void editEmployee(
    Employee employee,
    String position ,
    String name,
    int salary,
    bool isWrong,
  ) {
    employee.name = name;
    employee.position = position ;
    employee.salary = salary;
    employee.isWrong = isWrong;

    // final box = Boxes.getemployees();
    // box.put(employee.key, employee);

    employee.save();
  }

  void deleteEmployee(Employee employee) {
    // final box = Boxes.getemployees();
    // box.delete(employee.key);

    employee.delete();
    //setState(() => employees.remove(employee));
  }