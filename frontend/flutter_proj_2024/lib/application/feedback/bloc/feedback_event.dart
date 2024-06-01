
import 'package:equatable/equatable.dart';


abstract class FeedbackEvent extends Equatable {
  const FeedbackEvent();

  @override
  List<Object> get props => [];
}

class FetchFeedback extends FeedbackEvent {}

class PostFeedback extends FeedbackEvent {
  final String customerName;
  final String message;
  final int rating;

  const PostFeedback(this.customerName, this.message, this.rating);

  @override
  List<Object> get props => [customerName, message, rating];
}

class UpdateFeedback extends FeedbackEvent {
  final String id;
  final String customerName;
  final String message;
  final int rating;

  const UpdateFeedback(this.id, this.customerName, this.message, this.rating);

  @override
  List<Object> get props => [id, customerName, message, rating];
}

class DeleteFeedback extends FeedbackEvent {
  final String id;

  const DeleteFeedback(this.id);

  @override
  List<Object> get props => [id];
}