import 'package:get/get.dart';
import '../models/queries_model.dart';
import '../repo/queries_repo.dart';

class QueriesController extends GetxController {
  final QueriesRepository _repository = QueriesRepository();

  // All queries list
  final queriesList = <Query>[].obs;
  final isLoadingQueries = false.obs;
  final queriesError = ''.obs;

  // Single query details
  final queryDetails = Rxn<Query>();
  final isLoadingDetails = false.obs;
  final detailsError = ''.obs;

  // Create/Update state
  final isSubmitting = false.obs;
  final submissionError = ''.obs;
  final isSuccess = false.obs;

  RxString attachmentImagePath = ''.obs;

  void resetForm() {
    attachmentImagePath.value = '';
    isSuccess(false);
    submissionError('');
  }

  @override
  void onInit() {
    fetchQueries();
    super.onInit();
  }

  Future<void> fetchQueries() async {
    try {
      isLoadingQueries(true);
      queriesError('');
      final data = await _repository.getQueries();
      queriesList.assignAll(data.data ?? []);
    } catch (e) {
      queriesError('Failed to load queries: ${e.toString()}');
      queriesList.clear();
    } finally {
      isLoadingQueries(false);
    }
  }

  Future<void> fetchQueryDetails(int queryId) async {
    try {
      isLoadingDetails(true);
      detailsError('');
      final data = await _repository.getQueryDetails(queryId);
      queryDetails(data);
    } catch (e) {
      detailsError('Failed to load query details: ${e.toString()}');
      queryDetails(null);
    } finally {
      isLoadingDetails(false);
    }
  }

  Future<void> createNewQuery({
    required String customerQuery,
    required String description,
    required String companyId,
  }) async {
    try {
      isSubmitting(true);
      submissionError('');
      isSuccess(false);
      await _repository.createQuery(
        customerQuery: customerQuery,
        description: description,
        companyId: companyId,
      );
      isSuccess(true);
      fetchQueries(); // Refresh the list
    } catch (e) {
      submissionError('Failed to create query: ${e.toString()}');
    } finally {
      isSubmitting(false);
    }
  }

  Future<void> updateExistingQuery({
    required int queryId,
    required String customerQuery,
    required String description,
  }) async {
    try {
      isSubmitting(true);
      submissionError('');
      isSuccess(false);
      await _repository.updateQuery(
        queryId: queryId,
        customerQuery: customerQuery,
        description: description,
      );
      isSuccess(true);
      fetchQueries(); // Refresh the list
    } catch (e) {
      submissionError('Failed to update query: ${e.toString()}');
    } finally {
      isSubmitting(false);
    }
  }

  Future<void> deleteQuery(int queryId) async {
    try {
      isSubmitting(true);
      submissionError('');
      await _repository.deleteQuery(queryId);
      fetchQueries(); // Refresh the list
    } catch (e) {
      submissionError('Failed to delete query: ${e.toString()}');
    } finally {
      isSubmitting(false);
    }
  }
}
