import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_colors.dart';

// ignore: must_be_immutable
class Messege extends StatefulWidget {
  bool sender; // true=>me fales=>api
  String text;

  Messege({super.key, required this.sender, required this.text});

  @override
  State<Messege> createState() => _MessegeState();
}

class _MessegeState extends State<Messege> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          widget.sender ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: (widget.sender) ? AppColors.blue : Colors.grey,
                    borderRadius: BorderRadius.circular(15)),
                padding: EdgeInsets.all(8),
                constraints: BoxConstraints(maxWidth: 300),
                child: Text(
                  widget.text,
                  style: TextStyle(
                      color: (widget.sender) ? AppColors.white : Colors.black),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
