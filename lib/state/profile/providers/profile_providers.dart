import 'package:credbud/state/profile/backend/profile_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final profileServiceProvider = Provider((ref) => ProfileService());

final profileStateProvider = FutureProvider((ref) async {
  final profileService = ref.read(profileServiceProvider);
  return profileService.fetchProfile();
});