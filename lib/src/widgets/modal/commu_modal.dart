import 'package:flutter/material.dart';

class CommuBottomModal extends StatelessWidget {
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const CommuBottomModal({
    required this.onEdit,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          title: const Text(
            '수정',
            textAlign: TextAlign.center,
          ),
          onTap: onEdit,
        ),
        ListTile(
          title: const Text(
            '삭제',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.red),
          ),
          onTap: onDelete,
        ),
      ],
    );
    ;
  }
}
