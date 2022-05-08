void main() {

  print(DateTime.now().millisecondsSinceEpoch);
  List<int> numList = [5, 7, 6, 4, 2, 1];
  numList.sort((b, a) => a.compareTo(b));
  print(numList);
}