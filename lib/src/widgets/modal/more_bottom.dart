import 'package:flutter/material.dart';

class MoreBottomModal extends StatelessWidget {
  final VoidCallback cancelTap;
  final VoidCallback hideTap;
  final VoidCallback? delete;
  MoreBottomModal({
    required this.cancelTap,
    required this.hideTap,
    this.delete,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.visibility_off_outlined),
                  title: const Text('이 글 숨기기'),
                  onTap: hideTap,
                ),
                const ListTile(
                  leading: Icon(Icons.help_outline),
                  title: Text('게시글 노출 기준'),
                ),
                const ListTile(
                  leading: Icon(
                    Icons.warning_amber_outlined,
                    color: Colors.red,
                  ),
                  title: Text('신고하기'),
                  textColor: Colors.red,
                ),
                Visibility(
                  visible: delete != null,
                  child: ListTile(
                    leading: const Icon(Icons.delete_outline),
                    title: const Text('삭제하기'),
                    onTap: delete,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
                title: Text('닫기', textAlign: TextAlign.center),
                onTap: cancelTap),
          ),
        ],
      ),
    );
  }
}
