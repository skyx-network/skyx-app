import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map_heatmap/flutter_map_heatmap.dart';

class _circlePoint {
  final LatLng point;
  final double radius;

  _circlePoint({
    required this.point,
    required this.radius,
  });
}

class ExplorerPage extends StatefulWidget {
  ExplorerPage({super.key});

  @override
  State<ExplorerPage> createState() => _ExplorerPageState();
}

class _ExplorerPageState extends State<ExplorerPage> {
  final StreamController<void> _rebuildStream = StreamController.broadcast();

  List<WeightedLatLng> data = [];
  Map<double, MaterialColor> gradients = {
    0.25: Colors.blue,
    0.55: Colors.red,
    0.85: Colors.pink,
    1.0: Colors.purple
  };

  _loadData() async {
    var str = await rootBundle.loadString('assets/json/heatmap.json');
    List<dynamic> result = jsonDecode(str);

    setState(() {
      data = result
          .map((e) => e as List<dynamic>)
          .map((e) => WeightedLatLng(LatLng(e[0], e[1]), 10))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();

    _loadData();
  }

  @override
  dispose() {
    _rebuildStream.close();
    super.dispose();
  }

//Color(0xFFb3efc4)
  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   _rebuildStream.add(null);
    // });

    return FlutterMap(
      options: MapOptions(
        keepAlive: true,
        initialCenter: LatLng(51.509364, -0.128928),
        initialZoom: 2,
        cameraConstraint: CameraConstraint.contain(
          bounds: LatLngBounds(
            const LatLng(-110, -220),
            const LatLng(110, 220),
          ),
        ),
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          // userAgentPackageName: 'com.xj.skyx.app3',
          retinaMode: false,
        ),
        if (data.isNotEmpty)
          HeatMapLayer(
            heatMapDataSource: InMemoryHeatMapDataSource(data: data),
            heatMapOptions: HeatMapOptions(
                gradient: gradients, minOpacity: 0.5, radius: 50),
            reset: _rebuildStream.stream,
          )
      ],
    );
  }
}
