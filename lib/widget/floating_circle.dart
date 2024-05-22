import 'package:flutter/material.dart';

class FloatingCircle extends StatefulWidget {
  const FloatingCircle({super.key, required this.amount});

  final int amount;

  @override
  State<FloatingCircle> createState() => _FloatingCircleState();
}

class _FloatingCircleState extends State<FloatingCircle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    // 初始化动画控制器
    _controller = AnimationController(
      vsync: this, // 提供帧信号
      duration: const Duration(seconds: 3), // 动画持续时间
    )..repeat(reverse: true); // 循环播放动画，并且当到达终点后反向播放
    // 创建动画，使用easeInOut风格的曲线，这样动画开头和结尾会慢，中间会快
    _animation = Tween<double>(begin: -15, end: 15).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center, // Stack内部widget集中对齐
      children: <Widget>[
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            // 使用Translate进行位置变换实现浮动效果
            return Transform.translate(
              offset: Offset(0, _animation.value),
              child: child,
            );
          },
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Color(0xFFa0fccc),
                Color(0xFF8cedb8),
                Color(0xFFc1fce0),
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
              shape: BoxShape.circle,
              border: Border.all(
                color: Color(0xFFcdf8eb),
                width: 2,
              ),
            ),
            child: Center(
              child: Opacity(
                opacity: widget.amount <= 0 ? 0.7 : 1,
                child: Text(
                  widget.amount <= 0 ? "waiting" : "${widget.amount}",
                  style: TextStyle(
                    color: Color.fromRGBO(47, 104, 85, 1),
                    fontWeight: FontWeight.w700,
                    fontSize:  widget.amount <= 0 ? 10 : 15
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // 销毁控制器以避免内存泄漏
    super.dispose();
  }
}
