import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DefaultTextFormField extends StatefulWidget {
  const DefaultTextFormField({
    super.key,
    required this.label,
    this.controller,
    this.textInputType,
    this.hintText = "",
    this.obscureText = false,
    this.validator,
    this.suffixWidget,
    this.onSaved,
  });

  final String label;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final String hintText;
  final bool obscureText;
  final String? Function(String?)? validator;
  final Widget? suffixWidget;
  final void Function(String?)? onSaved;

  @override
  State<DefaultTextFormField> createState() => _DefaultTextFormFieldState();
}

class _DefaultTextFormFieldState extends State<DefaultTextFormField> {
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
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              offset: Offset(0, 6),
              spreadRadius: 2,
              blurRadius: 12,
            )
          ], color: Colors.white, borderRadius: BorderRadius.circular(35)),
          child: TextFormField(
            validator: widget.validator,
            controller: widget.controller,
            keyboardType: widget.textInputType,
            autofocus: false,
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
            onSaved: widget.onSaved,
          ),
        )
      ],
    );
  }
}
