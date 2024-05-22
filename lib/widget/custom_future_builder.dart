import 'package:flutter/material.dart';

typedef AsyncWidgetBuilder<T> = Widget Function(BuildContext context, AsyncSnapshot<T> snapshot);
typedef ErrorCallback = void Function(BuildContext context, Object error);

class CustomFutureBuilder<T> extends StatelessWidget {
  final Future<T> future;
  final AsyncWidgetBuilder<T> builder;
  final Widget loadingWidget;
  final ErrorCallback? onError;

  CustomFutureBuilder({
    Key? key,
    required this.future,
    required this.builder,
    this.loadingWidget = const CircularProgressIndicator(),
    this.onError,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(child: loadingWidget);
          default:
            if (snapshot.hasError) {
              onError?.call(context, snapshot.error!);
              return Text('Something went wrong');
            } else {
              return builder(context, snapshot);
            }
        }
      },
    );
  }
}