import 'package:flutter/material.dart';

typedef AsyncWidgetBuilder<T> = Widget Function(
    BuildContext context, AsyncSnapshot<T> snapshot);
typedef ErrorCallback = void Function(BuildContext context, Object error);

class CustomFutureBuilder<T> extends StatefulWidget {
  // final Future<T> future;
  final Future<T> Function() future;
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
  State<CustomFutureBuilder<T>> createState() => _CustomFutureBuilderState<T>();
}

class _CustomFutureBuilderState<T> extends State<CustomFutureBuilder<T>> {
  late Future<T> _future;

  @override
  void initState() {
    super.initState();
    _future = widget.future();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: _future,
      builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(child: widget.loadingWidget);
          default:
            if (snapshot.hasError) {
              widget.onError?.call(context, snapshot.error!);
              // 发生错误时显示重试按钮
              return _buildErrorUI();
            } else {
              return widget.builder(context, snapshot);
            }
        }
      },
    );
  }

  Widget _buildErrorUI() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Network Error",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const Text(
            'Please check your connection and try again.',
            textAlign: TextAlign.center,
            // style: TextStyle(color: Colors.red),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _future = widget.future(); // 重新加载当前Future
              });
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Color(0xFF015678)),
            ),
            child: Text(
              'Retry',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
