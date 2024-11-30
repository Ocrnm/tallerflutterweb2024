import 'dart:js_interop';

import 'package:flutter/cupertino.dart';
import '../Controlador/note_controller.dart';
import 'package:flutter/material.dart';
import '../widgets/note_card.dart';

class LandingView extends StatefulWidget {
  const LandingView({super.key});

  @override
  State<LandingView> createState() => _LandingViewState();
}

class _LandingViewState extends State<LandingView> {
  bool isOpen = false; // Estado para abrir/cerrar la barra lateral
  List<Map<String, String>> notes = [];

  void addNote() {
    setState(() {
      notes.add({'title': 'Nueva Nota', 'content': 'Contenido de la nueva nota'});
    });
  }

  void editNote(int index, String newTitle, String newContent) {
    setState(() {
      notes[index] = {'title': newTitle, 'content': newContent};
    });
  }

  void deleteNote(int index) {
    setState(() {
      notes.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF10E37A),
      body: Row(
        children: [
          // Barra lateral
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: isOpen ? 210 : 60,
            decoration: const BoxDecoration(
              border: Border(
                right: BorderSide(color: Colors.black, width: 0.5),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 60,
                  width: 60,
                  child: IconButton(
                    icon: Icon(isOpen ? Icons.arrow_back : Icons.menu),
                    color: Colors.grey[800],
                    onPressed: () {
                      setState(() {
                        isOpen = !isOpen;
                      });

                      NoteController().getNotes();
                    },
                  ),
                ),
                const SizedBox(height: 20),
                _buildMenuItem(
                  Icons.folder,
                  "Proyectos",
                ),
                _buildMenuItem(
                  Icons.draw_rounded,
                  "Dibujos",
                ),
                _buildMenuItem(
                  Icons.people,
                  "Compartido conmigo",
                ),
                const Spacer(),
                _buildMenuItem(
                  Icons.settings,
                  "Configuración",
                ),
              ],
            ),
          ),
          // Contenido principal
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Text(
                        'Mis Notas',
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 20),
                      Icon(
                        Icons.keyboard_arrow_down,
                        size: 30,
                      ),
                      Spacer(),
                      Icon(
                        Icons.link,
                        size: 30,
                      ),
                      SizedBox(width: 20),
                      Text(
                        'Share',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 20),
                      Icon(
                        Icons.more_horiz,
                        size: 30,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: notes.length,
                      itemBuilder: (context, index) {
                        final note = notes[index];
                        return NoteCard(
                          title: note['title']!,
                          content: note['content']!,
                          onEdit: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                final titleController = TextEditingController(text: note['title']);
                                final contentController = TextEditingController(text: note['content']);
                                return AlertDialog(
                                  title: const Text('Editar Nota'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextField(
                                        controller: titleController,
                                        decoration: const InputDecoration(labelText: 'Título'),
                                      ),
                                      TextField(
                                        controller: contentController,
                                        decoration: const InputDecoration(labelText: 'Contenido'),
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        editNote(
                                          index,
                                          titleController.text,
                                          contentController.text,
                                        );
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Guardar'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          onDelete: () {
                            deleteNote(index);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addNote,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: InkWell(
        onTap: () {},
        child: SizedBox(
          width: isOpen ? 210 : 60,
          child: Row(
            children: [
              SizedBox(
                width: 60,
                height: 60,
                child: Icon(icon, color: Colors.grey[800], size: 24),
              ),
              if (isOpen) ...[
                const SizedBox(width: 10),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}