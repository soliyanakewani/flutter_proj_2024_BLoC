import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_proj_2024/domain/feedback/entities/feedback.dart';
import 'package:flutter_proj_2024/application/feedback/bloc/feedback_event.dart';
import 'package:flutter_proj_2024/application/feedback/bloc/feedback_state.dart';
import 'package:flutter_proj_2024/domain/feedback/repositories/feedback_repository.dart';

class FeedbackBloc extends Bloc<FeedbackEvent, FeedbackState> {
  final FeedbackRepository feedbackRepository;

  FeedbackBloc(this.feedbackRepository) : super(FeedbackInitial()) {
    on<FetchFeedback>(_onFetchFeedback);
    on<PostFeedback>(_onPostFeedback);
    on<UpdateFeedback>(_onUpdateFeedback);
    on<DeleteFeedback>(_onDeleteFeedback);
  }

  void _onFetchFeedback(FetchFeedback event, Emitter<FeedbackState> emit) async {
    emit(FeedbackLoading());
    try {
      final feedbackList = await feedbackRepository.fetchFeedback();
      emit(FeedbackLoaded(feedbackList));
    } catch (e) {
      emit(FeedbackError('Failed to fetch feedback'));
    }
  }

  void _onPostFeedback(PostFeedback event, Emitter<FeedbackState> emit) async {
    try {
      await feedbackRepository.postFeedback(
        AppFeedback(
          user: event.customerName,
          message: event.message,
          rating: event.rating,
        ),
      );
      add(FetchFeedback());
    } catch (e) {
      emit(FeedbackError('Failed to post feedback'));
    }
  }

  void _onUpdateFeedback(UpdateFeedback event, Emitter<FeedbackState> emit) async {
    try {
      await feedbackRepository.updateFeedback(
        AppFeedback(
          id: event.id,
          user: event.customerName,
          message: event.message,
          rating: event.rating,
        ),
      );
      add(FetchFeedback());
    } catch (e) {
      emit(FeedbackError('Failed to update feedback'));
    }
  }

  void _onDeleteFeedback(DeleteFeedback event, Emitter<FeedbackState> emit) async {
    try {
      await feedbackRepository.deleteFeedback(event.id);
      add(FetchFeedback());
    } catch (e) {
      emit(FeedbackError('Failed to delete feedback'));
    }
  }
}