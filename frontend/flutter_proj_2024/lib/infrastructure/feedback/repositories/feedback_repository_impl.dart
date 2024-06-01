
import 'package:flutter_proj_2024/domain/feedback/entities/feedback.dart';
import 'package:flutter_proj_2024/domain/feedback/repositories/feedback_repository.dart';
import 'package:flutter_proj_2024/infrastructure/feedback/data_sources/feedback_remote_data_source.dart';

class FeedbackRepositoryImpl implements FeedbackRepository {
  final FeedbackRemoteDataSource remoteDataSource;

  FeedbackRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<AppFeedback>> fetchFeedback() async {
    return await remoteDataSource.fetchFeedback();
  }

  @override
  Future<void> postFeedback(AppFeedback feedback) async {
    return await remoteDataSource.postFeedback(feedback);
  }

  @override
  Future<void> updateFeedback(AppFeedback feedback) async {
    return await remoteDataSource.updateFeedback(feedback);
  }

  @override
  Future<void> deleteFeedback(String feedbackId) async {
    return await remoteDataSource.deleteFeedback(feedbackId);
  }
}