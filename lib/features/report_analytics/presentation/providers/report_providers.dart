
import 'package:graphify/features/data/providers/isar_provider.dart';
import 'package:graphify/features/report_analytics/data/models/monthly_report_model.dart';
import 'package:graphify/features/report_analytics/data/repositories/report_repository.dart';
import 'package:graphify/features/report_analytics/data/services/report_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'report_providers.g.dart';

//RepositoryProvider
@riverpod
ReportRepository reportRepository(ReportRepositoryRef ref){
  final isar =  ref.watch(isarProvider);
  return ReportRepository(isar);
}

//ServiceProvider
@riverpod
ReportService reportService(ReportServiceRef ref) {
  final reportRepository =  ref.watch(reportRepositoryProvider);
  return ReportService(reportRepository);
}

//FetchMonthlyReport
@riverpod
Stream<MonthlyReport?> monthlyReportHistory(MonthlyReportHistoryRef ref, String monthYear) {
  final repo = ref.watch(reportRepositoryProvider);
  return repo.watchReportsByMonths(monthYear);
}