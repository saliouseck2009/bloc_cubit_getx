import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class User {
  User({this.nom = "", this.score = 0});
  String nom;
  int score;
}

class CounterCubit extends Cubit<User> {
  CounterCubit() : super(User(nom: "unknow", score: 0));
  void increment() {
    emit(User(nom: state.nom, score: state.score + 1));
  }

  void decrement() => emit(User(nom: state.nom, score: state.score - 1));
}

class WtithBloc extends StatelessWidget {
  @override
  Widget build(context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("With bloc"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<CounterCubit, User>(
              builder: (context, state) {
                return Text(
                  "Name: ${state.nom}  score: ${state.score}",
                  style: TextStyle(fontSize: 30),
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    icon: Icon(
                      Icons.add_circle_outline_rounded,
                      color: Theme.of(context).primaryColor,
                      size: 30,
                    ),
                    onPressed: () => context.read<CounterCubit>().increment()),
                const SizedBox(
                  width: 50,
                ),
                IconButton(
                    icon: Icon(Icons.remove_circle_outline_rounded,
                        color: Theme.of(context).primaryColor, size: 30),
                    onPressed: () => context.read<CounterCubit>().decrement()),
              ],
            )
          ],
        ));
  }
}

///-----------------------Utilisation de Getx ------------------------

class UserController extends GetxController {
  final user = User(nom: "Unknow", score: 0).obs;

  void increment() {
    return user.update((_user) {
      _user!.score++;
    });
  }

  void decrement() {
    return user.update((_user) {
      _user!.score--;
    });
  }
}

class WithGet extends StatelessWidget {
  const WithGet({Key? key}) : super(key: key);

  @override
  Widget build(context) {
    //final UserController userController = Get.put(UserController());

    return Scaffold(
        appBar: AppBar(
          title: const Text("state with getx"),
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          GetX<UserController>(
              init: UserController(),
              builder: (_) {
                return Text(
                  "Nom: ${_.user.value.nom}",
                  style: const TextStyle(fontSize: 25),
                );
              }),
          const SizedBox(
            height: 10,
          ),
          Obx(() => Text(
                "Score: ${Get.find<UserController>().user.value.score}",
                style: const TextStyle(fontSize: 25),
              )),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  icon: Icon(Icons.add_circle_outline_rounded,
                      size: 30, color: Theme.of(context).primaryColor),
                  onPressed: () => Get.find<UserController>().increment()),
              const SizedBox(
                width: 50,
              ),
              IconButton(
                  icon: Icon(
                    Icons.remove_circle_outline_rounded,
                    size: 30,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () => Get.find<UserController>().decrement()),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          ElevatedButton(
              onPressed: () => Get.to(WtithBloc()),
              child: const Text("Go to the Cubit page"))
        ]));
  }
}

void main() {
  runApp(BlocProvider(
    create: (context) => CounterCubit(),
    child: GetMaterialApp(
      enableLog: true,
      home: WithGet(),
    ),
  ));
}
