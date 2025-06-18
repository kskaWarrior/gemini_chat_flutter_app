import 'package:flutter/material.dart';
import 'package:gemini_chat_flutter_app/message.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  final List<Message> _messages = [
    Message(text: 'Hello, how can I help you?', isUser: false),
    Message(text: 'I need assistance with my account.', isUser: true),
    Message(text: 'Sure, I can help with that.', isUser: false),
    Message(text: 'Thank you!', isUser: true),
  ];

  bool _isDarkMode = false; // Add this line

  @override
  Widget build(BuildContext context) {
    return MaterialApp( // Wrap with MaterialApp to control theme
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.primary,
          toolbarHeight: 80, // Increase the AppBar height
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/google_gemini_logo.png',
                height: 40,
              ),
              const SizedBox(height: 4),
              const Text('Chat App', style: TextStyle(fontSize: 16)),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Material(
                color: Colors.transparent,
                elevation: 6,
                shape: const CircleBorder(),
                shadowColor: Colors.black54,
                child: Ink(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _isDarkMode
                        ? Colors.grey[800]
                        : Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: IconButton(
                    iconSize: 25,
                    icon: Icon(
                      _isDarkMode ? Icons.light_mode : Icons.dark_mode,
                      color: _isDarkMode ? Colors.yellow[600] : Colors.blueGrey[900],
                    ),
                    tooltip: 'Toggle Theme',
                    onPressed: () {
                      setState(() {
                        _isDarkMode = !_isDarkMode;
                      });
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 7.0, bottom: 7.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final message = _messages[index];
                    return ListTile(
                      title: Align(
                        alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: message.isUser ? Colors.blue : Colors.grey[200],
                            borderRadius: message.isUser
                                ? const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                    bottomLeft: Radius.circular(20),
                                  )
                                : const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                  ),
                          ),
                          child: Text(
                            message.text,
                            style: TextStyle(
                              color: message.isUser ? Colors.white : Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          hintText: 'Type your message here...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        ),
                        onSubmitted: (text) {
                          if (text.isNotEmpty) {
                            setState(() {
                              _messages.add(Message(text: text, isUser: true));
                            });
                            _controller.clear();
                          }
                        },
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send),
                      color: Theme.of(context).colorScheme.primary,
                      onPressed: () {
                        final text = _controller.text.trim();
                        if (text.isNotEmpty) {
                          setState(() {
                            _messages.add(Message(text: text, isUser: true));
                          });
                          _controller.clear();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}