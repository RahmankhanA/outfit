import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outfit/app/modules/home/views/test_outfit_view.dart';

import '../controllers/home_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  late HomeController controller;
  @override
  void initState() {
    super.initState();
    controller = Get.put(HomeController());
    tabController = TabController(
      initialIndex: 1,
      length: controller.categories.length,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.menu),
          title: const Text('Menu'),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Select a product to try',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                ),
              ),
              // SizedBox(
              //   height: 40,
              //   child: ListView.separated(
              //     itemCount: controller.categories.length,
              //     scrollDirection: Axis.horizontal,
              //     separatorBuilder: (BuildContext context, int index) {
              //       return const SizedBox(
              //         width: 10,
              //       );
              //     },
              //     itemBuilder: (BuildContext context, int index) {
              //       return Obx(
              //         () => Padding(
              //           padding: const EdgeInsets.all(8.0),
              //           child: Text(
              //             controller.categories[index],
              //             style: TextStyle(
              //               color: controller.selectedCategoryIndex.value == index
              //                   ? Colors.yellow[400]
              //                   : Colors.black,
              //                   decoration: TextDecoration.underline
              //             ),
              //           ),
              //         ),
              //       );
              //     },
              //   ),
              // ),
              TabBar(
                indicatorColor: Colors.yellowAccent,
                unselectedLabelColor: Colors.black,
                labelColor: Colors.yellowAccent,
                controller: tabController,
                tabs: List.generate(
                  controller.categories.length,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(controller.categories[index]),
                  ),
                ),
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.75,
                // width: 100,
                child: TabBarView(
                  controller: tabController,
                  children: List.generate(
                    controller.categories.length,
                    (index) => showCard(),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomSheet: GetBuilder(
          init: controller,
          initState: (_) {},
          builder: (_) {
            return controller.selectedImages.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OutlinedButton.icon(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.black,
                            side: const BorderSide(
                              color: Colors.yellowAccent,
                            ),
                          ),
                          icon: const Icon(Icons.menu),
                          label: const Text("OUTFITS"),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.black,
                            side: const BorderSide(
                              color: Colors.yellowAccent,
                            ),
                          ),
                          onPressed: () {},
                          icon: const Icon(Icons.add_circle),
                          label: const Text("ADD NEW OUTFIT"),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Get.to(() => const TestOutFit());
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.yellowAccent,
                              foregroundColor: Colors.black,
                            ),
                            child: const Row(
                              children: [
                                Text("GO TO THE TEST"),
                                Icon(Icons.arrow_forward)
                              ],
                            ))
                      ],
                    ),
                  )
                : const SizedBox();
          },
        ));
  }

  Widget showCard() {
    return GridView.count(
      crossAxisCount: 5,
      crossAxisSpacing: 2.0,
      mainAxisSpacing: 2.0,
      shrinkWrap: true,
      children: List.generate(
        controller.images.length,
        (index) {
          return GetBuilder(
            init: controller,
            initState: (_) {},
            builder: (_) {
              return GestureDetector(
                onTap: () {
                  controller.handleOnTap(data: controller.images[index]);
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Flexible(
                        child: Stack(
                          children: [
                            Container(
                              // height: 500,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                border: controller.images[index].isSelected
                                    ? Border.all(
                                        color: Colors.yellowAccent, width: 2.0)
                                    : null,
                              ),
                              child: Image.asset(
                                controller.images[index].url,
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                            controller.images[index].isSelected
                                ? Positioned(
                                    bottom: 5,
                                    right: 5,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.yellowAccent,
                                          borderRadius:
                                              BorderRadius.circular(50.0)),
                                      child: const Icon(
                                        Icons.check,
                                        color: Colors.white,
                                      ),
                                    ))
                                : const SizedBox()
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        "Out Fit name",
                        style: TextStyle(fontWeight: FontWeight.w700),
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
    );
  }
  // Widget showCard() {
  //   return GridView.builder(
  //     itemCount: 50,
  //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //       crossAxisCount: 4,
  //       // mainAxisExtent: 2.5,
  //     ),
  //     itemBuilder: (BuildContext context, int index) {
  //       return Card(
  //         child: SizedBox(
  //             height: 700,
  //             child: Container(
  //               color: Colors.grey,
  //             )),
  //       );
  //     },
  //   );
  // }
}
