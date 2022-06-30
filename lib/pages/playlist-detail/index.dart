// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import '../../api/index.dart';

class PlayListDetail extends StatefulWidget {
  PlayListDetail({Key? key}) : super(key: key);

  @override
  State<PlayListDetail> createState() => _PlayListDetailState();
}

class _PlayListDetailState extends State<PlayListDetail> {
  var arguments;
  final api = Api();
  var detail = {};
  _getDetail() async {
    var res = await api.getPlayListDetail(arguments['pid']);
    setState(() {
      detail = res['playlist'];
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    arguments = ModalRoute.of(context)!.settings.arguments;
    _getDetail();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 44,
        centerTitle: true,
        // 设置渐变背景
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromARGB(255, 62, 62, 65),
              Color.fromARGB(255, 28, 29, 29),
            ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_circle_left),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          '歌单',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        children: [
          Container(
            color: Colors.black,
            height: 150,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
            child: PDetail(playlistDetail: detail),
          )
        ],
      ),
    );
  }
}

class PDetail extends StatefulWidget {
  final playlistDetail;
  PDetail({Key? key, this.playlistDetail}) : super(key: key);

  @override
  State<PDetail> createState() => _PDetailState();
}

class _PDetailState extends State<PDetail> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 3,
                height: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(widget.playlistDetail['coverImgUrl']),
                ),
              ),
              Positioned(
                right: 20,
                top: 5,
                height: 15,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromARGB(255, 107, 107, 107)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                            'https://img2.baidu.com/it/u=24093642,3559459273&fm=253&fmt=auto&app=138&f=JPEG?w=400&h=389'),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        widget.playlistDetail['playCount'] > 10000
                            ? (widget.playlistDetail['playCount'] / 10000)
                                    .toStringAsFixed(2) +
                                '万'
                            : widget.playlistDetail['playCount'],
                        style: TextStyle(fontSize: 10, color: Colors.white),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width / 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Wrap(
                  children: [
                    Container(
                      child: Text(
                        widget.playlistDetail['name'],
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 25,
                        height: 25,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(
                              widget.playlistDetail['creator']['avatarUrl']),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        child: Text(
                          widget.playlistDetail['creator']['nickname'],
                          style: TextStyle(
                              fontSize: 11,
                              color: Color.fromARGB(255, 94, 94, 94)),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
