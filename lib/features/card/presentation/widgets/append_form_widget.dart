import 'package:flutter/material.dart';
import 'package:flutter_memorize/features/card/presentation/widgets/text_widget.dart';

class AppendFormWidget extends StatelessWidget {
  const AppendFormWidget({
    super.key,
    required TextEditingController titleController,
    required TextEditingController contentController,
  })  : _titleController = titleController,
        _contentController = contentController;

  final TextEditingController _titleController;
  final TextEditingController _contentController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MemorizeInputTextField(
            controller: _titleController,
            title: "제목",
          ),
          const SizedBox(height: 16),
          MemorizeInputTextField(
            controller: _contentController,
            title: '내용',
            maxLines: 10,
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
