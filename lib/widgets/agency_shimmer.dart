import 'package:flutter/material.dart';

import 'Rshimmer.dart';

class AgenciesShimmer extends StatelessWidget {
  const AgenciesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              const RShimmerEffect(
                height: 60,
                width: 60,
              //  borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    RShimmerEffect(height: 14, width: double.infinity),
                    SizedBox(height: 8),
                    RShimmerEffect(height: 12, width: 150),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
