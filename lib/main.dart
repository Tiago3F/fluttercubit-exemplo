import 'package:cubit/cubit/greeting_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<GreetingCubit>(
        create: (context) => GreetingCubit(),
        child: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            const TextMessage(),
            TextButton(
              onPressed: () {
                final greetingCubit = context.read<GreetingCubit>();
                greetingCubit.getNextGreetingState();
              },
              child: const Text('Próxima visita'),
            ),
            TextButton(
              onPressed: () {
                final greetingCubit = context.read<GreetingCubit>();
                greetingCubit.resetCouting();
              },
              child: const Text('Zerar contagem'),
            ),
          ],
        ),
      ),
    );
  }
}

class TextMessage extends StatelessWidget {
  const TextMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GreetingCubit, GreetingState>(
      builder: (context, state) {
        String message = '';

        if (state is GreetingInitial) {
          message = 'Bem vindo!';
        } else if (state is GreetingSecondTime) {
          message = 'É seu segundo acesso!';
        } else if (state is GreetingThirdTime) {
          message = 'É seu terceiro acesso!';
        } else {
          message = 'Bem vindo novamente!';
        }

        return Text(
          message,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        );
      },
    );
  }
}
