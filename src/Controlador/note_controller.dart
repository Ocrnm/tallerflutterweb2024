import 'package:supabase_flutter/supabase_flutter.dart';

class NoteController {
  final instance = Supabase.instance.client;

  getNotes() async {
    final response = await instance.from('notes').select('*');

    print(response);
  }

  addNote() async {
    final response = await instance.from('notes').insert({
      'category': 1,
      'title': 'Nota de prueba',
      'content': 'Contenido de la nota de prueba',
      'status': 0,
    });

    print(response);
  }
}
