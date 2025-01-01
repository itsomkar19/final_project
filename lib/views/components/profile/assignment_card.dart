import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AssignmentCard extends StatelessWidget {
  final Map<String, List<int>> data;

  const AssignmentCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: data.entries
            .map((entry) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.key,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Row(
                      children: entry.value
                          .map((mark) => mark > 0 ? '✅' : '❌')
                          .map((icon) => Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                child: Text(icon),
                              ))
                          .toList(),
                    ),
                    const SizedBox(height: 16),
                  ],
                ))
            .toList(),
      ),
    );
  }
}
