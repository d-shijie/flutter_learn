import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../state/index.dart';

class CloudCountryPage extends StatefulWidget {
  CloudCountryPage({Key? key}) : super(key: key);

  @override
  State<CloudCountryPage> createState() => _CloudCountryPage();
}

class _CloudCountryPage extends State<CloudCountryPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
            child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // 读取数据
        Text(context.watch<Modal>().count.toString()),
        SizedBox(
          width: 10,
        ),
        ElevatedButton(
          // 调用方法 同时视图也会改变 其他页面所使用到的此状态也会改变
          onPressed: () => {context.read<Modal>().add()},
          child: Text('add'),
        ),
        SizedBox(
          width: 10,
        ),
        ElevatedButton(
          // 调用方法 同时视图也会改变 其他页面所使用到的此状态也会改变
          onPressed: () => {Navigator.pushNamed(context, '/login')},
          child: Text('go to login'),
        ),
      ],
    )));
  }
}
