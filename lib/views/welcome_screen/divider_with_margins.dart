import 'package:flutter/material.dart';

class DividerWithMargins extends StatelessWidget {
  const DividerWithMargins({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 25.0),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.25,
          child: const Divider(thickness: 1,color: Colors.black54,),
        ),
        const SizedBox(height: 25.0),
      ],
    );
  }
}


class DividerWithMarginsZero extends StatelessWidget {
  const DividerWithMarginsZero({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.25,
      child: const Divider(thickness: 1,color: Colors.black54,),
    );
  }
}

class DividerWithMarginsPostCard extends StatelessWidget {
  const DividerWithMarginsPostCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 5.0),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.25,
          child: const Divider(thickness: 0.5,color: Colors.black54,),
        ),
        const SizedBox(height: 5.0),
      ],
    );
  }
}
