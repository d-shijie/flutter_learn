import '../untils/http.dart';

var http = HttpUtils();

class Api {
  Future getBanners() async {
    return await http.get('/banner?type=1');
  }

  Future getRplaylist() async {
    return await http.get('/top/playlist/highquality');
  }

  Future getPlayListDetail(id) async {
    return await http.get(
      '/playlist/detail?id=$id',
    );
  }

  Future login(data) async {
    return await http.get('/login/cellphone', data);
  }
}
