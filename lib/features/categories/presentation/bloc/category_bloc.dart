import 'package:flip_cart_demo/features/categories/domain/usecase/get_categories_use_case.dart';
import 'package:flip_cart_demo/features/categories/presentation/bloc/category_event.dart';
import 'package:flip_cart_demo/features/categories/presentation/bloc/category_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetCategoriesUseCase getCategoriesUseCase;

  CategoryBloc({required this.getCategoriesUseCase})
      : super(CategoryInitial()) {
    on<GetCategoriesEvent>((event, emit) async {
      emit(CategoryLoading());

      final result = await getCategoriesUseCase();

      result.fold(
        (failure) => emit(CategoryError(message: failure.errMessage)),
        (categories) => emit(CategoryLoaded(categories: categories)),
      );
    });
  }
}
