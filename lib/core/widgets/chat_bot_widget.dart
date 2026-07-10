// lib/core/widgets/chat_bot_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChatBotWidget extends StatefulWidget {
  const ChatBotWidget({super.key});

  @override
  State<ChatBotWidget> createState() => _ChatBotWidgetState();
}

class _ChatBotWidgetState extends State<ChatBotWidget>
    with SingleTickerProviderStateMixin {
  bool _isOpen = false;
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];
  final ScrollController _scrollController = ScrollController();
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  // Chat bot responses
  final Map<String, String> _botResponses = {
    'hello':
        '👋 Hello! Welcome to GS World Center. How can I assist you today?',
    'hi': '👋 Hi there! Great to see you. What brings you here today?',
    'hey': '👋 Hey! How can I help you with your project?',
    'service':
        '💼 I offer premium software development services:\n\n• Flutter App Development\n• Full Stack Development\n• AI/ML Integration\n• UI/UX Design\n• Backend Development\n• Cloud Deployment\n\nWhat interests you?',
    'services':
        '💼 I offer premium software development services:\n\n• Flutter App Development\n• Full Stack Development\n• AI/ML Integration\n• UI/UX Design\n• Backend Development\n• Cloud Deployment\n\nWhat interests you?',
    'project':
        '📱 I\'ve built amazing projects including:\n• E-Commerce Apps\n• AI Chatbots\n• Task Management Systems\n• Social Media Platforms\n• Fitness Trackers\n• Food Delivery Apps\n\nCheck out my portfolio section!',
    'projects':
        '📱 I\'ve built amazing projects including:\n• E-Commerce Apps\n• AI Chatbots\n• Task Management Systems\n• Social Media Platforms\n• Fitness Trackers\n• Food Delivery Apps\n\nCheck out my portfolio section!',
    'price':
        '💰 I offer competitive pricing based on your project needs:\n\n• Fixed Price Projects: 2,000 - 20,000+\n• Hourly Rates: 30 - 80/hour\n• Retainer Packages: Custom quotes\n\nLet\'s discuss your budget!',
    'pricing':
        '💰 I offer competitive pricing based on your project needs:\n\n• Fixed Price Projects: 2,000 - 20,000+\n• Hourly Rates: 30 - 80/hour\n• Retainer Packages: Custom quotes\n\nLet\'s discuss your budget!',
    'cost':
        '💰 I offer competitive pricing based on your project needs:\n\n• Fixed Price Projects: 2,000 - 20,000+\n• Hourly Rates: 30 - 80/hour\n• Retainer Packages: Custom quotes\n\nLet\'s discuss your budget!',
    'contact':
        '📞 You can reach me through:\n\n📧 Email: gaurav@gsworldcenter.com\n📱 Phone: +91 9876543210\n💬 WhatsApp: +91 9876543210\n🔗 LinkedIn: linkedin.com/in/gaurav\n🐙 GitHub: github.com/gaurav\n\nI\'ll respond within 24 hours!',
    'hire':
        '✅ Yes! I\'m available for hire. I offer:\n\n• Full-time Development\n• Freelance Projects\n• Contract Work\n• Consultation\n• Team Training\n\nLet\'s build something amazing together!',
    'available':
        '✅ Yes! I\'m available for hire. I offer:\n\n• Full-time Development\n• Freelance Projects\n• Contract Work\n• Consultation\n• Team Training\n\nLet\'s build something amazing together!',
    'work':
        '✅ Yes! I\'m available for hire. I offer:\n\n• Full-time Development\n• Freelance Projects\n• Contract Work\n• Consultation\n• Team Training\n\nLet\'s build something amazing together!',
    'thank':
        '🙏 You\'re welcome! Feel free to ask if you have more questions. Have a great day!',
    'thanks':
        '🙏 You\'re welcome! Feel free to ask if you have more questions. Have a great day!',
    'flutter':
        '🚀 I\'m a Flutter expert with 5+ years of experience. I can help you with:\n\n• Cross-platform apps\n• Custom UI/UX\n• Performance optimization\n• State management (Provider, Riverpod, Bloc)\n• Firebase integration\n\nLet\'s build your Flutter app!',
    'react':
        '⚛️ I work with React and Next.js for web development. I can help you with:\n\n• Modern web apps\n• Server-side rendering\n• API integration\n• Performance optimization\n• SEO optimization',
    'ai':
        '🤖 I\'m an AI enthusiast! I can help you with:\n\n• AI/ML integration\n• Chatbot development\n• Natural Language Processing\n• Computer Vision\n• Predictive Analytics\n\nLet\'s add AI to your project!',
    'fastapi':
        '⚡ I\'m a FastAPI expert! I can help you with:\n\n• High-performance APIs\n• Async/await patterns\n• Database integration\n• Authentication\n• API documentation\n\nLet\'s build blazing fast APIs!',
    'python':
        '🐍 I\'m a Python developer with expertise in:\n\n• Web development\n• Data analysis\n• Machine Learning\n• Automation\n• API development\n\nLet\'s build something with Python!',
    'ui':
        '🎨 I\'m a UI/UX designer! I can help you with:\n\n• User research\n• Wireframing\n• Prototyping\n• Visual design\n• User testing\n• Design systems\n\nLet\'s create beautiful designs!',
    'ux':
        '🎨 I\'m a UI/UX designer! I can help you with:\n\n• User research\n• Wireframing\n• Prototyping\n• Visual design\n• User testing\n• Design systems\n\nLet\'s create beautiful designs!',
    'design':
        '🎨 I\'m a UI/UX designer! I can help you with:\n\n• User research\n• Wireframing\n• Prototyping\n• Visual design\n• User testing\n• Design systems\n\nLet\'s create beautiful designs!',
    'help':
        '🤔 I\'m here to help! You can ask me about:\n\n• Services I offer\n• My projects\n• Pricing\n• Availability\n• Contact information\n• Technologies I use\n\nWhat would you like to know?',
  };

  final List<Map<String, String>> _quickReplies = [
    {'label': '👋 Hello', 'reply': 'hello'},
    {'label': '💼 Services', 'reply': 'services'},
    {'label': '📱 Projects', 'reply': 'projects'},
    {'label': '💰 Pricing', 'reply': 'pricing'},
    {'label': '📞 Contact', 'reply': 'contact'},
    {'label': '💼 Hire Me', 'reply': 'hire'},
    {'label': '🚀 Flutter', 'reply': 'flutter'},
    {'label': '🤖 AI', 'reply': 'ai'},
    {'label': '⚡ FastAPI', 'reply': 'fastapi'},
    {'label': '🎨 Design', 'reply': 'design'},
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scaleAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _toggleChat() {
    setState(() {
      _isOpen = !_isOpen;
      if (_isOpen) {
        _animationController.forward();
        if (_messages.isEmpty) {
          _addBotMessage(
              '👋 Hi there! I\'m your AI assistant. How can I help you today?');
        }
      } else {
        _animationController.reverse();
      }
    });
  }

  void _addBotMessage(String text) {
    setState(() {
      _messages.add({
        'sender': 'bot',
        'text': text,
        'timestamp': DateTime.now(),
      });
    });
    _scrollToBottom();
  }

  void _addUserMessage(String text) {
    setState(() {
      _messages.add({
        'sender': 'user',
        'text': text,
        'timestamp': DateTime.now(),
      });
    });
    _messageController.clear();
    _scrollToBottom();
  }

  void _sendMessage(String message) {
    if (message.trim().isEmpty) return;

    // Add user message
    _addUserMessage(message);

    // Show typing indicator
    setState(() {
      _messages.add({
        'sender': 'typing',
        'text': '...',
      });
    });
    _scrollToBottom();

    // Get bot response
    Future.delayed(Duration(milliseconds: 800 + Random().nextInt(500)), () {
      setState(() {
        // Remove typing indicator
        _messages.removeWhere((msg) => msg['sender'] == 'typing');
      });

      final response = _getBotResponse(message);
      _addBotMessage(response);
    });
  }

  String _getBotResponse(String message) {
    final lowerMsg = message.toLowerCase().trim();

    // Check for exact matches first
    for (var entry in _botResponses.entries) {
      if (lowerMsg.contains(entry.key)) {
        return entry.value;
      }
    }

    // Check for keywords
    if (lowerMsg.contains('help') || lowerMsg.contains('support')) {
      return '🤔 I\'m here to help! You can ask me about:\n\n• Services I offer\n• My projects\n• Pricing\n• Availability\n• Contact information\n• Technologies I use\n\nWhat would you like to know?';
    }

    if (lowerMsg.contains('time') || lowerMsg.contains('hour')) {
      return '⏰ I\'m available 24/7 for your queries. You can reach me anytime and I\'ll respond within 24 hours for serious project inquiries.';
    }

    if (lowerMsg.contains('location') || lowerMsg.contains('where')) {
      return '📍 I\'m based in India, but I work with clients worldwide. I offer remote services and can collaborate with teams globally.';
    }

    if (lowerMsg.contains('payment') || lowerMsg.contains('pay')) {
      return '💳 I accept multiple payment methods:\n\n• Bank Transfer\n• PayPal\n• Wise\n• Cryptocurrency (BTC, ETH)\n• Escrow services\n\nAll payments are secure and transparent.';
    }

    if (lowerMsg.contains('portfolio') || lowerMsg.contains('work')) {
      return '📂 You can view my portfolio in the "Projects" section above. I\'ve worked on 100+ projects across various industries.';
    }

    // Default response
    return '🤔 Thank you for your message! I\'d love to help you. Could you please provide more details about what you\'re looking for? I specialize in Flutter, Full Stack, and AI development.\n\nYou can try asking me about:\n• Services\n• Pricing\n• Projects\n• Contact information';
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 200), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Chat Button
        Positioned(
          bottom: 160,
          right: 24,
          child: GestureDetector(
            onTap: _toggleChat,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF06B6D4), Color(0xFF10B981)],
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF06B6D4).withOpacity(0.4),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Icon(
                  _isOpen ? Icons.close : Icons.chat,
                  key: ValueKey(_isOpen),
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),
          ),
        ),

        // Chat Window
        if (_isOpen)
          Positioned(
            bottom: 230,
            right: 24,
            width: 380,
            height: 520,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: FadeTransition(
                opacity: _opacityAnimation,
                child: Material(
                  elevation: 24,
                  borderRadius: BorderRadius.circular(20),
                  color: const Color(0xFF1A1A2E),
                  child: Column(
                    children: [
                      // Header
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF06B6D4), Color(0xFF10B981)],
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.smart_toy,
                                color: Color(0xFF06B6D4),
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'AI Assistant',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: 6,
                                        height: 6,
                                        decoration: const BoxDecoration(
                                          color: Colors.green,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      const Text(
                                        'Online',
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.close,
                                  color: Colors.white, size: 20),
                              onPressed: _toggleChat,
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(
                                  minWidth: 30, minHeight: 30),
                            ),
                          ],
                        ),
                      ),

                      // Messages
                      Expanded(
                        child: ListView.builder(
                          controller: _scrollController,
                          padding: const EdgeInsets.all(16),
                          itemCount: _messages.length,
                          itemBuilder: (context, index) {
                            final message = _messages[index];
                            final isUser = message['sender'] == 'user';
                            final isTyping = message['sender'] == 'typing';

                            if (isTyping) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white10,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width: 6,
                                        height: 6,
                                        decoration: const BoxDecoration(
                                          color: Color(0xFF06B6D4),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      Container(
                                        width: 6,
                                        height: 6,
                                        decoration: const BoxDecoration(
                                          color: Color(0xFF06B6D4),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      Container(
                                        width: 6,
                                        height: 6,
                                        decoration: const BoxDecoration(
                                          color: Color(0xFF06B6D4),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      const Text(
                                        'typing...',
                                        style: TextStyle(
                                          color: Colors.white54,
                                          fontSize: 11,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }

                            return Align(
                              alignment: isUser
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: isUser
                                      ? const Color(0xFF06B6D4)
                                      : Colors.white10,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  message['text']!,
                                  style: TextStyle(
                                    color:
                                        isUser ? Colors.white : Colors.white70,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      // Quick Replies
                      if (_messages.length > 0)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          height: 44,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _quickReplies.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                child: GestureDetector(
                                  onTap: () {
                                    _sendMessage(
                                        _quickReplies[index]['reply']!);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: const Color(0xFF06B6D4)
                                            .withOpacity(0.3),
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      _quickReplies[index]['label']!,
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                      // Input
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide(color: Colors.white10),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _messageController,
                                style: const TextStyle(color: Colors.white),
                                onSubmitted: (value) {
                                  if (value.isNotEmpty) {
                                    _sendMessage(value);
                                  }
                                },
                                decoration: InputDecoration(
                                  hintText: 'Type a message...',
                                  hintStyle:
                                      const TextStyle(color: Colors.white38),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(24),
                                    borderSide: const BorderSide(
                                      color: Colors.white10,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(24),
                                    borderSide: const BorderSide(
                                      color: Colors.white10,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(24),
                                    borderSide: const BorderSide(
                                      color: Color(0xFF06B6D4),
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            GestureDetector(
                              onTap: () {
                                if (_messageController.text.isNotEmpty) {
                                  _sendMessage(_messageController.text);
                                }
                              },
                              child: Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF06B6D4),
                                      Color(0xFF10B981)
                                    ],
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.send,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

// Add Random class for typing delay
class Random {
  final int seed;
  static Random? _instance;

  Random([this.seed = 0]);

  int nextInt(int max) {
    return (DateTime.now().millisecondsSinceEpoch % max).toInt();
  }
}
