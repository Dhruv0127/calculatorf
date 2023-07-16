import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final box = Hive.box('history');

    void clearHiveData() async {
      await box.clear();
    }

    void removeHistory(int index) {
      box.deleteAt(index);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        actions: [
          ElevatedButton(
              onPressed: () => clearHiveData(), child: const Text("clear all")),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: ValueListenableBuilder<Box<dynamic>>(
        valueListenable: box.listenable(),
        builder: (context, box, child) {
          if (box.isEmpty) {
            return const Center(
              child: Text('Empty History'),
            );
          }

          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final equation = box.getAt(index);
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 135, 160, 183),
                      borderRadius: BorderRadius.circular(20)),
                  child: Dismissible(
                    key: Key('$equation'),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    onDismissed: (_) => removeHistory(index),
                    child: ListTile(
                      title: Text('$equation'),
                      trailing: IconButton(
                        onPressed: () => removeHistory(index),
                        icon: const Icon(
                          Icons.delete,
                          color: Color.fromARGB(255, 138, 15, 6),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
