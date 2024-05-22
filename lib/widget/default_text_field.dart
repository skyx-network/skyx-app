import 'package:flutter/material.dart';

class DefaultTextField extends StatefulWidget {
  const DefaultTextField({
    super.key,
    required this.label,
    this.controller,
    this.textInputType,
    this.hintText = "",
    this.obscureText = false,
    this.suffixWidget,
  });

  final String label;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final String hintText;
  final bool obscureText;
  final Widget? suffixWidget;

  @override
  State<DefaultTextField> createState() => _DefaultTextFieldState();
}

class _DefaultTextFieldState extends State<DefaultTextField> {
  late bool hidePassword;

  @override
  void initState() {
    super.initState();
    hidePassword = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Text(
            widget.label,
            style: TextStyle(fontSize: 16),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                offset: Offset(0, 6),
                spreadRadius: 2,
                blurRadius: 12,
              )
            ],
            color: Colors.white,
            borderRadius: BorderRadius.circular(35),
          ),
          child: TextField(
            controller: widget.controller,
            keyboardType: widget.textInputType,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: widget.hintText,
              suffixIcon: widget.obscureText
                  ? IconButton(
                      icon: Icon(hidePassword
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          hidePassword = !hidePassword;
                        });
                      },
                    )
                  : widget.suffixWidget,
            ),
            obscureText: hidePassword,
            enableInteractiveSelection: !widget.obscureText,
          ),
        )
      ],
    );
  }
}
