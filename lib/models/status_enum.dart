
enum TodoStatus { none, inComplete, complete, edit, delete }

extension TodoStatusExtension on TodoStatus {
  static const values = [0, 1, 2, 3, 4];
  int get value => values[index];
}
