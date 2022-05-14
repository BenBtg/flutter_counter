import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final counterProvider = StateProvider<int>((ref) => 0);

class CounterBody extends StatelessWidget {
  const CounterBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text('Current counter value:'),
          Counter(),
        ],
      ),
    );
  }
}

class Counter extends ConsumerWidget {
  const Counter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RepaintBoundary(
      child: Text(
        '${ref.watch(counterProvider)}',
        style: Theme.of(context).textTheme.headline4,
      ),
    );
  }
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.read(counterProvider.notifier);
    return MaterialApp(
      home: Scaffold(
        appBar:
            AppBar(title: const Text('Riverpod Counter using StateProvider')),
        body: const CounterBody(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => counter.state++,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

void main() {
  runApp(const ProviderScope(child: MyApp()));
}
