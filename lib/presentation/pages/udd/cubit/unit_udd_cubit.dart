import 'package:bloc/bloc.dart';
import 'package:donor_darah/base/result_entity.dart';
import 'package:donor_darah/domain/base/authentication_headers_request.dart';
import 'package:donor_darah/domain/model/data/unit_udd/unit_udd_data.dart';
import 'package:donor_darah/domain/repository/unit_udd/unit_udd_repository.dart';
import 'package:equatable/equatable.dart';

part 'unit_udd_state.dart';

class UnitUddCubit extends Cubit<UnitUddState> {
  final UnitUddRepository repository;

  UnitUddCubit(this.repository) : super(UnitUddInitial());

  Future<void> fetchUnitUdd({required String accesToken}) async {
    emit(UnitUddIsLoading());
    final response = await repository
        .fetchUnitUdd(AuthenticationHeadersRequest("accesToken"));

    if (response is ResultSucces) {
      emit(UnitUddIsSuccess(data: (response as ResultSucces).data));
    } else {
      emit(UnitUddIsError(message: (response as ResultError).message));
    }
  }
}
