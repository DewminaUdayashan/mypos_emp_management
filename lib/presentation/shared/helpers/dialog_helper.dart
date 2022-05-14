import 'package:flutter/material.dart';

class DialogHelper {
  static Future showAddEmployeeScreenLeftDialog(context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Are you sure want to discard?',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.black54,
                        ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text('CANCEL')),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text('DISCARD'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
