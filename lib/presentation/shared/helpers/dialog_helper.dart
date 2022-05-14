import 'package:flutter/material.dart';

class DialogHelper {
  static void loadingDialog(context) {
    showDialog(
        context: context,
        builder: (_) => Dialog(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                  ],
                ),
              ),
            ));
  }

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

  static Future<bool?> shouldDelete(context, name) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Are you sure want to remove $name?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text(
                  'CANCEL',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text(
                  'DELETE',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          );
        });
  }
}
