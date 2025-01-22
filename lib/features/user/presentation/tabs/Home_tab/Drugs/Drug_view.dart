import 'package:flutter/material.dart';

import 'package:graduation_project/shared_widgets/Image%20Carousel.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:graduation_project/shared_widgets/container_search.dart';
import 'package:graduation_project/shared_widgets/custom_icon_camera.dart';

class DrugView extends StatelessWidget {
  const DrugView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Drugs',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 30,
              ),
        ),
        iconTheme: Theme.of(context).iconTheme,
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 20, top: 25),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              const Row(
                children: [
                  Expanded(child: ContainerSearch()),
                  CustomIconCamera(),
                ],
              ),
              ImageCarouselWithCustomIndicator(),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  IconButton(
                    color: Color(0xFF455A64),
                    icon: Icon(MdiIcons.pill),
                    onPressed: () {},
                  ),
                  Text(
                    "Frequently Purchased",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 20),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
