/// Media extend from Change Notifier to rebuild my states so I can Use Change Notifier Provider
///  and Consumer for rebuild widgets that I need to.

import 'dart:async';
import 'package:flutter/material.dart';

class Media extends ChangeNotifier {
  ///Media constructor get title and call upload media to upload it.
  Media(this._title) {
    uploadMedia(_title);
  }

  ///the name of my file is here for the minmal code I remove any needless data
  late String _title;
  String get title => _title;

  ///here is my StreamController for stream the progress bar value
  StreamController<double> _progressStreamController = StreamController();

  /// and I wrote a get func to acssess the StreamController out of the class
  StreamController<double> get streamController => _progressStreamController;

  bool _uploading = true;
  bool get uploading => _uploading;

  /// in the upload media I just wrote a fake timer to show that the media is uploading
  Future<bool> uploadMedia(String title) async {
    /// and this show the value of progress bar that I wanna stream it
    double _progress = 0;
    Timer.periodic(const Duration(seconds: 1), (t) {
      ///and here progress value updatet every second and after a wihle I cancel it
      _progress += 0.1;
      if (_progress >= 0.999) t.cancel();

      /// here streambuilder is updating
      _progressStreamController.add(_progress);
    });

    /// and here hold uploading media
    await Future.delayed(const Duration(seconds: 10));

    ///and finaly fill it local here
    _title = title;
    _uploading = false;
    notifyListeners();

    return true;
  }
}
