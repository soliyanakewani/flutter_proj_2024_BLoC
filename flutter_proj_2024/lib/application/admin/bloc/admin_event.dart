abstract class AdminEvent {}

class LoadItemsEvent extends AdminEvent {}

class AddItemEvent extends AdminEvent {
  final Map<String, dynamic> item;
  AddItemEvent(this.item);
}

class UpdateItemEvent extends AdminEvent {
  final Map<String, dynamic> item;
  UpdateItemEvent(this.item);
}

class DeleteItemEvent extends AdminEvent {
  final String itemId;
  DeleteItemEvent(this.itemId);
}
