import 'package:flutter/material.dart';
import '../../cubit/main_cubit.dart';

Widget goalItem(
  context,
  id,
  goalName,
) =>
    InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            content: Container(
              height: 85.0,
              child: Column(
                children: [
                  Container(
                    color: Colors.blue[900],
                    height: 30.0,
                    child: const Center(
                      child: Text(
                        'do you want remove ... !',
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
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            MainCubit.get(context).removeData(id);
                            MainCubit.get(context).getData();
                            Navigator.pop(context);
                          },
                          child: const Text('Remove'),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.orange),
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
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 5.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              blurRadius: 5.0,
              offset: Offset(0, 2),
            ),
          ],
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            colors: [
              Colors.blue,
              Colors.blue[900]!,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text(
                '$goalName',
                style: const TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
