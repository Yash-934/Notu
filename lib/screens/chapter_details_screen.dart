
import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:notu/models/chapter.dart';
import 'package:notu/utils/database_helper.dart';

class ChapterDetailsScreen extends StatefulWidget {
  final Chapter chapter;
  final Function(Chapter) onChapterUpdate;

  const ChapterDetailsScreen({super.key, required this.chapter, required this.onChapterUpdate});

  @override
  State<ChapterDetailsScreen> createState() => _ChapterDetailsScreenState();
}

class _ChapterDetailsScreenState extends State<ChapterDetailsScreen> {
  bool _isEditing = false;
  late TextEditingController _contentController;
  late WebViewController _webViewController;
  final dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _contentController = TextEditingController(text: widget.chapter.content);
    if (widget.chapter.contentType == ContentType.html) {
      _webViewController = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..loadHtmlString(widget.chapter.content);
    }
  }

  void _toggleEditing() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _saveChapter() async {
    final updatedChapter = Chapter(
      id: widget.chapter.id,
      bookId: widget.chapter.bookId,
      title: widget.chapter.title,
      content: _contentController.text,
      contentType: widget.chapter.contentType,
    );
    await dbHelper.updateChapter(updatedChapter);
    widget.onChapterUpdate(updatedChapter);

    if (widget.chapter.contentType == ContentType.html) {
      _webViewController.loadHtmlString(updatedChapter.content);
    }
    _toggleEditing();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chapter.title),
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.save : Icons.edit),
            onPressed: _isEditing ? _saveChapter : _toggleEditing,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isEditing
            ? TextField(
                controller: _contentController,
                maxLines: null,
                expands: true,
                decoration: InputDecoration(
                  hintText: 'Write your notes here...',
                  border: InputBorder.none,
                ),
              )
            : (widget.chapter.contentType == ContentType.markdown
                ? Markdown(
                    data: _contentController.text,
                    styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
                      p: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 16),
                      h1: Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 32),
                      h2: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 24),
                    ),
                  )
                : WebViewWidget(controller: _webViewController)),
      ),
    );
  }
}
