import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shakwa/Core/Constants/end_points.dart';
import 'package:shakwa/Data/Models/complaint_details_model.dart';
import 'package:shakwa/Data/Repos/show_complain_repo.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

part 'complaint_details_state.dart';

class ComplaintDetailsCubit extends Cubit<ComplaintDetailsState> {
  final ShowComplaintRepo showComplaintRepo;
  io.Socket? socket;
  List<Comment> currentReplies = [];

  ComplaintDetailsCubit({required this.showComplaintRepo})
    : super(ComplaintDetailsInitial());

  void connectSocket(int complaintId) {
    if (socket != null && socket!.connected) {
      print("Socket already connected, skipping creation.");
      return;
    }
    socket = io.io(
      EndPoints.baseUrl, 
      io.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );

    socket!.connect();

    socket!.onConnect((_) {
      print("****** Socket connected ..$complaintId ******");

      socket!.emit("joinComplaint", complaintId);
    });

    socket!.on("newComment", (data) {
      print(data);
      final updatedData = ComplaintDetailsModel.fromJson(data);

      emit(ComplaintDetailsSuccess(complaintDetailsModel: updatedData));
      currentReplies = List.from(updatedData.requestsAndReplies);
      emit(ComplaintRepliesUpdated(replies: currentReplies));
    });

    socket!.onDisconnect(
      (_) => print("Socket disconnected.......$complaintId"),
    );
  }

  void disconnectSocket() {
    if (socket != null) {
      print("Socket disconnecting manually: ${socket!.id}");
      socket!.off("newComment");
      socket!.emit("leaveComplaint");
      socket!.disconnect();
      socket!.dispose();
      socket = null;
    }
  }

  void addLocalReply(Comment reply) {
    currentReplies.add(reply);
    emit(ComplaintRepliesUpdated(replies: List.from(currentReplies)));
  }

  Future<void> getComplaintDetails({required int complaint}) async {
    emit(ComplaintDetailsLoading());

    final response = await showComplaintRepo.getCompanintDetails(complaint);

    response.fold(
      (err) => emit(ComplaintDetailsFailure(errMsg: err.errorMessage)),
      (details) {
        emit(ComplaintDetailsSuccess(complaintDetailsModel: details));

        connectSocket(complaint);
      },
    );
  }

  Future<void> sendReply({
    required int complaintId,
    required String text,
  }) async {
    final result = await showComplaintRepo.sendReply(
      complaintId: complaintId,
      text: text,
    );

    result.fold((err) {}, (success) {});
  }

  @override
  Future<void> close() {
    disconnectSocket();
    return super.close();
  }
}
