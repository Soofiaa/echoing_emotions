import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:just_audio/just_audio.dart';

class GrabarAudio extends StatefulWidget {
  const GrabarAudio({super.key});

  @override
  State<GrabarAudio> createState() => _GrabarAudioState();
}

class _GrabarAudioState extends State<GrabarAudio> {
  final AudioRecorder audioRecorder = AudioRecorder();
  final AudioPlayer audioPlayer = AudioPlayer();

  String? recordingPath;
  bool isRecording = false, isPaused = false, isPlaying = false;
  Duration position = Duration.zero;
  Duration duration = Duration.zero;
  Duration savedPosition = Duration.zero;

  @override
  void initState() {
    super.initState();
    audioPlayer.positionStream.listen((pos) {
      setState(() {
        position = pos;
      });
    });
    audioPlayer.durationStream.listen((dur) {
      setState(() {
        duration = dur ?? Duration.zero;
      });
    });
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$hours:$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Grabar Audio"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      floatingActionButton: _recordingButtons(),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(

        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (recordingPath != null)
            Column(
              children: [
                Slider(
                  value: position.inSeconds.toDouble(),
                  min: 0.0,
                  max: duration.inSeconds.toDouble(),
                  onChanged: (value) {
                    final newPosition = Duration(seconds: value.toInt());
                    audioPlayer.seek(newPosition);
                    setState(() {
                      position = newPosition;
                    });
                  },
                ),
                Text(
                  '${formatDuration(position)} / ${formatDuration(duration)}',
                  style: const TextStyle(fontSize: 16),
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.pop(context, recordingPath);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Grabación guardada')),
                    );
                  },
                  color: Theme.of(context).colorScheme.secondary,
                  child: const Text(
                    "Guardar grabación",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _recordingButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FloatingActionButton(
          onPressed: () async {
            if (isRecording && !isPaused) {
              await audioRecorder.pause();
              setState(() {
                isPaused = true;
              });
            } else if (isRecording && isPaused) {
              await audioRecorder.resume();
              setState(() {
                isPaused = false;
              });
            } else {
              if (await audioRecorder.hasPermission()) {
                final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
                final String filepath = p.join(appDocumentsDir.path, "recording.wav");
                await audioRecorder.start(
                  RecordConfig(),
                  path: filepath,
                );
                setState(() {
                  isRecording = true;
                  recordingPath = null;
                });
              }
            }
          },
          child: Icon(
            isRecording
                ? (isPaused ? Icons.play_arrow : Icons.pause)
                : Icons.fiber_manual_record,
            color: Colors.white,
          ),
          backgroundColor: isRecording ? Colors.orange : Colors.red,
        ),
        const SizedBox(width: 20),
        if (isRecording)
          FloatingActionButton(
            onPressed: () async {
              String? filePath = await audioRecorder.stop();
              if (filePath != null) {
                setState(() {
                  isRecording = false;
                  isPaused = false;
                  recordingPath = filePath;
                });
              }
            },
            child: const Icon(
              Icons.stop,
              color: Colors.white,
            ),
            backgroundColor: Colors.blue,
          ),
        const SizedBox(width: 20),
        if (recordingPath != null)
          FloatingActionButton(
            onPressed: () async {
              if (isPlaying) {
                await audioPlayer.pause();
                savedPosition = position; // Save the current position
                setState(() {
                  isPlaying = false;
                });
              } else {
                await audioPlayer.setFilePath(recordingPath!);
                if (position >= duration) {
                  savedPosition = Duration.zero; // Restart from beginning if finished
                }
                await audioPlayer.seek(savedPosition); // Seek to the saved position
                await audioPlayer.play();
                setState(() {
                  isPlaying = true;
                });
              }
            },
            child: Icon(
              isPlaying ? Icons.pause : Icons.play_arrow,
              color: Colors.white,
            ),
            backgroundColor: Colors.green,
          ),
      ],
    );
  }

  @override
  void dispose() {
    audioRecorder.dispose();
    audioPlayer.dispose();
    super.dispose();
  }
}
