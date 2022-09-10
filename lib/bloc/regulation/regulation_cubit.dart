import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:poteu/repository/regulation_repository.dart';

part 'regulation_state.dart';

class RegulationCubit extends Cubit<RegulationState> {
  RegulationCubit({required RegulationRepository regulationRepository})
      : _regulationRepository = regulationRepository,
        super(RegulationInitial());

  final RegulationRepository _regulationRepository;
  List<int> getChapterAndParagraphOrderNums(int chapterID, paragraphID) =>
      _regulationRepository.getChapterAndParagraphOrderNums(
          chapterID, paragraphID);
}
