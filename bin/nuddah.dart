import 'package:nyxx/nyxx.dart';
import 'dart:io';

// Main function
void main() {
  // Create new bot instance
  Map<String, String> env = Platform.environment;
  env.forEach((k, v) => print("Key=$k Value=$v"));
  final bot = Nyxx(env['Discord']!, GatewayIntents.allUnprivileged);

  // Listen to ready event. Invoked when bot is connected to all shards. Note that cache can be empty or not incomplete.
  bot.onReady.listen((e) {
    print('Ready!');
  });

  // Listen to all incoming messages
  bot.onMessageReceived.listen((e) {
    var funny = RegExp(r'([A-Za-z]*i[A-Za-z]*)');
    var msg = e.message.content;
    var matches = funny.allMatches(msg);
    // Check if message content equals "!ping"
    if (matches.isNotEmpty) {
      var strings = matches.map((e) => e.group(0));
      strings = strings.map((e) => e?.replaceAll(RegExp(r'i'), r'o'));
      var finalContent =
          strings.reduce((value, element) => value! + ' ' + element!);

      e.message.channel.getFromCache()?.sendMessage(content: finalContent);
    }
  });
}
