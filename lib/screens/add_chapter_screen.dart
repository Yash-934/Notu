
import 'package:flutter/material.dart';
import 'package:notu/models/chapter.dart';

class AddChapterScreen extends StatefulWidget {
  final int bookId;
  final Function(Chapter) onAddChapter;

  const AddChapterScreen({super.key, required this.bookId, required this.onAddChapter});

  @override
  State<AddChapterScreen> createState() => _AddChapterScreenState();
}

class _AddChapterScreenState extends State<AddChapterScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  ContentType _contentType = ContentType.markdown;

  void _saveChapter() {
    final title = _titleController.text;
    if (title.isNotEmpty) {
      final newChapter = Chapter(
        bookId: widget.bookId,
        title: title,
        content: _contentController.text,
        contentType: _contentType,
      );
      widget.onAddChapter(newChapter);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a New Chapter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Chapter Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            SegmentedButton<ContentType>(
              segments: const [
                ButtonSegment(value: ContentType.markdown, label: Text('Markdown')),
                ButtonSegment(value: ContentType.html, label: Text('HTML')),
              ],
              selected: {_contentType},
              onSelectionChanged: (newSelection) {
                setState(() {
                  _contentType = newSelection.first;
                });
              },
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(
                labelText: _contentType == ContentType.markdown ? 'Content (Markdown)' : 'Content (HTML/CSS/JS)',
                border: const OutlineInputBorder(),
              ),
              maxLines: 10,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _saveChapter,
              icon: const Icon(Icons.check),
              label: const Text('Save Chapter'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
