import 'dart:convert';
import 'dart:io';
import 'dart:ffi';
import 'dart:async'; // to import Timer()
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Events {
  int id, type, currency_type, creator;
  Float price;
  String location, file, title, description, start_at, end_at;
  Events(
      this.id,
      this.type,
      this.currency_type,
      this.creator,
      this.price,
      this.location,
      this.file,
      this.title,
      this.description,
      this.start_at,
      this.end_at);
}

Future<int> _createEvent(Events eventInstance) async {
  // writing "ip_address" at the place of domain as because there is no domain/ip of api provided in instructions.
  final url = 'https://ip_address/v1/event/updateEvent';
  try {
    final response = await http.post(url,
        body: json.encode({
          "id": eventInstance.id,
          "type": eventInstance.type,
          "currency_type": eventInstance.currency_type,
          "creator": eventInstance.creator,
          "price": eventInstance.price,
          "location": eventInstance.location,
          "file": eventInstance.file,
          "title": eventInstance.title,
          "description": eventInstance.description,
          "start_at": eventInstance.start_at,
          "end_a": eventInstance.end_at
        }));

    final responseData = json.decode(response.body);
    return responseData['status'];
  } catch (error) {
    throw error;
  }
}

Future<Events> _getEvent(String location) async {
  // writing "ip_address" at the place of domain as because there is no domain/ip of api provided in instructions.
  final url = 'https://ip_address/v1/event/getEvents';
  try {
    final response = await http.get(url + "?location=$location");

    final responseData = json.decode(response.body);
    final event = responseData['events'];
    return Events(
        event['id'],
        event['type'],
        event['currency_type'],
        event['creator'],
        event['price'],
        event['location'],
        event['file'],
        event['title'],
        event['description'],
        event['start_at'],
        event['end_at']);
  } catch (error) {
    throw error;
  }
}

Future<Events> _purchaseEventTicket(int eventID, int userID) async {
  // writing "ip_address" at the place of domain as because there is no domain/ip of api provided in instructions.
  final url = 'https://ip_address/v1/event/purchaseEventTicket';
  try {
    final response = await http.get(url + "?event_id=$eventID&user_id=$userID");

    final responseData = json.decode(response.body);
    return responseData['status'];
  } catch (error) {
    throw error;
  }
}

Future<String> uploadImage(filename) async {
  var request = http.MultipartRequest('POST', Uri.parse(""));
  request.files.add(await http.MultipartFile.fromPath('picture', filename));
  var res = await request.send();
  return res.reasonPhrase;
}
