import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class User {
  User({this.nom, this.score});
  String nom;
  int score;
}

class CounterState {
  User user;
  CounterState({this.user});
}

class CounterCubit extends Cubit<User> {
  CounterCubit() : super(User(nom: "unknow", score: 0));
  void increment() => emit(User(nom: state.nom, score: state.score++));
  void decrement() => emit(User(nom: state.nom, score: state.score++));
}

class WtithBloc extends StatelessWidget {
  @override
  Widget build(context) {
    return BlocProvider(
      create: (context) => CounterCubit(),
      child: Scaffold(
          body: Column(
        children: [
          BlocBuilder<CounterCubit, User>(
            builder: (context, state) {
              return Text("Name: ${state.nom}  score: ${state.score}");
            },
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => context.read<CounterCubit>().increment()),
              IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () => context.read<CounterCubit>().decrement()),
            ],
          )
        ],
      )),
    );
  }
}

///-----------------------Utilisation de Getx ------------------------

class UserController extends GetxController {
  final user = User().obs;

  void increment() {
    return user.update((_user) {
      _user.score++;
    });
  }

  void decrement() {
    return user.update((_user) {
      _user.score--;
    });
  }
}

class WithGet extends StatelessWidget {
  @override
  Widget build(context) {
    //final UserController userController = Get.put(UserController());

    return Scaffold(
        appBar: AppBar(
          title: Text("state with getx"),
        ),
        body: Column(children: [
          GetX<UserController>(
              init: UserController(),
              builder: (_) {
                return Text(
                  "Nom: ${_.user.value.nom}",
                  style: TextStyle(fontSize: 25),
                );
              }),
          SizedBox(
            height: 10,
          ),
          Obx(() => Text(
                "Score: ${Get.find<UserController>().user.value.score}",
                style: TextStyle(fontSize: 25),
              )),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => Get.find<UserController>().increment()),
              IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () => Get.find<UserController>().increment()),
            ],
          )
        ]));
  }
}

void main() {
  runApp(GetMaterialApp(enableLog: true, home: WithGet()));
}
