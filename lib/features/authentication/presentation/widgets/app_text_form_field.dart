import 'package:flutter/material.dart';

class AppTextFormField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController controller;
  const AppTextFormField(
      {super.key,
      required this.title,
      required this.hint,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style:
                TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(
                  color: Colors.grey[400],
                ),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                    gapPadding: 2.0)),
          ),
        ],
      ),
    );
  }
}
