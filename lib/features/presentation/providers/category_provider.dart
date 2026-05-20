import 'package:graphify/features/presentation/models/category_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'category_provider.g.dart';
@riverpod
class CategoryNotifier extends _$CategoryNotifier {
  @override
  CategoryState build(){
    return CategoryState(selectedcategory: 'Food', isCustomSelected: false);
  }

  void updateCategory(String newCategory){
    if (newCategory == 'Custom') {
      state = CategoryState(selectedcategory: newCategory, isCustomSelected: true);
    }else{
      state = CategoryState(selectedcategory: newCategory, isCustomSelected: false);
    }
  }
}