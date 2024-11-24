import 'dart:io';

void main() async {
  const String databasePath =
      'build/windows/x64/runner/Release/data/flutter_assets/assets/data/playbook.db';
  const String backupPath = 'backup/playbook.db';

  try {
    // Step 1: Backup the database
    await backupDatabase(databasePath, backupPath);
    print('Database backup completed.');

    // Step 2: Rebuild the Flutter Windows app
    await rebuildFlutterApp();
    print('App rebuild completed.');

    // Step 3: Restore the database
    await restoreDatabase(backupPath, databasePath);
    print('Database restore completed.');
  } catch (e) {
    print('An error occurred: $e');
  }
}

Future<void> backupDatabase(String sourcePath, String backupPath) async {
  final File sourceFile = File(sourcePath);
  final File backupFile = File(backupPath);

  if (await sourceFile.exists()) {
    await backupFile.create(recursive: true);
    await sourceFile.copy(backupPath);
  } else {
    throw Exception('Source database file does not exist.');
  }
}

Future<void> rebuildFlutterApp() async {
  //
  const String flutter = 'c:/src/flutter/flutter/bin/flutter.bat';
  try {
    await Process.run(flutter, ['clean']);
    print('flutter cleaned');
  } catch (e) {
    print(e);
  }
  //
  try {
    await Process.run(flutter, ['get', 'pub', 'dev']);
    print('flutter packages obtained');
  } catch (e) {
    print(e);
  }
  final ProcessResult result = await Process.run(
      flutter, ['build', 'windows', '-t', 'lib/app/main.dart']);

  if (result.exitCode != 0) {
    throw Exception('Failed to rebuild Flutter app: ${result.stderr}');
  }
}

Future<void> restoreDatabase(String backupPath, String destinationPath) async {
  final File backupFile = File(backupPath);
  final File destinationFile = File(destinationPath);

  if (await backupFile.exists()) {
    await destinationFile.create(recursive: true);
    await backupFile.copy(destinationPath);
  } else {
    throw Exception('Backup database file does not exist.');
  }
}
