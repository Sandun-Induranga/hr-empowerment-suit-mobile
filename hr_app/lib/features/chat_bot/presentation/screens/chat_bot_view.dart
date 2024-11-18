import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr_app/core/widgets/common_page_widgets/common_page_boiler_plate.dart';
import 'package:http/http.dart' as http;

import '../../../../core/constants/ApiConstants.dart';
import '../../../../core/constants/app_paddings.dart';
import '../../../../core/constants/color_codes.dart';
import '../../../../core/widgets/common_page_widgets/common_app_bar.dart';

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
  final ScrollController _scrollController = ScrollController();

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

  void _sendMessage() async {
    if (_controller.text.isEmpty) return;
    setState(() {
      _messages.add({'text': _controller.text, 'sender': 'user'});
    });
    Future.delayed(
        const Duration(milliseconds: 500), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController
              .position.maxScrollExtent,
          duration:
          const Duration(milliseconds: 10),
          curve: Curves.ease,
        );
      }
    });
    try {
      final response = await http
          .post(
            Uri.parse('$chatBotUrl/chat/'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              'msg': _controller.text,
            }),
          )
          .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final reply = jsonDecode(response.body)['reply'];
        setState(() {
          _messages.add({'text': 'Bot: $reply', 'sender': 'bot'});
        });
        Future.delayed(
            const Duration(milliseconds: 500), () {
          if (_scrollController.hasClients) {
            _scrollController.animateTo(
              _scrollController
                  .position.maxScrollExtent,
              duration:
              const Duration(milliseconds: 10),
              curve: Curves.ease,
            );
          }
        });
      } else {
        print('Failed to send message');
      }
    } on TimeoutException catch (e) {
      // Handle timeout exception
      setState(() {
        _messages.add({
          'text': 'Error: Request timed out. Please try again.',
          'sender': 'bot'
        });
      });
      Future.delayed(
          const Duration(milliseconds: 500), () {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController
                .position.maxScrollExtent,
            duration:
            const Duration(milliseconds: 10),
            curve: Curves.ease,
          );
        }
      });
    } catch (e) {
      print(e);
    }

    _controller.clear();
    _animationController.forward(from: 0.0);
    Future.delayed(
        const Duration(milliseconds: 500), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController
              .position.maxScrollExtent,
          duration:
          const Duration(milliseconds: 10),
          curve: Curves.ease,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    if (!_isRaindropsGenerated) {
      _generateRaindrops(screenWidth, screenHeight);
      _isRaindropsGenerated = true;
    }

    return CommonPageBoilerPlate(
      isNeedToApplySafeArea: false,
      appBarPreferredSize: 80.h,
      commonAppBar: CommonAppBar(
        titleWidget: const Text(
          'Chat Bot',
          style: TextStyle(fontSize: 24),
        ),
        leadingWidget: IconButton(
          icon: Padding(
            padding: EdgeInsets.all(16.r),
            child: Icon(
              Icons.arrow_back_ios,
              size: 30.r,
              color: ColorCodes.whiteColor,
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      pageBody: Stack(
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
                  controller: _scrollController,
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
                      child: TextFormField(
                        controller: _controller,
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: AppPaddings.p12.w,
                            vertical: 0,
                          ),
                          constraints: BoxConstraints(
                            minHeight: 50.h,
                          ),
                          filled: true,
                          fillColor: ColorCodes.primaryColor.withOpacity(0.2),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.r),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a message';
                          }
                          return null;
                        },
                      ),
                    ),
                    IconButton(
                      icon: Container(
                          padding: EdgeInsets.all(8.r),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorCodes.primaryColor.withOpacity(0.2),
                          ),
                          child: const Icon(Icons.rocket_launch)),
                      color: ColorCodes.primaryColor,
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
    super.key,
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
              topLeft:
                  isUser ? const Radius.circular(10) : const Radius.circular(0),
              topRight: const Radius.circular(10),
              bottomLeft: const Radius.circular(10),
              bottomRight:
                  isUser ? const Radius.circular(0) : const Radius.circular(10),
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
