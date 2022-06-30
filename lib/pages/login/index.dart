// ignore_for_file: sort_child_properties_last, prefer_const_constructors, sized_box_for_whitespace, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../api/index.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final api = Api();
  final _formKey = GlobalKey<FormState>();
  var username = TextEditingController();
  var password = TextEditingController();
  hanldeLogin() {
    var data = {'phone': username.text, 'password': password.text};

    api.login(data).then((value) => {
          Fluttertoast.showToast(
            msg: '登录成功',
            gravity: ToastGravity.CENTER,
          ),
          Navigator.pushNamed(context, '/')
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '登录',
          style: TextStyle(fontSize: 16),
        ),
        centerTitle: true,
        toolbarHeight: 44,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
              // image: AssetImage('../../images/flutter_01.png'),
              image: NetworkImage(
                'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fpic1.zhimg.com%2F50%2Fv2-1479a3f69e88e37a29bec35cfaaf3400_hd.jpg&refer=http%3A%2F%2Fpic1.zhimg.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1659086485&t=bc6286ba872e71dd95ca3a8a18bcb2fb',
              ),
              fit: BoxFit.cover),
        ),
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: TextFormField(
                    controller: username,
                    decoration: InputDecoration(
                      hintText: '请输入账号',
                      hintStyle: TextStyle(
                          fontSize: 14, color: Color.fromARGB(255, 65, 65, 65)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      contentPadding:
                          EdgeInsets.only(top: 0, bottom: 0, left: 10),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                            width: 2, color: Color.fromARGB(255, 54, 54, 54)),
                      ),
                      // 选中时边框的圆角以及颜色
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(width: 2, color: Colors.blue),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return '请输入账号';
                      }
                      return null;
                    },
                  ),
                  width: MediaQuery.of(context).size.width / 1.5,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: TextFormField(
                    controller: password,
                    decoration: InputDecoration(
                      hintText: '请输入密码',
                      hintStyle: TextStyle(
                          fontSize: 14, color: Color.fromARGB(255, 71, 71, 71)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide:
                            BorderSide(width: 10, color: Colors.red), //此处不生效
                      ),
                      contentPadding:
                          EdgeInsets.only(top: 0, bottom: 0, left: 10),
                      // 未选中时边框的圆角以及颜色
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                            width: 2, color: Color.fromARGB(255, 54, 54, 54)),
                      ),
                      // 选中时边框的圆角以及颜色
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(width: 2, color: Colors.blue),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return '请输入密码';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            hanldeLogin();
                          }
                        },
                        child: Text('登录'))),
              ],
            )),
      ),
    );
  }
}
