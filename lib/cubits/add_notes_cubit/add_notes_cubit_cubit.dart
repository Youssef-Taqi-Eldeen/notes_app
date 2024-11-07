import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:notes_app/constants.dart';
import 'package:notes_app/models/note_model.dart';
part 'add_notes_cubit_state.dart';

class AddNotesCubitCubit extends Cubit<AddNotesCubitState> {
  AddNotesCubitCubit() : super(AddNotesCubitInitial());
  Color color = const Color(0xffAC3931);
  addNote(NoteModel note) async {
    note.color = color.value;
    emit(AddNotesCubitLoading());
    try {
      var notesBox = Hive.box<NoteModel>(kNoteBox);
      await notesBox.add(note);
      emit(AddNotesCubitSuccess());
    } catch (e) {
      emit(AddNotesCubitFailure(e.toString()));
    }
  }
}
