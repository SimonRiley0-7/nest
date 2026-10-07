import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../services/ai_service.dart';

class AiCopilotScreen extends StatefulWidget {
  const AiCopilotScreen({super.key});

  @override
  State<AiCopilotScreen> createState() => _AiCopilotScreenState();
}

class _AiCopilotScreenState extends State<AiCopilotScreen> {
  final TextEditingController _messageController = TextEditingController();
  final AIService _aiService = AIService();
  
  final List<Map<String, dynamic>> _messages = [
    {
      'isUser': false,
      'text': 'Hi! I am EstatoCopilot. Try asking me:\n\n'
          '• "Compare 3BHK flats in Bangalore"\n'
          '• "What is the valuation of Skyline Grand?"\n'
          '• "Find me a home under 2.5 Cr in Pune"',
    }
  ];

  void _sendMessage() async {
    final query = _messageController.text.trim();
    if (query.isEmpty) return;

    setState(() {
      _messages.add({'isUser': true, 'text': query});
      _messages.add({'isUser': false, 'isTyping': true});
    });
    _messageController.clear();

    final provider = Provider.of<AppProvider>(context, listen: false);
    final allProps = provider.properties;

    await Future.delayed(const Duration(seconds: 1)); // Simulate LLM thinking

    String response = '';

    if (query.toLowerCase().contains('compare')) {
      final matchingProps = await _aiService.searchPropertiesNaturalLanguage(query, allProps);
      if (matchingProps.isEmpty) {
        response = 'I could not find properties matching your comparison request.';
      } else {
        final comparison = _aiService.compareProperties(matchingProps, query);
        response = comparison['comparisonSummary'] + '\n\n';
        for (var prop in matchingProps) {
          response += '**${prop.title}**\n';
          response += '• Suitability Score: ${prop.suitabilityScore}%\n';
          response += '• Why choose: Great location, high 5-year appreciation (${prop.projected5YrAppreciation}%).\n';
          response += '• Risk Notes: ${prop.geologicalRisks['floodRisk']} flood risk, ${prop.geologicalRisks['seismicZone']} seismic zone.\n\n';
        }
      }
    } else if (query.toLowerCase().contains('valuation') || query.toLowerCase().contains('price')) {
      final matchingProps = await _aiService.searchPropertiesNaturalLanguage(query, allProps);
      if (matchingProps.isNotEmpty) {
        final prop = matchingProps.first;
        final val = _aiService.calculateValuation(prop);
        response = 'Valuation for **${prop.title}**:\n\n';
        response += '• Current Price: ₹${val['currentListingPrice']}\n';
        response += '• AI Fair Market Value: ₹${val['estimatedFairMarketValue']}\n';
        response += '• 5-Year Projected Appreciation: ${val['projected5YrAppreciationPct']}%\n\n';
        response += 'Forecast:\n';
        for (var year in val['forecastTimeline']) {
          response += '• ${year['year']}: ₹${year['value']}\n';
        }
      } else {
        response = 'Which property would you like a valuation for?';
      }
    } else {
      final matchingProps = await _aiService.searchPropertiesNaturalLanguage(query, allProps);
      if (matchingProps.isNotEmpty) {
        response = 'I found ${matchingProps.length} matching properties:\n';
        for (var prop in matchingProps) {
          response += '• ${prop.title} (₹${prop.price})\n';
        }
      } else {
        response = 'I could not find any live listings matching that description. Could you broaden your search?';
      }
    }

    setState(() {
      _messages.removeLast(); // Remove typing indicator
      _messages.add({'isUser': false, 'text': response});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F172A),
        title: const Row(
          children: [
            Icon(Icons.auto_awesome, color: Color(0xFF6366F1)),
            SizedBox(width: 8),
            Text('AI Copilot', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                final isUser = msg['isUser'];
                final isTyping = msg['isTyping'] ?? false;
                
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(16),
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
                    decoration: BoxDecoration(
                      color: isUser ? const Color(0xFF6366F1) : const Color(0xFF1E293B),
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(16),
                        topRight: const Radius.circular(16),
                        bottomLeft: Radius.circular(isUser ? 16 : 0),
                        bottomRight: Radius.circular(isUser ? 0 : 16),
                      ),
                      border: isUser ? null : Border.all(color: const Color(0xFF334155)),
                    ),
                    child: isTyping 
                        ? const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Color(0xFF818CF8))),
                              SizedBox(width: 12),
                              Text('AI is thinking...', style: TextStyle(color: Color(0xFF94A3B8))),
                            ],
                          )
                        : _buildRichText(msg['text']),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Color(0xFF1E293B),
              border: Border(top: BorderSide(color: Color(0xFF334155))),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Ask about "3BHK in Whitefield"...',
                      hintStyle: const TextStyle(color: Color(0xFF64748B)),
                      filled: true,
                      fillColor: const Color(0xFF0F172A),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: const BorderSide(color: Color(0xFF334155)),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                CircleAvatar(
                  radius: 24,
                  backgroundColor: const Color(0xFF6366F1),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRichText(String text) {
    // Very basic markdown bold parser for the chat UI
    final List<TextSpan> spans = [];
    final boldRegex = RegExp(r'\*\*(.*?)\*\*');
    int lastMatchEnd = 0;

    for (final match in boldRegex.allMatches(text)) {
      if (match.start > lastMatchEnd) {
        spans.add(TextSpan(text: text.substring(lastMatchEnd, match.start)));
      }
      spans.add(TextSpan(text: match.group(1), style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFF59E0B))));
      lastMatchEnd = match.end;
    }

    if (lastMatchEnd < text.length) {
      spans.add(TextSpan(text: text.substring(lastMatchEnd)));
    }

    return RichText(
      text: TextSpan(
        style: const TextStyle(color: Colors.white, fontSize: 15, height: 1.4),
        children: spans,
      ),
    );
  }
}
