import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palm_ai_demo/src/chat/presentation/presentation.dart';

import '../widgets/widgets.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          return Column(
            children: [
              if (state.status == ChatStatus.submiting) ...[
                const LinearProgressIndicator(),
                const SizedBox(
                  height: 10,
                ),
              ],
              if (state.status == ChatStatus.processing) ...[
                const Text('Processing...'),
                const SizedBox(
                  height: 10,
                ),
              ],
              if (state.status == ChatStatus.error) ...[
                Text(state.errorMessage ?? 'Error...'),
                const SizedBox(
                  height: 10,
                ),
              ],
              Expanded(
                flex: 1,
                child: ChatMessagesWidget(
                  messages: state.messages,
                  onSubmit: (messageText) {
                    context.read<ChatBloc>().add(
                          SendChatMessageEvent(messageText: messageText),
                        );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  AppBar _buildAppBar() => AppBar(
        title: const Text('Palm API 🤝 Flutter'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                context.read<ChatBloc>().add(const ResetChatEvent());
              },
              icon: const Icon(Icons.refresh))
        ],
      );
}
