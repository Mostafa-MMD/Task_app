import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/cubit/main_cubit.dart';
import 'package:task_app/cubit/states.dart';

import 'components/goal_item.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainCubit()
        ..initSql()
        ..getData(),
      child: BlocConsumer<MainCubit, MainStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue[900],
              title: const Text(
                'TASKS',
                style: TextStyle(
                  letterSpacing: 4.0,
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                ),
              ),
              centerTitle: true,
            ),
            body: ListView.builder(
              itemCount: MainCubit.get(context).gaolsList.length,
              itemBuilder: (context, index) => goalItem(
                context,
                MainCubit.get(context).gaolsList[index]['id'],
                MainCubit.get(context).gaolsList[index]['name'],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.teal,
              child: const Icon(
                Icons.add,
                size: 40.0,
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    content: Container(
                      height: 135.0,
                      child: Column(
                        children: [
                          Container(
                            color: Colors.blue[900],
                            height: 30.0,
                            child: const Center(
                              child: Text(
                                'Write your task',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          TextFormField(
                            controller:
                                MainCubit.get(context).addTextController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              label: const Text('write here ...'),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(3.0),
                              ),
                              contentPadding: const EdgeInsets.all(7.0),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    MainCubit.get(context).insertData(
                                      MainCubit.get(context)
                                          .addTextController
                                          .text
                                          .toString(),
                                    );
                                    MainCubit.get(context)
                                        .addTextController
                                        .text = '';
                                    MainCubit.get(context).getData();
                                    Navigator.pop(context);
                                  },
                                  child: const Text('ADD'),
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.green[700]),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5.0,
                              ),
                              Expanded(
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.red),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Close'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
