import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(AppDrawer());
}

class AppDrawer extends StatefulWidget {
  AppDrawer({Key? key}) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  var flag = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 230, 229, 229),
      child: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.luggage),
            title: Text('username'),
            trailing: Icon(Icons.qr_code),
          ),
          Card(
            margin: EdgeInsets.all(15),
            child: Container(
              padding: EdgeInsets.only(right: 10, left: 10),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.luggage),
                    title: Text('username'),
                    trailing: Icon(Icons.qr_code),
                  ),
                  Container(height: 1, color: Colors.grey),
                  Container(
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.grey))),
                    child: ListTile(
                      leading: Icon(Icons.luggage),
                      title: Text('username'),
                      trailing: Icon(Icons.qr_code),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.luggage),
                    title: Text('username'),
                    trailing: Icon(Icons.qr_code),
                  ),
                ],
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.all(15),
            child: Container(
              padding: EdgeInsets.only(right: 10, left: 10),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.luggage),
                    title: Text('username'),
                    trailing: Icon(Icons.qr_code),
                  ),
                  Container(height: 1, color: Colors.grey),
                  Container(
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.grey))),
                    child: ListTile(
                      leading: Icon(Icons.luggage),
                      title: Text('username'),
                      trailing: Icon(Icons.qr_code),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.luggage),
                    title: Text('username'),
                    trailing: Switch(
                      value: flag,
                      onChanged: (bool) => {
                        setState(() => {flag = bool})
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
