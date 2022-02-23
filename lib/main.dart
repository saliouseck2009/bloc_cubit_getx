import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

void main() {
  runApp(GetMaterialApp(enableLog: true, home: Home()));
}

class Home extends StatelessWidget {
  @override
  Widget build(context) {
    // Instanciez votre classe en utilisant Get.put() pour le rendre disponible pour tous les routes "descendantes".
    final Controller c = Get.put(Controller());

    return Scaffold(
        // Utilisez Obx(()=> pour mettre à jour Text() chaque fois que count est changé.
        appBar: AppBar(title: Obx(() => Text("Clicks: ${c.count}"))),

        // Remplacez les 8 lignes Navigator.push par un simple Get.to(). Vous n'avez pas besoin de 'context'
        body: Center(
            child: ElevatedButton(
                child: Text("Go to Other"), onPressed: () => Get.to(Other()))),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add), onPressed: c.increment));
  }
}

class Other extends StatelessWidget {
  // Vous pouvez demander à Get de trouver un contrôleur utilisé par une autre page et de vous y rediriger.
  final Controller c = Get.find();

  @override
  Widget build(context) {
    // Accéder à la variable 'count' qui est mise à jour
    return Scaffold(body: Center(child: Text("${c.count}")));
  }
}
