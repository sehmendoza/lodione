import 'package:flutter/material.dart';

class WorkoutTab extends StatelessWidget {
  WorkoutTab({super.key});

  final List<WorkoutModel> plans = [
    WorkoutModel(
      name: 'Sunday',
      exercises: [
        ExerciseModel(
          name: 'Bench Press',
          weight: 420,
          sets: 3,
          reps: 10,
        ),
        ExerciseModel(
          name: 'Push up',
          weight: 0,
          sets: 3,
          reps: 10,
        ),
        ExerciseModel(
          name: 'Squats',
          weight: 420,
          sets: 3,
          reps: 10,
        ),
      ],
    ),
    WorkoutModel(
      name: 'Monday',
      exercises: [
        ExerciseModel(
          name: 'Bench Press',
          weight: 420,
          sets: 3,
          reps: 10,
        ),
        ExerciseModel(
          name: 'Push up',
          weight: 0,
          sets: 3,
          reps: 10,
        ),
        ExerciseModel(
          name: 'Squats',
          weight: 420,
          sets: 3,
          reps: 10,
        ),
      ],
    ),
    WorkoutModel(
      name: 'Tuesday',
      exercises: [
        ExerciseModel(
          name: 'Bench Press',
          weight: 420,
          sets: 3,
          reps: 10,
        ),
        ExerciseModel(
          name: 'Push up',
          weight: 0,
          sets: 3,
          reps: 10,
        ),
        ExerciseModel(
          name: 'Squats',
          weight: 420,
          sets: 3,
          reps: 10,
        ),
      ],
    ),
    WorkoutModel(
      name: 'Wednesday',
      exercises: [
        ExerciseModel(
          name: 'Bench Press',
          weight: 420,
          sets: 3,
          reps: 10,
        ),
        ExerciseModel(
          name: 'Push up',
          weight: 0,
          sets: 3,
          reps: 10,
        ),
        ExerciseModel(
          name: 'Squats',
          weight: 420,
          sets: 3,
          reps: 10,
        ),
      ],
    ),
    WorkoutModel(
      name: 'Thursday',
      exercises: [
        ExerciseModel(
          name: 'Bench Press',
          weight: 420,
          sets: 3,
          reps: 10,
        ),
        ExerciseModel(
          name: 'Push up',
          weight: 0,
          sets: 3,
          reps: 10,
        ),
        ExerciseModel(
          name: 'Squats',
          weight: 420,
          sets: 3,
          reps: 10,
        ),
      ],
    ),
    WorkoutModel(
      name: 'Friday',
      exercises: [
        ExerciseModel(
          name: 'Bench Press',
          weight: 420,
          sets: 3,
          reps: 10,
        ),
        ExerciseModel(
          name: 'Push up',
          weight: 0,
          sets: 3,
          reps: 10,
        ),
        ExerciseModel(
          name: 'Squats',
          weight: 420,
          sets: 3,
          reps: 10,
        ),
      ],
    ),
    WorkoutModel(
      name: 'Saturday',
      exercises: [
        ExerciseModel(
          name: 'Bench Press',
          weight: 420,
          sets: 3,
          reps: 10,
        ),
        ExerciseModel(
          name: 'Push up',
          weight: 0,
          sets: 3,
          reps: 10,
        ),
        ExerciseModel(
          name: 'Squats',
          weight: 420,
          sets: 3,
          reps: 10,
        ),
      ],
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(8.0),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                var plan = plans[index];
                return Padding(
                  padding: const EdgeInsets.only(
                    left: 5,
                    right: 5,
                    top: 4,
                    bottom: 5,
                  ),
                  child: ExpansionTile(
                    collapsedShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: const BorderSide(
                          color: Colors.white,
                        )),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: const BorderSide(
                          color: Colors.white,
                          width: 2,
                        )),
                    leading: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '15',
                          style: TextStyle(
                            fontSize: 21,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Jan',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                    title: Text(
                      plan.name,
                      style: const TextStyle(color: Colors.white, fontSize: 24),
                    ),
                    children: [
                      ...plan.exercises.map(
                        (exercise) => ListTile(
                          leading: Checkbox(
                            onChanged: (value) {},
                            value: false,
                          ),
                          title: Text(
                            exercise.name,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          subtitle: Text("${exercise.sets} x ${exercise.reps}"),
                        ),
                      )
                    ],
                  ),
                );
              },
              childCount: plans.length,
            ),
          ),
        ),
      ],
    );
  }
}

class WorkoutModel {
  String name;
  List<ExerciseModel> exercises;

  WorkoutModel({required this.name, required this.exercises});
}

class ExerciseModel {
  String name;
  double weight;
  int sets;
  int reps;

  ExerciseModel(
      {required this.name,
      required this.weight,
      required this.sets,
      required this.reps});
}
