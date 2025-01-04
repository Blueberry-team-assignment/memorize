import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator();
  }
}

class Error extends StatelessWidget {
  const Error({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text('예상하지 못한 문제가 발생했어요. 관리자에게 메일을 보내주세요.');
  }
}
