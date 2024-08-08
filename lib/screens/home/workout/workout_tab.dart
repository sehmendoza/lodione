import 'package:flutter/material.dart';

import 'add_exercise.dart';

class WorkoutTab extends StatefulWidget {
  const WorkoutTab({super.key});

  @override
  State<WorkoutTab> createState() => _WorkoutTabState();
}

class _WorkoutTabState extends State<WorkoutTab> {
  final List<WorkoutModel> plans = [
    WorkoutModel(
      name: 'Sunday',
      exercises: [
        ExerciseModel(
          name: 'Bench Press',
          weight: 420,
          sets: 3,
          reps: 10,
          isDone: false,
        ),
        ExerciseModel(
          name: 'Push up',
          weight: 0,
          sets: 3,
          reps: 10,
          isDone: false,
        ),
        ExerciseModel(
          name: 'Squats',
          weight: 420,
          sets: 3,
          reps: 10,
          isDone: false,
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
          isDone: false,
        ),
        ExerciseModel(
          name: 'Push up',
          weight: 0,
          sets: 3,
          reps: 10,
          isDone: false,
        ),
        ExerciseModel(
          name: 'Squats',
          weight: 420,
          sets: 3,
          reps: 10,
          isDone: false,
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
          isDone: false,
        ),
        ExerciseModel(
          name: 'Push up',
          weight: 0,
          sets: 3,
          reps: 10,
          isDone: false,
        ),
        ExerciseModel(
          name: 'Squats',
          weight: 420,
          sets: 3,
          reps: 10,
          isDone: false,
        ),
      ],
    ),
    WorkoutModel(
      name: 'Wednesday',
      exercises: [
        ExerciseModel(
          name: 'Bench Press',
          weight: 420,
          isDone: false,
          sets: 3,
          reps: 10,
        ),
        ExerciseModel(
          name: 'Push up',
          weight: 0,
          isDone: false,
          sets: 3,
          reps: 10,
        ),
        ExerciseModel(
          name: 'Squats',
          weight: 420,
          isDone: false,
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
          isDone: false,
          sets: 3,
          reps: 10,
        ),
        ExerciseModel(
          name: 'Push up',
          weight: 0,
          sets: 3,
          reps: 10,
          isDone: false,
        ),
        ExerciseModel(
          name: 'Squats',
          weight: 420,
          isDone: false,
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
          isDone: false,
        ),
        ExerciseModel(
          name: 'Push up',
          weight: 0,
          sets: 3,
          reps: 10,
          isDone: false,
        ),
        ExerciseModel(
          name: 'Squats',
          weight: 420,
          sets: 3,
          reps: 10,
          isDone: false,
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
          isDone: false,
        ),
        ExerciseModel(
          name: 'Push up',
          weight: 0,
          sets: 3,
          reps: 10,
          isDone: false,
        ),
        ExerciseModel(
          name: 'Squats',
          weight: 420,
          sets: 3,
          reps: 10,
          isDone: false,
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
                        (exercise) {
                          return ExerciseTile(exercise: exercise);
                        },
                      ),
                      TextButton.icon(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AddExercise()));
                        },
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white60,
                        ),
                        label: const Text(
                          'Add exercise',
                          style: TextStyle(
                            color: Colors.white60,
                          ),
                        ),
                      ),
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

class ExerciseTile extends StatefulWidget {
  const ExerciseTile({super.key, required this.exercise});
  final ExerciseModel exercise;
  @override
  State<ExerciseTile> createState() => _ExerciseTileState();
}

class _ExerciseTileState extends State<ExerciseTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        onChanged: (value) {
          setState(() {
            widget.exercise.isDone = !widget.exercise.isDone;
          });
        },
        value: widget.exercise.isDone,
      ),
      title: Text(
        widget.exercise.name,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      subtitle: Text("${widget.exercise.sets} x ${widget.exercise.reps}"),
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
  bool isDone;

  ExerciseModel(
      {required this.name,
      required this.weight,
      required this.sets,
      required this.reps,
      required this.isDone});
}
