// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutterapp/pages/drawer/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../drawer/index.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PlayCilentPage extends StatefulWidget {
  PlayCilentPage({Key? key}) : super(key: key);

  @override
  State<PlayCilentPage> createState() => _PlayCilentPage();
}

class _PlayCilentPage extends State<PlayCilentPage>
    with TickerProviderStateMixin {
  // 命名key
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  late TabController _tabController;
  final Future<SharedPreferences> pref = SharedPreferences.getInstance();
  @override
  void initState() {
    setState(() {
      _tabController = TabController(length: 3, vsync: this);
      _tabController.animateTo(1);
    });
    var test = pref.then((value) => value.getString('test'));
    test.then((value) => {print(value)});
    pref.then((value) => value.remove('test'));
    super.initState();
    // 进入页面自动进入index为1的页面
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      // tabbar的长度
      length: 3,
      // 此处用了scaffold也可不用直接写tabbar
      child: Scaffold(
        backgroundColor: Color.fromARGB(59, 183, 181, 181),
        appBar: AppBar(
          automaticallyImplyLeading: false, // 清除返回按钮
          centerTitle: true,
          titleSpacing: 0, //清除title左右padding，默认情况下会有一定的padding距离
          toolbarHeight: 44, //将高度定到44
          backgroundColor: Color.fromARGB(255, 235, 85, 74),
          // tabbar加了controller tabbarview必须加 不然都不加 否则会失效
          title: TabBar(
            controller: _tabController,
            isScrollable: true,
            indicatorColor: Colors.yellow,
            indicatorSize: TabBarIndicatorSize.tab,
            unselectedLabelColor: Color.fromARGB(255, 218, 218, 218),
            unselectedLabelStyle: TextStyle(),
            labelColor: Colors.black,
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            // tabs的长度必须和上面写的length一样
            tabs: [
              Tab(
                text: '听听',
              ),
              Tab(
                text: '推荐',
              ),
              Tab(
                text: '故事',
              ),
            ],
            onTap: (index) => {_tabController.animateTo(index), print(index)},
          ),
          leading: InkWell(
            onTap: () {
              // 打开抽屉
              _key.currentState?.openDrawer();
            },
            child: Container(child: Icon(Icons.menu)),
          ),
          actions: [
            InkWell(
                onTap: () => {Scaffold.of(context).openDrawer()},
                child: Container(
                  margin: EdgeInsets.only(right: 15),
                  child: Icon(Icons.add),
                ))
          ],
        ),
        drawer: Drawer(
          child: AppDrawer(),
        ),
        // 为scaffold绑定key
        key: _key,
        // 与tabbar关联的页面
        body: TabBarView(
          controller: _tabController,
          children: [
            TabView1(),
            Recommand(),
            TabView2(),
          ],
        ),
      ),
    );
  }
}

class Recommand extends StatefulWidget {
  Recommand({Key? key}) : super(key: key);

  @override
  State<Recommand> createState() => _RecommandState();
}

class _RecommandState extends State<Recommand> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          height: 50,
          color: Colors.white,
          padding: EdgeInsets.all(10),
          child: TextField(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
              hintText: '大家都在听',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(width: 0, color: Colors.transparent),
              ),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(bottom: 10, top: 10),
          color: Colors.white,
          child: TopBar(),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          color: Colors.white,
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    width: 15,
                    height: 15,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                          'https://img2.baidu.com/it/u=24093642,3559459273&fm=253&fmt=auto&app=138&f=JPEG?w=400&h=389'),
                    ),
                  ),
                  Text(
                    '猜你喜欢',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(3),
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 1, color: Color.fromARGB(255, 194, 194, 194)),
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  '兴趣定制',
                  style: TextStyle(fontSize: 10),
                ),
              )
            ],
          ),
        ),
        Container(
          color: Colors.white,
          child: WrapLikes(),
        ),
      ],
    );
  }
}

class TopBar extends StatefulWidget {
  TopBar({Key? key}) : super(key: key);

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: DefaultTabController(
        length: 8,
        child: TabBar(
          isScrollable: true,
          indicator: BoxDecoration(),
          tabs: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(
                      'https://img2.baidu.com/it/u=961987382,746804532&fm=253&fmt=auto&app=120&f=JPEG?w=1422&h=800',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  '看一看',
                  style: TextStyle(
                      fontSize: 10, color: Color.fromARGB(255, 82, 82, 82)),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(
                      'https://img0.baidu.com/it/u=868769418,1297223045&fm=253&fmt=auto&app=138&f=JPEG?w=724&h=500',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  '玩一玩',
                  style: TextStyle(
                      fontSize: 10, color: Color.fromARGB(255, 82, 82, 82)),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(
                      'https://img0.baidu.com/it/u=3388012925,725455247&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  '听一听',
                  style: TextStyle(
                      fontSize: 10, color: Color.fromARGB(255, 82, 82, 82)),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(
                      'https://img2.baidu.com/it/u=2757372953,4251120664&fm=253&fmt=auto&app=120&f=JPEG?w=1024&h=768',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  '说一说',
                  style: TextStyle(
                      fontSize: 10, color: Color.fromARGB(255, 82, 82, 82)),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(
                      'https://img0.baidu.com/it/u=3235667234,104306759&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  '走一走',
                  style: TextStyle(
                      fontSize: 10, color: Color.fromARGB(255, 82, 82, 82)),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(
                      'https://img0.baidu.com/it/u=1536220225,3207218556&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=500',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  '跑一跑',
                  style: TextStyle(
                      fontSize: 10, color: Color.fromARGB(255, 82, 82, 82)),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(
                      'https://img1.baidu.com/it/u=1351837733,3291131858&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  '睡一睡',
                  style: TextStyle(
                      fontSize: 10, color: Color.fromARGB(255, 82, 82, 82)),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(
                      'https://img1.baidu.com/it/u=2592773635,2347370512&fm=253&fmt=auto&app=138&f=PNG?w=500&h=500',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  '运动一下',
                  style: TextStyle(
                      fontSize: 10, color: Color.fromARGB(255, 82, 82, 82)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// 此处为一个有状态的自定义组件
class WrapLike extends StatefulWidget {
  // 定义所需要接收的参数
  final String? imgurl;
  final String? description;
  final int? count;
  // {}内都是可选参数 若想变为必选可添加required关键字 也可写在{}前
  WrapLike({Key? key, this.imgurl, this.description, this.count})
      : super(key: key);

  @override
  State<WrapLike> createState() => _WrapLikeState();
}

class _WrapLikeState extends State<WrapLike> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Container(
              width: MediaQuery.of(context).size.width / 3,
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(
                    height: 100,
                    // 目前所在盒子的最大宽高
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        // 可通过widget获取继承父级的参数
                        widget.imgurl as String,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Wrap(
                    alignment: WrapAlignment.start,
                    children: [
                      Text(
                        widget.description as String,
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  )
                ],
              )),
          Positioned(
            top: 15,
            right: 20,
            child: Container(
              padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 198, 198, 198),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: 10,
                    height: 10,
                    // ClipRRect可设置圆角 container亦可以但有时会莫名其妙失效
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        'https://img2.baidu.com/it/u=24093642,3559459273&fm=253&fmt=auto&app=138&f=JPEG?w=400&h=389',
                        // 图片铺满父元素
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Text(
                    widget.count! > 10000
                        ? (widget.count! / 10000).toStringAsFixed(2) + '万'
                        : widget.count.toString(),
                    style: TextStyle(fontSize: 10),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class WrapLikes extends StatefulWidget {
  WrapLikes({Key? key}) : super(key: key);

  @override
  State<WrapLikes> createState() => _WrapLikesState();
}

class _WrapLikesState extends State<WrapLikes> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Wrap(children: [
        WrapLike(
          imgurl:
              'https://img0.baidu.com/it/u=2521851051,2189866243&fm=253&fmt=auto&app=138&f=JPEG?w=889&h=500',
          count: 45,
          description: '我是简介',
        ),
        WrapLike(
          imgurl:
              'https://img2.baidu.com/it/u=2147843660,3054818539&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=313',
          count: 7892,
          description: '我是简介',
        ),
        WrapLike(
          imgurl:
              'https://img1.baidu.com/it/u=722430420,1974228945&fm=253&fmt=auto&app=138&f=JPEG?w=889&h=500',
          count: 634,
          description: '我是简介',
        ),
        WrapLike(
          imgurl:
              'https://img2.baidu.com/it/u=1404596068,2549809832&fm=253&fmt=auto&app=120&f=JPEG?w=1067&h=800',
          count: 1236,
          description: '我是简介',
        ),
        WrapLike(
          imgurl:
              'https://img2.baidu.com/it/u=3573340222,719722755&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=784',
          count: 44213,
          description: '我是简介',
        ),
        WrapLike(
          imgurl:
              'https://img1.baidu.com/it/u=931545919,4030748642&fm=253&fmt=auto&app=138&f=JPEG?w=306&h=459',
          count: 123,
          description: '我是简介',
        ),
      ]),
    );
  }
}

class TabView1 extends StatefulWidget {
  TabView1({Key? key}) : super(key: key);

  @override
  State<TabView1> createState() => _TabView1State();
}

class _TabView1State extends State<TabView1> {
  Future _alertDialog() async {
    var result = showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('提示信息'),
            content: Text('shit'),
            actions: [
              ElevatedButton(
                  onPressed: () => {Navigator.pop(context)}, child: Text('取消')),
              ElevatedButton(
                  onPressed: () => {Navigator.pop(context)}, child: Text('确认')),
            ],
          );
        });
    print(result);
    return result;
  }

  var simpleDialogOptions = [
    {'label': '1', 'value': 1},
    {'label': '2', 'value': 2},
    {'label': '3', 'value': 3},
  ];
  _getSimpleDialogOption(BuildContext context, List data) {
    return data
        .map<Widget>(
          (item) => SimpleDialogOption(
            child: Text(item['label']),
            onPressed: () {
              print(item['value']);
            },
          ),
        )
        .toList();
  }

  Future _simpleDialog() async {
    var result = showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text('请选择'),
            children: _getSimpleDialogOption(context, simpleDialogOptions),
          );
        });
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: _alertDialog,
          child: Text("AlertDialog"),
        ),
        SizedBox(
          height: 24.0,
        ),
        ElevatedButton(
          onPressed: _simpleDialog,
          child: Text("SimpleDialog"),
        ),
        SizedBox(
          height: 24.0,
        ),
        ElevatedButton(
          onPressed: () {
            Fluttertoast.showToast(
                msg: "This is Center Short Toast",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 12.0);
          },
          child: Text("Flutter Toast Context"),
        ),
      ],
    );
  }
}

class TabView2 extends StatefulWidget {
  TabView2({Key? key}) : super(key: key);

  @override
  State<TabView2> createState() => _TabView2State();
}

class _TabView2State extends State<TabView2> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return '请输入';
                  }
                  return null;
                },
              ),
              TextFormField(
                validator: (value) {
                  if (value is! int) {
                    return '请输入数值型';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                  onPressed: () => {
                        if (_formKey.currentState!.validate()) {print('验证通过')}
                      },
                  child: Text('提交'))
            ],
          ),
        ),
        Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              color: Colors.red,
            ),
            Container(
              width: 300,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.blue,
              ),
              height: 200,
              color: Colors.red,
            ),
            Container(
              width: 300,
              height: 100,
              color: Colors.red,
            ),
            Container(
              width: 300,
              height: 100,
              color: Colors.red,
            ),
            Container(
              width: 300,
              height: 100,
              color: Colors.red,
            ),
            Container(
              width: 300,
              height: 100,
              color: Colors.red,
            ),
          ],
        )
      ],
    );
  }
}
