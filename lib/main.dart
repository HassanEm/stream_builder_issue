import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/media.dart';
import 'models/media_pool.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /// and here I use changeNotifierProvider and consumer to access the objects
      home: ChangeNotifierProvider<MediaPool>(
        create: (context) => MediaPool(),
        builder: (context, _) => Scaffold(
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              /// use this fab to add new item you can see when two item is being stream we can see the error
              Provider.of<MediaPool>(context, listen: false)
                  .addFirst(Media('new item'));
            },
          ),
          body: Consumer(
              builder: (context, MediaPool pool, _) => ListView.builder(
                    itemCount: pool.medias.length,
                    itemBuilder: (context, index) =>
                        ChangeNotifierProvider<Media>.value(
                      value: pool.medias[index],
                      builder: (context, _) {
                        return Consumer(builder: (context, Media media, _) {
                          return media.uploading
                              ? StreamBuilder<double>(
                                  stream: media.streamController.stream,
                                  builder: (context, stream) =>
                                      LinearProgressIndicator(
                                          value: stream.data),
                                )
                              : Text(media.title);
                        });
                      },
                    ),
                  )),
        ),
      ),
    );
  }
}
