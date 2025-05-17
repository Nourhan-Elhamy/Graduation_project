import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/features/user/presentation/tabs/profile_tab/controller/profile_states.dart';

import '../../../../data/repos/profile_repo.dart';


class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository profileRepository;

  ProfileCubit(this.profileRepository) : super(ProfileInitial());

  Future<void> updateProfile({
    required String accessToken,
    required String name,
    required String gender,
    required String phone,
    required String address,
  }) async {
    emit(ProfileLoading());
    try {
      await profileRepository.updateProfile(
        accessToken: accessToken,
        name: name,
        gender: gender,
        phone: phone,
        address: address,
      );
      emit(ProfileLoaded());
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
