import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../backend/attendance_repository.dart';

final attendanceRepositoryProvider = Provider<AttendanceRepository>((ref) => AttendanceRepository());