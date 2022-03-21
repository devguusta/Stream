import 'dart:async';

void main() async {
  final streamController = StreamController(
    onPause: () => print('Paused'),
    onResume: () => print('Resumed'),
    onCancel: () => print('Cancelled'),
    onListen: () => print('Listens'),
  );

  streamController.stream.listen(
    (event) => print('Event: $event'),
    onDone: () => print('Done'),
    onError: (error) => print(error),
  );
  streamController.add(999);
  final stream = Stream<int>.periodic(
      const Duration(milliseconds: 200), (count) => count * count).take(4);

  Stream<int> values = stream.map((event) {
    if (event > 4)
      throw Exception('Value $event is greater than 4');
    else {
      return event;
    }
  });

  await streamController.addStream(values);
  streamController.addError(Exception('olá'));
}
