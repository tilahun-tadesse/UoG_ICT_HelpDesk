import 'package:flutter/material.dart';
import 'package:helpdesk/admin/database/admin_database/Services.dart';
class MakeDashboardItems extends StatefulWidget {
  const MakeDashboardItems({Key? key}) : super(key: key);

  @override
  _MakeDashboardItemsState createState() => _MakeDashboardItemsState();
}

class _MakeDashboardItemsState extends State<MakeDashboardItems> {
  int user=0;
  int num=0;
  int expert=0;
  int all_completed=0;
  int all_uncompleted=0;
  int completed=0;
  int uncompleted=0;
  @override
  void initState() {
    super.initState();
    getalluer();
    getallexpert();
  }
  getalluer() {
    Services.get_all_user().then((employees) {
      setState(() {

      });
      print("Length: ${employees.length}");
      user = Services.user!.length;
    });
  }
  getallexpert() {
      Services.get_all_expert().then((employees) {
        setState(() {

        });
        print("Length: ${employees.length}");
        expert = Services.experts!.length;
      });
    }
  Card makeDashboardItem(String title, Icon icon, int index ,int number) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(8),
      child: Ink(
        decoration: index == 0 || index == 3 || index == 4 ||index==7
            ? BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          gradient: const LinearGradient(
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(3.0, -1.0),
            colors: [
              Color(0xFF004B8D),
              Color(0xFFffffff),
            ],
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.white,
              blurRadius: 3,
              offset: Offset(2, 2),
            )
          ],
        )
            : BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          gradient: const LinearGradient(
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(3.0, -1.0),
            colors: [
              Colors.cyan,
              Colors.amber,
            ],
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.white,
              blurRadius: 3,
              offset: Offset(2, 2),
            )
          ],
        ),
        child: InkWell(
          onTap: () {
            if (index == 0) {
              //1.item
            }
            if (index == 1) {
              //2.item
            }
            if (index == 2) {
              //3.item
            }
            if (index == 3) {
              //4.item
            }
            if (index == 4) {
              //5.item
            }
            if (index == 5) {
              //6.item
            }
            if(index ==6)
              {

              }
            if(index==7)
              {

              }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            verticalDirection: VerticalDirection.down,
            children: [
              const SizedBox(height: 50),
              Center(
                child:Container(
                  width: 40,
                  height: 30,
                  color: Colors.white,
                  child: icon,
                )

              ),
              const SizedBox(height: 20),
              Center(
                child: Column(
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                          fontSize: 19,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      number.toString(),
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      ),
                    )
                  ],
                )
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(2),
              children: [
                makeDashboardItem("Number of Expert", Icon(Icons.group_add), 0,expert),
                makeDashboardItem("Today task", Icon(Icons.task), 1,num),
                makeDashboardItem("Number of user", Icon(Icons.person_add), 2,user),
                makeDashboardItem("On work expert", Icon(Icons.person_add), 3,num),
                makeDashboardItem("completed task", Icon(Icons.task_alt), 4,completed),
                makeDashboardItem("uncompleted task", Icon(Icons.task_alt), 5,uncompleted),
                makeDashboardItem(" All completed task", Icon(Icons.task_alt), 6,all_completed),
                makeDashboardItem("Alluncompleted task", Icon(Icons.task_alt), 7,all_uncompleted),


              ],
            ),
          ),
        ],
      ),
    );
  }
}