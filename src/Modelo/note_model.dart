import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Note {
  String title;
  String content;
  Color color;

  Note({
    required this.title,
    required this.content,
    required this.color,
  });

  final instance = Supabase.instance.client;

  getNotes() async {
    final response = await instance.from('notes').select('*');

    print(response);
  }
}
