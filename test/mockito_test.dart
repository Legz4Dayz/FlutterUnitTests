import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:mockito/mockito.dart';

import 'package:unit_testing_practice/main.dart';

import 'widget_test.dart';

/*
  From Example: https://flutter.dev/docs/cookbook/testing/unit/mocking
*/
void main() {
  group('fetchPost', () {
    test('returns a Post if http call completes successfully', () async {
      final client = MockClient();

      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client.get("https://jsonplaceholder.typicode.com/posts/1"))
          .thenAnswer((_) async => http.Response(' { "title": "Test" }', 200));

      var response = await fetchPost(client);

      expect(response, isA<Post>());
      print(response.data);
    });
  });
}

class Post {
  dynamic data;
  Post.fromJson(this.data);
}

class MockClient extends Mock implements http.Client {}

Future<Post> fetchPost(http.Client client) async {
  final response =
      await client.get('https://jsonplaceholder.typicode.com/posts/1');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    return Post.fromJson(jsonDecode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}
