import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MockQuerySnapshot extends Mock implements QuerySnapshot {}

void main() {
  testWidgets('Chat list displays messages', (WidgetTester tester) async {
    // Create a mock QuerySnapshot with example message data
    final mockSnapshot = MockQuerySnapshot();
    when(mockSnapshot.docs).thenReturn([
      QueryDocumentSnapshot<Map<String, dynamic>>(
        data: {'text': 'Hello'},
        reference: DocumentReference(null, Firestore.instance),
      ),
      QueryDocumentSnapshot<Map<String, dynamic>>(
        data: {'text': 'Hi there'},
        reference: DocumentReference(null, Firestore.instance),
      ),
    ]);

    // Build the ChatMessages widget with the mock snapshot
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: ChatMessages(snapshot: mockSnapshot)),
      ),
    );

    // Verify if both messages are displayed
    expect(find.text('Hello'), findsOneWidget);
    expect(find.text('Hi there'), findsOneWidget);
  });
}

class ChatMessages extends StatelessWidget {
  final QuerySnapshot snapshot;

  ChatMessages({required this.snapshot});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: snapshot.docs.length,
      itemBuilder: (context, index) {
        final message = snapshot.docs[index]['text'];
        return ListTile(
          title: Text(message),
        );
      },
    );
  }
}
