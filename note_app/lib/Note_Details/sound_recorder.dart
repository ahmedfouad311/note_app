// ignore_for_file: avoid_print, prefer_final_fields

import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
// import 'dart:io' as io;

class SoundRecorder {
  String fileName = 'record.pcm';
  String? path;
  FlutterSoundRecorder? recorder = FlutterSoundRecorder();
  FlutterSoundPlayer player = FlutterSoundPlayer();
  bool isRecorderInitialized = false;
  bool get isRecording => recorder!.isRecording;
  AudioPlayer audioPlayer = AudioPlayer();

  Future init() async {
    Directory directory = await getApplicationDocumentsDirectory();
    path = (directory.path) + "/" + fileName;
    print(path);
    player.openAudioSession();
    recorder = FlutterSoundRecorder();
    final status = await Permission.microphone.request();
    final status2 = await Permission.storage.request();
    if (status != PermissionStatus.granted||status2 != PermissionStatus.granted) {
      throw RecordingPermissionException('Recording permission required.');
    }

    await recorder!.openAudioSession();
    isRecorderInitialized = true;
  }

  void dispose() {
    recorder!.closeAudioSession();
    recorder = null;
    player.closeAudioSession();
    isRecorderInitialized = false;
  }

  Future record() async {
    if (!isRecorderInitialized) {
      return;
    }
    await recorder!.startRecorder(
        toFile: path, codec: Codec.pcm16, sampleRate: 16000, numChannels: 1);
  }

  Future stop() async {
    if (!isRecorderInitialized) {
      return;
    }
    await recorder!.stopRecorder();
    // String directory = (await getApplicationDocumentsDirectory()).path;
    // final file = io.Directory("$directory").listSync();
    player.startPlayer(
      fromURI: path,
      codec: Codec.pcm16,
    );
  }

  Future toggleRecording() async {
    if (recorder!.isStopped) {
      await record();
    } else {
      await stop();
    }
  }

  delete(_path) {
    File test = File(_path);
    test.delete();
  }
}
