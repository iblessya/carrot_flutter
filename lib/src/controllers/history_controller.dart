import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HistoryController extends GetxController {
  final box = GetStorage();
  // 검색 기록을 관리하는 리스트
  final searchHistory = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    // 초기화 시 저장소에서 검색 기록 불러오기
    List<dynamic>? storedHistoryDynamic =
    box.read<List<dynamic>>('searchHistory');

    // 동적 리스트를 문자열 리스트로 변환
    List<String> storedHistory =
        storedHistoryDynamic?.map((e) => e.toString()).toList() ?? [];

    searchHistory.addAll(storedHistory);
  }

  // 검색 기록에 새로운 항목을 추가하는 메서드
  void addSearchTerm(String term) {
    // 이미 있는 항목이면 삭제 후 최신으로 추가
    if (searchHistory.contains(term)) {
      searchHistory.remove(term);
    }
    searchHistory.insert(0, term);

    // 검색 기록을 최대 10개로 제한
    if (searchHistory.length > 10) {
      searchHistory.removeLast();
    }

    // 변경된 검색 기록을 저장
    _saveToStorage();
  }

  // 특정 검색 기록을 삭제하는 메서드
  void removeSearchTerm(String term) {
    searchHistory.remove(term);
    _saveToStorage();
  }

  // 모든 검색 기록을 삭제하는 메서드
  void clearAllSearchTerms() {
    searchHistory.clear();
    _saveToStorage();
  }

  // 검색 기록을 저장하는 메서드
  void _saveToStorage() {
    box.write('searchHistory', searchHistory.toList());
  }
}
