import 'package:flutter/material.dart';
import 'media.dart';

class MediaPool extends ChangeNotifier {
  /// _medias is List of <Media>
  List<Media> _medias = [];
  List<Media> get medias => _medias;

  /// to add new value
  void addFirst(Media media) {
    _medias.insert(0, media);
    notifyListeners();
  }
}
