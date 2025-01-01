import 'package:hooks_riverpod/hooks_riverpod.dart';

final indexBottomNavbarProvider = StateProvider<int>((ref) {
  return 0;
});

final visibilityBottomNavbarProvider = StateProvider<bool>((ref) {
  return true;
});