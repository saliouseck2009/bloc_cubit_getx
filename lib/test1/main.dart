import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/test1/sum_screen.dart';

import 'controller.dart';
import 'user_controller.dart';

void main() {
  runApp(GetMaterialApp(enableLog: true, home: Home()));
}

class Home extends StatelessWidget {
  @override
  Widget build(context) {
    // Instanciez votre classe en utilisant Get.put() pour le rendre disponible pour tous les routes "descendantes".
    final Controller countController = Get.put(Controller());
    return Scaffold(
        // Utilisez Obx(()=> pour mettre à jour Text() chaque fois que count est changé.
        appBar: AppBar(title: GetBuilder<Controller>(builder: (_) {
          return Text("Clicks: ${_.counter}");
        })),

        // Remplacez les 8 lignes Navigator.push par un simple Get.to(). Vous n'avez pas besoin de 'context'
        body: Center(
            child: ElevatedButton(
                child: Text("go to Other"), onPressed: () => Get.to(Other()))),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add), onPressed: countController.increment));
  }
}

class Other extends StatelessWidget {
  // Vous pouvez demander à Get de trouver un contrôleur utilisé par une autre page et de vous y rediriger.
  final Controller c = Get.find();

  @override
  Widget build(context) {
    print("hello");
    // Accéder à la variable 'count' qui est mise à jour
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text("${c.counter}")),
          GetX<UserController>(
              init: UserController(),
              builder: (uc) {
                return Text(
                  "Nom: ${uc.user.value.name} ",
                  style: TextStyle(fontSize: 25),
                );
              }),
          Obx(() {
            return Text(
                "user count value : ${Get.find<UserController>().user.value.count}");
          }),
          ElevatedButton(
              onPressed: () => Get.to(Second()), child: Text("Next page"))
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Get.find<UserController>()
                .updateUser(Get.find<Controller>().counter);
          }),
    );
  }
}
