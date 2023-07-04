import 'package:flutter/material.dart';

class DialogDestroy extends StatefulWidget {
  // const DialogDestroy({super.key});

  final String title;
  final String content;
  final Function(int value) onPressed;

  DialogDestroy(this.title, this.content, {required this.onPressed});

  @override
  State<DialogDestroy> createState() => _DialogDestroyState();
}

class _DialogDestroyState extends State<DialogDestroy> {
  late int _count = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _count = 1;
    // _count = widget.count;
  }

  @override
  Widget build(BuildContext context) {
    print('build conext');
    return AlertDialog(
      title: Text(widget.title),
      content: Text(
        '${widget.content} count: $_count',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel')),
        TextButton(
            onPressed: () =>
                {Navigator.pop(context, 'Cancel'), widget.onPressed(_count)},
            child: const Text('Ok')),
        TextButton(
            onPressed: () => setState(() {
                  _count++;
                }),
            child: const Text('Count')),
      ],
    );
  }
}
