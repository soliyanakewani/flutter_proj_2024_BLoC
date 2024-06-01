
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_proj_2024/application/auth/bloc/auth_bloc.dart';
import 'package:flutter_proj_2024/application/auth/bloc/auth_state.dart';
import 'package:flutter_proj_2024/application/feedback/bloc/feedback_bloc.dart';
import 'package:flutter_proj_2024/application/feedback/bloc/feedback_event.dart';
import 'package:flutter_proj_2024/application/feedback/bloc/feedback_state.dart';
import 'package:flutter_proj_2024/infrastructure/feedback/repositories/feedback_repository_impl.dart';
import 'package:flutter_proj_2024/shared/widgets/appbar.dart';
import 'package:flutter_proj_2024/shared/widgets/drawer.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({Key? key}) : super(key: key);

  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final TextEditingController messageController = TextEditingController();
  int feedbackRating = 0;

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  void setRating(int rating) {
    setState(() {
      feedbackRating = rating;
    });
  }

  Widget buildRatingIcon(int rating, IconData icon) {
    return IconButton(
      icon: Icon(
        icon,
        color: feedbackRating == rating ? Colors.red : Colors.grey,
      ),
      onPressed: () => setRating(rating),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        String userName = 'Loading...';
        String userRole = '';

        if (authState is AuthSuccess) {
          userName = authState.name;
          userRole = authState.role;
        }

        return BlocProvider(
          create: (context) => FeedbackBloc(
            RepositoryProvider.of<FeedbackRepositoryImpl>(context),
          )..add(FetchFeedback()),
          child: Scaffold(
            appBar: AppAppBar(),
            drawer: AppDrawer(),
            backgroundColor: const Color.fromARGB(255, 252, 241, 230),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: BlocBuilder<FeedbackBloc, FeedbackState>(
                      builder: (context, state) {
                        if (state is FeedbackLoading) {
                          return Center(child: CircularProgressIndicator());
                        } else if (state is FeedbackLoaded) {
                          return ListView.builder(
                            itemCount: state.feedbackList.length,
                            itemBuilder: (context, index) {
                              final feedback = state.feedbackList[index];
                              final isOwner = feedback.user == userName;

                              return ListTile(
                                title: Text(
                                  feedback.user,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(feedback.message),
                                    Row(
                                      children: List.generate(5, (i) {
                                        return Icon(
                                          i < feedback.rating ? Icons.star : Icons.star_border,
                                          color: Colors.amber,
                                        );
                                      }),
                                    ),
                                  ],
                                ),
                                trailing: isOwner
                                    ? Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            icon: Icon(Icons.edit),
                                            onPressed: () {
                                              messageController.text = feedback.message;
                                              setRating(feedback.rating);
                                              showDialog(
                                                context: context,
                                                builder: (context) => AlertDialog(
                                                  title: Text('Edit Feedback'),
                                                  content: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Text('Your Rating:'),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                        children: [
                                                          buildRatingIcon(1, Icons.sentiment_very_dissatisfied),
                                                          buildRatingIcon(2, Icons.sentiment_dissatisfied),
                                                          buildRatingIcon(3, Icons.sentiment_neutral),
                                                          buildRatingIcon(4, Icons.sentiment_satisfied),
                                                          buildRatingIcon(5, Icons.sentiment_very_satisfied),
                                                        ],
                                                      ),
                                                      Text('Your Message:'),
                                                      TextField(
                                                        controller: messageController,
                                                      ),
                                                    ],
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                        messageController.clear();
                                                      },
                                                      child: Text('Cancel'),
                                                    ),
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        final message = messageController.text;

                                                        if (message.isEmpty) {
                                                          ScaffoldMessenger.of(context).showSnackBar(
                                                            SnackBar(content: Text('Please enter your message')),
                                                          );
                                                          return;
                                                        }

                                                        context.read<FeedbackBloc>().add(
                                                              UpdateFeedback(
                                                                feedback.id!,
                                                                feedback.user,
                                                                message,
                                                                feedbackRating,
                                                              ),
                                                            );

                                                        Navigator.pop(context);
                                                      },
                                                      child: Text('Update'),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.delete),
                                            onPressed: () {
                                              context.read<FeedbackBloc>().add(DeleteFeedback(feedback.id!));
                                            },
                                          ),
                                        ],
                                      )
                                    : null,
                              );
                            },
                          );
                        } else if (state is FeedbackError) {
                          return Center(child: Text(state.message));
                        } else {
                          return Center(child: Text('No feedback available'));
                        }
                      },
                    ),
                  ),
                  if (userRole != 'admin') ...[
                    Text('Add Feedback'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildRatingIcon(1, Icons.sentiment_very_dissatisfied),
                        buildRatingIcon(2, Icons.sentiment_dissatisfied),
                        buildRatingIcon(3, Icons.sentiment_neutral),
                        buildRatingIcon(4, Icons.sentiment_satisfied),
                        buildRatingIcon(5, Icons.sentiment_very_satisfied),
                      ],
                    ),
                    TextField(
                      controller: messageController,
                      decoration: InputDecoration(labelText: 'Your Message'),
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        final message = messageController.text;

                        if (message.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Please enter your message')),
                          );
                          return;
                        }

                        context.read<FeedbackBloc>().add(
                              PostFeedback(
                                userName,
                                message,
                                feedbackRating,
                              ),
                            );

                        messageController.clear();
                        setRating(0);
                      },
                      child: Text('Submit'),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}