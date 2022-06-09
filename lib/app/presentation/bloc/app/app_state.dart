part of 'app_bloc.dart';

class AppState extends Equatable {
  final String? message;

  const AppState({
    this.message,
  });

  AppState copyWith({
    String? message,
  }) {
    return AppState(
      message: message,
    );
  }

  @override
  List<Object?> get props => [
        message,
      ];
}
