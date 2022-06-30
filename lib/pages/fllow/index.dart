import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import '../../state/index.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class FllowPage extends StatefulWidget {
  FllowPage({Key? key}) : super(key: key);

  @override
  State<FllowPage> createState() => _FllowPage();
}

class _FllowPage extends State<FllowPage> {
  final audioPlayer = AudioPlayer();
  @override
  void initState() {
    // audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(
    //     "https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3")));
    super.initState();
    // EasyLoading.addStatusCallback((status) {
    //   print('EasyLoading Status $status');
    //   if (status == EasyLoadingStatus.dismiss) {
    //     // _timer?.cancel();
    //   }
    // });

    EasyLoading.show(status: '加载中...');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            child: Text('play'),
            onPressed: () => {EasyLoading.dismiss()},
          ),
          Text(context.watch<Modal>().count.toString()),
          // Container(child: CupertionSegmentControl<EasyLoadingStyle>())
        ],
      ),
    );
  }
}
