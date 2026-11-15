import 'dart:math';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share_plus/share_plus.dart';
import '../core/constants/roast_messages.dart';

class PrankService {
  static final PrankService instance = PrankService._internal();
  PrankService._internal();

  static const _keyRoastCount = 'messhoo_roast_count';
  static const _keyLastRoastIndex = 'messhoo_last_roast_index';
  static const _keySoundMuted = 'messhoo_sound_muted';

  int _lastRoastIndex = -1;
  final _random = Random();

  Future<int> getRoastCount() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyRoastCount) ?? 0;
  }

  Future<int> incrementRoastCount() async {
    final prefs = await SharedPreferences.getInstance();
    int count = prefs.getInt(_keyRoastCount) ?? 0;
    count += 1;
    await prefs.setInt(_keyRoastCount, count);
    return count;
  }

  Future<bool> isSoundMuted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keySoundMuted) ?? false;
  }

  Future<void> toggleSoundMuted() async {
    final prefs = await SharedPreferences.getInstance();
    bool current = prefs.getBool(_keySoundMuted) ?? false;
    await prefs.setBool(_keySoundMuted, !current);
  }

  Future<void> toggleMute() => toggleSoundMuted();

  String getRandomRoast() {
    final list = RoastMessages.messages;
    int nextIndex;
    do {
      nextIndex = _random.nextInt(list.length);
    } while (nextIndex == _lastRoastIndex && list.length > 1);

    _lastRoastIndex = nextIndex;
    return list[nextIndex];
  }

  String getRandomHeading() {
    final headings = RoastMessages.funnyHeadings;
    return headings[_random.nextInt(headings.length)];
  }

  String getRandomEmoji() {
    final emojis = RoastMessages.funnyEmojis;
    return emojis[_random.nextInt(emojis.length)];
  }

  void playPrankBuzzer() async {
    final muted = await isSoundMuted();
    if (!muted) {
      SystemSound.play(SystemSoundType.alert);
      HapticFeedback.heavyImpact();
    }
  }

  void shareRoast(String roastText) {
    Share.share(
      '👗 *Messhoo Free Prank on Supriya!* 😂\n\n'
      '"$roastText"\n\n'
      '🛍️ Download Messhoo Free - Where dresses are ₹0 but roasts are priceless!',
    );
  }
}
