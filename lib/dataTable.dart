import 'package:flutter/material.dart';
import 'package:helpdesk/admin/Employee.dart';
import 'package:helpdesk/admin/Services.dart';

class DataTableDemo extends StatefulWidget {
  DataTableDemo() : super();

  final String title = "Flutter Data Table";

  @override
  DataTableDemoState createState() => DataTableDemoState();
}

class DataTableDemoState extends State<DataTableDemo> {
  List<Employee> ?_employees;
  GlobalKey<ScaffoldState> ?_scaffoldKey;
  TextEditingController _firstNameController=TextEditingController();
  TextEditingController _lastNameController=TextEditingController();
  Employee ?_selectedEmployee;
  bool _isUpdating=false;
  String ?_titleProgress;

  @override
  void initState() {
    super.initState();
    _employees = [];
    _isUpdating = false;
    _titleProgress = widget.title;
    _scaffoldKey = GlobalKey();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _getEmployees();
  }

  _showProgress(String message) {
    setState(() {
      _titleProgress = message;
    });
  }

  _createTable() {
    _showProgress('Creating Table...');
    Services.createTable().then((result) {
      if ('success' == result) {
        showSnackBar(context, result);
        _getEmployees();
      }
    });
  }

  _addEmployee() {

    _showProgress('Adding Employee...');
    Services.addEmployee(_firstNameController.text, _lastNameController.text)
        .then((result) {
      if ('success' == result) {
        _getEmployees();
      }
      _clearValues();
    });
  }

  _getEmployees() {
    _showProgress('Loading Employees...');
    Services.getEmployees().then((employees) {
      setState(() {
        _employees = employees;
      });
      _showProgress(widget.title);
      print("Length: ${employees.length}");
    });
  }

  _deleteEmployee(Employee employee) {
    _showProgress('Deleting Employee...');
    Services.deleteEmployee(employee.id.toString()).then((result) {
      if ('success' == result) {
        setState(() {
          _employees!.remove(employee);
        });
        _getEmployees();
      }
    });
  }

  _updateEmployee(Employee employee) {
    _showProgress('Updating Employee...');
    Services.updateEmployee(
        employee.id.toString(), _firstNameController.text, _lastNameController.text)
        .then((result) {
      if ('success' == result) {
        _getEmployees();
        setState(() {
          _isUpdating = false;
        });
        _firstNameController.text = '';
        _lastNameController.text = '';
      }
    });
  }

  _setValues(Employee employee) {
    _firstNameController.text = employee.firstName.toString();
    _lastNameController.text = employee.lastName.toString();
    setState(() {
      _isUpdating = true;
    });
  }

  _clearValues() {
    _firstNameController.text = '';
    _lastNameController.text = '';
  }

  SingleChildScrollView _dataBody() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(
                label: Text("ID"),
                numeric: false,
                tooltip: "This is the employee id"),
            DataColumn(
                label: Text(
                  "FIRST",
                ),
                numeric: false,
                tooltip: "This is the last name"),
            DataColumn(
                label: Text("LAST"),
                numeric: false,
                tooltip: "This is the last name"),
            DataColumn(
                label: Text("DELETE"),
                numeric: false,
                tooltip: "Delete Action"),
          ],
          rows: _employees!.map(
                (employee) => DataRow(
              cells: [
                DataCell(
                  Text(employee.id.toString()),
                  onTap: () {
                    print("Tapped " + employee.firstName.toString());
                    _setValues(employee);
                    _selectedEmployee = employee;
                  },
                ),
                DataCell(
                  Text(
                    employee.firstName!.toUpperCase(),
                  ),
                  onTap: () {
                    print("Tapped " + employee.firstName.toString());
                    _setValues(employee);
                    _selectedEmployee = employee;
                  },
                ),
                DataCell(
                  Text(
                    employee.lastName!.toUpperCase(),
                  ),
                  onTap: () {
                    print("Tapped " + employee.firstName.toString());
                    _setValues(employee);
                    _selectedEmployee = employee;
                  },
                ),
                DataCell(
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _deleteEmployee(employee);
                    },
                  ),
                  onTap: () {
                    print("Tapped " + employee.firstName.toString());
                  },
                ),
              ],
            ),
          )
              .toList(),
        ),
      ),
    );
  }

  showSnackBar(context, message) {
    _scaffoldKey!.currentState!.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(_titleProgress.toString()),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _createTable();
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _getEmployees();
            },
          ),
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: _firstNameController,
                decoration: InputDecoration.collapsed(
                  hintText: "First Name",
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: _lastNameController,
                decoration: InputDecoration.collapsed(
                  hintText: "Last Name",
                ),
              ),
            ),
            _isUpdating
                ? Row(
              children: <Widget>[
                OutlinedButton(onPressed: ()
                {
                  _updateEmployee(_selectedEmployee!);
                },
                  child: Text('UPDATE'),
                ),

                OutlinedButton(
                  child: Text('CANCEL'),
                  onPressed: () {
                    setState(() {
                      _isUpdating = false;
                    });
                    _clearValues();
                  },
                ),
              ],
            )
                : Container(),
            Expanded(
              child: _dataBody(),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addEmployee();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
