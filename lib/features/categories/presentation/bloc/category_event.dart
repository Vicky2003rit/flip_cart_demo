import 'package:equatable/equatable.dart';

abstract class CategoryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetCategoriesEvent
    extends CategoryEvent {} // 🔥 fired when loading categories
