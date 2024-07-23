import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final List<Map<String, String>> _messages = [];
  final TextEditingController _controller = TextEditingController();
  late AnimationController _animationController;
  late AnimationController _rainAnimationController;
  late Timer _colorChangeTimer;
  final List<Raindrop> _raindrops = [];
  final Random _random = Random();
  bool _isRaindropsGenerated = false;
  Color _currentColor = Colors.blue;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _rainAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 16),
    )..addListener(() {
      _updateRaindrops();
    });
    _rainAnimationController.repeat();

    _colorChangeTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        _currentColor = Color.fromRGBO(
          _random.nextInt(256),
          _random.nextInt(256),
          _random.nextInt(256),
          1,
        );
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationController.dispose();
    _rainAnimationController.dispose();
    _colorChangeTimer.cancel();
    super.dispose();
  }

  void _generateRaindrops(double screenWidth, double screenHeight) {
    for (int i = 0; i < 100; i++) {
      _raindrops.add(Raindrop(
        _random.nextDouble() * screenWidth,
        _random.nextDouble() * screenHeight,
        _random.nextDouble() * 10 + 5, // Radius of the bubble
        _random.nextDouble() * 4 + 2,
      ));
    }
  }

  void _updateRaindrops() {
    for (var raindrop in _raindrops) {
      raindrop.fall();
      if (raindrop.isOffScreen(MediaQuery.of(context).size.height)) {
        raindrop.y = 0;
        raindrop.x = _random.nextDouble() * MediaQuery.of(context).size.width;
      }
    }
    setState(() {});
  }

  void _sendMessage() {
    if (_controller.text.isEmpty) return;
    setState(() {
      _messages.add({'text': _controller.text, 'sender': 'user'});
      _messages.add({'text': 'Echo: ${_controller.text}', 'sender': 'bot'});
    });
    _controller.clear();
    _animationController.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    if (!_isRaindropsGenerated) {
      _generateRaindrops(screenWidth, screenHeight);
      _isRaindropsGenerated = true;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chatbot UI'),
        backgroundColor: Colors.teal,
      ),
      body: Stack(
        children: [
          CustomPaint(
            painter: RainPainter(_raindrops, screenHeight, _currentColor),
            child: Container(),
          ),
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    return ChatBubble(
                      message: _messages[index]['text']!,
                      isUser: _messages[index]['sender'] == 'user',
                      animationController: _animationController,
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          hintText: 'Type a message',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send),
                      color: Colors.teal,
                      onPressed: _sendMessage,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isUser;
  final AnimationController animationController;

  const ChatBubble({
    required this.message,
    required this.isUser,
    required this.animationController,
  });

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: CurvedAnimation(
        parent: animationController,
        curve: Curves.easeOut,
      ),
      axisAlignment: 0.0,
      child: Align(
        alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isUser ? Colors.deepPurple : Colors.grey[300],
            borderRadius: BorderRadius.only(
              topLeft: isUser ? const Radius.circular(10) : const Radius.circular(0),
              topRight: const Radius.circular(10),
              bottomLeft: const Radius.circular(10),
              bottomRight: isUser ? const Radius.circular(0) : const Radius.circular(10),
            ),
          ),
          child: Text(
            message,
            style: TextStyle(color: isUser ? Colors.white : Colors.black),
          ),
        ),
      ),
    );
  }
}

class Raindrop {
  double x;
  double y;
  double radius;
  double velocity;

  Raindrop(this.x, this.y, this.radius, this.velocity);

  void fall() {
    y += velocity;
  }

  bool isOffScreen(double screenHeight) {
    return y - radius > screenHeight;
  }
}

class RainPainter extends CustomPainter {
  final List<Raindrop> raindrops;
  final double screenHeight;
  final Color color;

  RainPainter(this.raindrops, this.screenHeight, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    for (var raindrop in raindrops) {
      canvas.drawCircle(
        Offset(raindrop.x, raindrop.y),
        raindrop.radius,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
