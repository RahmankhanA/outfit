import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:outfit/app/modules/home/controllers/home_controller.dart';

class TestOutFit extends GetView<HomeController> {
  const TestOutFit({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Your Outfit to test',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.36,
            child: GetBuilder(
              init: controller,
              initState: (_) {},
              builder: (_) {
                return controller.selectedImages.isEmpty
                    ? const Center(
                        child: Text("There is no data to show"),
                      )
                    : ListView.builder(
                        itemCount: controller.selectedImages.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onLongPress: () {
                              controller.selectedImages[index].isSelected=false;
                              controller.selectedImages.removeAt(index);
                              controller.update();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Flexible(
                                    child: Container(
                                      // height: 500,
                                      decoration: const BoxDecoration(
                                        color: Colors.grey,
                                      ),
                                      child: Image.asset(
                                        controller.selectedImages[index].url,
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text(
                                    "Out Fit name",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700),
                                  ),
                                  const Text("Out Fit Description"),
                                ],
                              ),
                            ),
                          );
                        },
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
