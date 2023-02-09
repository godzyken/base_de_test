import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:http/http.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/data/entity/counter_increment.dart';

class ConnectToHttp implements Client {
  final Client client;

  late CounterIncrement counter;

  Future<void>? total;

  ConnectToHttp({required this.client});

  Future<void> update() async {
    total ??= doUpdate();
    await total;
    total = null;
  }

  Future<void> doUpdate() async {
    var uri = Uri.parse('http://127.0.0.1:9100/counter/1');
    var rs = await client.get(uri);
    var data = jsonDecode(rs.body);
    var value = int.parse(data['0']);
    counter.count == value;
  }

  Future<CounterIncrement> fetchCounter(Client client) async {
    final response =
        await client.get(Uri.parse('http://127.0.0.1:9100/counter/1'));

    try {
      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        return CounterIncrement.fromJson(jsonDecode(response.body));
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        return throw Exception('Failed to load album');
      }
    } on ClientException catch (e) {
      // TODO
      log(e.message);
      return const CounterIncrement(value: 0);
    }
  }

  @override
  void close() {
    // TODO: implement close
  }

  @override
  Future<Response> delete(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Response> get(Uri url, {Map<String, String>? headers}) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<Response> head(Uri url, {Map<String, String>? headers}) {
    // TODO: implement head
    throw UnimplementedError();
  }

  @override
  Future<Response> patch(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    // TODO: implement patch
    throw UnimplementedError();
  }

  @override
  Future<Response> post(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    // TODO: implement post
    throw UnimplementedError();
  }

  @override
  Future<Response> put(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    // TODO: implement put
    throw UnimplementedError();
  }

  @override
  Future<String> read(Uri url, {Map<String, String>? headers}) {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  Future<Uint8List> readBytes(Uri url, {Map<String, String>? headers}) {
    // TODO: implement readBytes
    throw UnimplementedError();
  }

  @override
  Future<StreamedResponse> send(BaseRequest request) {
    // TODO: implement send
    throw UnimplementedError();
  }
}

final connectToHttpProvider = Provider((ref) async {
  final client = ref.read(clientProvider);
  final connect = ConnectToHttp(client: client);
  return connect;
});

final clientProvider =
    Provider<Client>((ref) => ConnectToHttp(client: ref.watch(dioProvider)));

final dioProvider = Provider((ref) => Client());
