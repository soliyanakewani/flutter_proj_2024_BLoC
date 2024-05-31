import 'package:flutter_bloc/flutter_bloc.dart';
import 'admin_event.dart';
import 'admin_state.dart';
import 'package:flutter_proj_2024/domain/admin/repositories/admin_repository.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  final AdminRepository adminRepository;

  AdminBloc(this.adminRepository) : super(AdminInitial());

  @override
  Stream<AdminState> mapEventToState(AdminEvent event) async* {
    if (event is LoadItemsEvent) {
      yield AdminLoading();
      try {
        final items = await adminRepository.loadItems();
        yield AdminLoaded(items);
      } catch (e) {
        yield AdminError(e.toString());
      }
    } else if (event is AddItemEvent) {
      yield AdminLoading();
      try {
        await adminRepository.addItem(event.item);
        yield ItemAdded();
        add(LoadItemsEvent()); // Refresh the items list
      } catch (e) {
        yield AdminError(e.toString());
      }
    } else if (event is UpdateItemEvent) {
      yield AdminLoading();
      try {
        await adminRepository.updateItem(event.item);
        yield ItemUpdated();
        add(LoadItemsEvent()); // Refresh the items list
      } catch (e) {
        yield AdminError(e.toString());
      }
    } else if (event is DeleteItemEvent) {
      yield AdminLoading();
      try {
        await adminRepository.deleteItem(event.itemId);
        yield ItemDeleted();
        add(LoadItemsEvent()); // Refresh the items list
      } catch (e) {
        yield AdminError(e.toString());
      }
    }
  }
}
