abstract class AdminState {}

class AdminInitial extends AdminState {}

class AdminLoading extends AdminState {}

class AdminLoaded extends AdminState {
  final List<Map<String, dynamic>> items;
  AdminLoaded(this.items);
}

class AdminError extends AdminState {
  final String message;
  AdminError(this.message);
}

class ItemAdded extends AdminState {}

class ItemUpdated extends AdminState {}

class ItemDeleted extends AdminState {}
