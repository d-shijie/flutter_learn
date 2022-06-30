// ignore_for_file: avoid_unnecessary_containers, avoid_print, unused_import, import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import '../drawer/index.dart';
import '../../api/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FindPage extends StatefulWidget {
  FindPage({Key? key}) : super(key: key);

  @override
  State<FindPage> createState() => _FindPageState();
}

class _FindPageState extends State<FindPage> {
  var keywords = TextEditingController();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late SharedPreferences pref;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initPref();
    _prefs.then((SharedPreferences pref) => pref.setString('test', 'test'));
    var test = _prefs.then((SharedPreferences pref) => pref.getString('test'));
    test.then((value) => print(value));
  }

  _initPref() async {
    pref = await _prefs;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Color.fromARGB(59, 183, 181, 181),
        // 顶部导航栏
        appBar: AppBar(
          // 顶部导航栏右侧
          actions: [
            InkWell(
              child: Container(
                margin: EdgeInsets.only(right: 15),
                child: Icon(Icons.mic),
              ),
              onTap: () => {Navigator.pushNamed(context, '/sdad')},
            )
          ],
          // 顶部导航栏左侧
          // leading: Icon(Icons.add),
          centerTitle: true, // 中间组件居中
          titleSpacing: 0, //清除title左右padding，默认情况下会有一定的padding距离
          toolbarHeight: 44, //将高度定到44
          backgroundColor: Color.fromARGB(255, 235, 85, 74),
          // title为一个widget 位于中间位置
          title: Container(
              height: 30,
              width: 250,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: keywords,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(width: 0, color: Colors.transparent)),
                  hintText: '搜索',
                  prefixIcon: Icon(Icons.search),
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              )),
        ),
        // 页面组件
        body: Column(
          children: [
            Container(
              height: 150,
              child: BannerSwiper(),
            ),
            Mslider(),
            Container(
                height: 335,
                child: ListView(
                  children: [
                    Card(
                        child: Container(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                      child: RPlayList(),
                    )),
                    Card(
                        child: Container(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                      child: RMusic(),
                    )),
                  ],
                )),
          ],
        ),
        // 抽屉组件 左侧弹出 enddrawer右侧弹出
        drawer: Drawer(
          child: AppDrawer(),
        ),
      ),
    );
  }
}

// banner
class BannerSwiper extends StatefulWidget {
  BannerSwiper({Key? key}) : super(key: key);

  @override
  State<BannerSwiper> createState() => _BannerSwiper();
}

class _BannerSwiper extends State<BannerSwiper> {
  var banners = [];
  _getBanner() async {
    var api = Api();
    var data = await api.getBanners();
    // 注意：接口获取的数据需要通过setState方法赋值 否则可能失效 无状态组件无法使用setState建议使用有状态组件
    setState(() {
      banners = data['banners'];
    });
  }

  @override
  void initState() {
    _getBanner();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color.fromARGB(59, 183, 181, 181),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Swiper(
        key: UniqueKey(), //不加这个会产生红屏错误
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              banners[index]['pic'] ?? '',
              fit: BoxFit.fill,
            ),
          );
        },
        itemCount: banners.length,
        loop: true,
        duration: 1000,
        autoplay: true,
        pagination: const SwiperPagination(
            margin: EdgeInsets.only(top: 10), builder: SwiperPagination.dots),
        control: const SwiperControl(
          iconPrevious: IconData(0),
          iconNext: IconData(0),
        ),
      ),
    );
  }
}

// 分类tab
class Mslider extends StatefulWidget {
  Mslider({Key? key}) : super(key: key);

  @override
  State<Mslider> createState() => _MsliderState();
}

class _MsliderState extends State<Mslider> {
  @override
  Widget build(BuildContext context) {
    return Container(

        // tabbar必须有父级defaultTabBarController，否则无法显示
        child: DefaultTabController(
      length: 9,
      child: TabBar(
        indicator: const BoxDecoration(), //去除下划线
        isScrollable: true,
        unselectedLabelColor: Color.fromARGB(255, 91, 91, 91),
        unselectedLabelStyle: TextStyle(fontSize: 12),
        labelStyle: TextStyle(fontSize: 12),
        labelColor: Color.fromARGB(255, 83, 83, 83),
        tabs: [
          Tab(
            text: '每日推荐',
            icon: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 219, 221, 223),
                  borderRadius: BorderRadius.circular(50)),
              child: Icon(Icons.sd_card_alert, color: Colors.red),
            ),
          ),
          Tab(
            text: '私人FM',
            icon: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 219, 221, 223),
                  borderRadius: BorderRadius.circular(50)),
              child: Icon(Icons.wash_outlined, color: Colors.red),
            ),
          ),
          Tab(
            text: '歌单',
            icon: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 219, 221, 223),
                  borderRadius: BorderRadius.circular(50)),
              child: Icon(Icons.g_mobiledata, color: Colors.red),
            ),
          ),
          Tab(
            text: '排行榜',
            icon: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 219, 221, 223),
                  borderRadius: BorderRadius.circular(50)),
              child: Icon(Icons.nat, color: Colors.red),
            ),
          ),
          Tab(
            text: '直播',
            icon: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 219, 221, 223),
                  borderRadius: BorderRadius.circular(50)),
              child: Icon(Icons.tag_faces_sharp, color: Colors.red),
            ),
          ),
          Tab(
            text: '数字专辑',
            icon: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 219, 221, 223),
                  borderRadius: BorderRadius.circular(50)),
              child: Icon(Icons.kayaking, color: Colors.red),
            ),
          ),
          Tab(
            text: '有声书',
            icon: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 219, 221, 223),
                  borderRadius: BorderRadius.circular(50)),
              child: Icon(Icons.manage_search_rounded, color: Colors.red),
            ),
          ),
          Tab(
            text: '关注新歌',
            icon: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 219, 221, 223),
                  borderRadius: BorderRadius.circular(50)),
              child: Icon(Icons.javascript_sharp, color: Colors.red),
            ),
          ),
          Tab(
            text: '歌房',
            icon: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 219, 221, 223),
                  borderRadius: BorderRadius.circular(50)),
              child: Icon(Icons.face_retouching_natural, color: Colors.red),
            ),
          ),
        ],
      ),
    ));
  }
}

// 推荐歌单
class RPlayList extends StatefulWidget {
  RPlayList({Key? key}) : super(key: key);

  @override
  State<RPlayList> createState() => _RPlayListState();
}

class _RPlayListState extends State<RPlayList> {
  var api = Api();
  List<Widget> playlistW = [];
  Widget _buildItem(BuildContext context, data, int i) {
    return InkWell(
        onTap: (() => {
              // 三个参数 上下文 路由路径（route里命名） 传递参数
              Navigator.pushNamed(context, '/playlistDetail',
                  arguments: {'pid': data[i]['id']})
            }),
        child: Tab(
          child: Container(
              child: Column(
            children: <Widget>[
              Container(
                  margin: const EdgeInsets.only(right: 15),
                  height: 80,
                  width: 80,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      data[i]['coverImgUrl'] ??
                          'https://img0.baidu.com/it/u=3872559582,1077850166&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=281',
                      fit: BoxFit.fill,
                    ),
                  )),
              Wrap(
                children: [
                  Container(
                    width: 80,
                    child: Text(
                      data[i]['name'] ?? '1231231414',
                      style: const TextStyle(fontSize: 12, color: Colors.black),
                    ),
                  )
                ],
              )
            ],
          )),
        ));
  }

  _getData() async {
    List<Widget> listW = [];
    var res = await api.getRplaylist();
    var data = res['playlists'];
    for (var i = 0; i < data.length; i++) {
      listW.add(
        _buildItem(context, data, i),
      );
    }
    setState(() {
      playlistW = listW;
    });
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '推荐歌单',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  //按钮大小
                  minimumSize: MaterialStateProperty.all(Size(30, 25)),
                  //圆角
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
                  //边框
                  side: MaterialStateProperty.all(
                    BorderSide(
                        color: Color.fromARGB(255, 165, 165, 165), width: 0.5),
                  ),
                  //背景
                  backgroundColor: MaterialStateProperty.all(
                      Color.fromARGB(255, 223, 223, 223)),
                ),
                onPressed: () => {print(playlistW)},
                child: Text(
                  '更多',
                  style: TextStyle(fontSize: 12, color: Colors.black),
                ),
              ),
            ],
          ),
          Container(
            height: 150,
            child: ListView.builder(
              // 主轴方向
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              // 具体长度
              itemCount: playlistW.length,
              // 返回一个widget 感觉index是从0到playlistW.length-1
              itemBuilder: (context, index) {
                return playlistW[index];
              },
            ),
          ),
        ],
      ),
    );
  }
}

// 推荐歌曲
class RMusic extends StatefulWidget {
  RMusic({Key? key}) : super(key: key);

  @override
  State<RMusic> createState() => _RMusicState();
}

class _RMusicState extends State<RMusic> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '推荐歌曲',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(Size(20, 25)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                backgroundColor: MaterialStateProperty.all(
                    Color.fromARGB(255, 223, 223, 223)),
                side: MaterialStateProperty.all(
                  BorderSide(
                      color: Color.fromARGB(255, 165, 165, 165), width: 0.5),
                ),
              ),
              onPressed: () => {Scaffold.of(context).openDrawer()},
              child: Row(children: [
                Icon(
                  Icons.play_arrow,
                  size: 16,
                  color: Colors.black,
                ),
                Text(
                  '播放',
                  style: TextStyle(fontSize: 12, color: Colors.black),
                ),
              ]),
            )
          ],
        ),
        Container(
          height: 220,
          child: ListView(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            children: [
              Container(
                width: 350,
                child: Column(
                  children: [
                    Container(
                      // height: 40,
                      margin: EdgeInsets.all(0),
                      padding: EdgeInsets.all(0),
                      child: ListTile(
                        title: Text(
                          '歌曲名称',
                          style: TextStyle(fontSize: 12),
                        ),
                        leading: Container(
                          width: 40,
                          height: 40,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              'https://img0.baidu.com/it/u=3872559582,1077850166&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=281',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        subtitle: Text(
                          '歌曲介绍',
                          style: TextStyle(fontSize: 10),
                        ),
                        trailing: Icon(
                          Icons.play_arrow_outlined,
                        ),
                      ),
                    ),
                    Container(
                      height: 1,
                      margin: EdgeInsets.all(0),
                      padding: EdgeInsets.all(0),
                      color: Color.fromARGB(255, 165, 165, 165),
                    ),
                    Container(
                      // height: 40,
                      margin: EdgeInsets.all(0),
                      padding: EdgeInsets.all(0),

                      child: ListTile(
                        title: Text(
                          '1111',
                          style: TextStyle(fontSize: 12),
                        ),
                        leading: Container(
                          width: 40,
                          height: 40,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              'https://img0.baidu.com/it/u=3872559582,1077850166&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=281',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        subtitle: Text(
                          '222222',
                          style: TextStyle(fontSize: 10),
                        ),
                        trailing: Icon(
                          Icons.play_arrow_outlined,
                        ),
                      ),
                    ),
                    Container(
                      height: 1,
                      margin: EdgeInsets.all(0),
                      padding: EdgeInsets.all(0),
                      color: Color.fromARGB(255, 165, 165, 165),
                    ),
                    Container(
                      // height: 40,
                      alignment: Alignment.center,
                      margin: EdgeInsets.all(0),
                      padding: EdgeInsets.all(0),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          ListTile(
                            title: Text(
                              '1111',
                              style: TextStyle(fontSize: 12),
                            ),
                            leading: Container(
                              width: 40,
                              height: 40,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  'https://img0.baidu.com/it/u=3872559582,1077850166&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=281',
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            subtitle: Text(
                              '222222',
                              style: TextStyle(fontSize: 10),
                            ),
                          ),
                          Positioned(
                            right: 15,
                            // top: 30,
                            child: Icon(
                              Icons.play_arrow_outlined,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Column(
                  children: [
                    Container(
                      // height: 40,

                      child: ListTile(
                        title: Text(
                          '歌曲名称',
                          style: TextStyle(fontSize: 12),
                        ),
                        leading: Container(
                          width: 40,
                          height: 40,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              'https://img0.baidu.com/it/u=3872559582,1077850166&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=281',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        subtitle: Text(
                          '歌曲介绍',
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                    ),
                    Container(
                      height: 1,
                      margin: EdgeInsets.all(0),
                      padding: EdgeInsets.all(0),
                      color: Color.fromARGB(255, 165, 165, 165),
                    ),
                    Container(
                      // height: 40,
                      margin: EdgeInsets.all(0),
                      padding: EdgeInsets.all(0),
                      child: ListTile(
                        title: Text(
                          '1111',
                          style: TextStyle(fontSize: 12),
                        ),
                        leading: Container(
                          width: 40,
                          height: 40,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              'https://img0.baidu.com/it/u=3872559582,1077850166&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=281',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        subtitle: Text(
                          '222222',
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                    ),
                    Container(
                      height: 1,
                      margin: EdgeInsets.all(0),
                      padding: EdgeInsets.all(0),
                      color: Color.fromARGB(255, 165, 165, 165),
                    ),
                    Container(
                      // height: 40,
                      margin: EdgeInsets.all(0),
                      padding: EdgeInsets.all(0),
                      child: ListTile(
                        title: Text(
                          '1111',
                          style: TextStyle(fontSize: 12),
                        ),
                        leading: Container(
                          width: 40,
                          height: 40,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              'https://img0.baidu.com/it/u=3872559582,1077850166&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=281',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        subtitle: Text(
                          '222222',
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Container(
                      // height: 40,
                      margin: EdgeInsets.all(0),
                      padding: EdgeInsets.all(0),
                      child: ListTile(
                        title: Text(
                          '歌曲名称',
                          style: TextStyle(fontSize: 12),
                        ),
                        leading: Container(
                          width: 40,
                          height: 40,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              'https://img0.baidu.com/it/u=3872559582,1077850166&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=281',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        subtitle: Text(
                          '歌曲介绍',
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                    ),
                    Container(
                      height: 1,
                      margin: EdgeInsets.all(0),
                      padding: EdgeInsets.all(0),
                      color: Color.fromARGB(255, 165, 165, 165),
                    ),
                    Container(
                      // height: 40,
                      margin: EdgeInsets.all(0),
                      padding: EdgeInsets.all(0),
                      child: ListTile(
                        title: Text(
                          '1111',
                          style: TextStyle(fontSize: 12),
                        ),
                        leading: Container(
                          width: 40,
                          height: 40,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              'https://img0.baidu.com/it/u=3872559582,1077850166&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=281',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        subtitle: Text(
                          '222222',
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                    ),
                    Container(
                      height: 1,
                      margin: EdgeInsets.all(0),
                      padding: EdgeInsets.all(0),
                      color: Color.fromARGB(255, 165, 165, 165),
                    ),
                    Container(
                      // height: 40,
                      margin: EdgeInsets.all(0),
                      padding: EdgeInsets.all(0),
                      child: ListTile(
                        title: Text(
                          '1111',
                          style: TextStyle(fontSize: 12),
                        ),
                        leading: Container(
                          width: 40,
                          height: 40,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              'https://img0.baidu.com/it/u=3872559582,1077850166&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=281',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        subtitle: Text(
                          '222222',
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    ));
  }
}
