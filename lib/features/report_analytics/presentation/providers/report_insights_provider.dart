import 'package:graphify/features/data/providers/isar_provider.dart';
import 'package:graphify/features/report_analytics/data/models/insight_model.dart';
import 'package:graphify/features/report_analytics/data/repositories/report_analytics_repository.dart';
import 'package:graphify/features/report_analytics/data/services/report_analytics_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'report_insights_provider.g.dart';

@riverpod
ReportAnalyticsRepository reportAnalyticsRepository(ReportAnalyticsRepositoryRef ref){
  final isar = ref.watch(isarProvider);
  return ReportAnalyticsRepository(isar) ;
}

@riverpod
ReportAnalyticsService reportAnalyticsService(ReportAnalyticsServiceRef ref){
  final repo = ref.watch(reportAnalyticsRepositoryProvider);
  return ReportAnalyticsService(repo);
}

@riverpod
Future<PeriodInsight> rollingInsights(RollingInsightsRef ref , String mode)async {
  final service =  ref.watch(reportAnalyticsServiceProvider);
 return await service.calculaterollingInsight(mode);
}