import 'package:talker/talker.dart';

final talker = Talker(
  settings: TalkerSettings(
    colors: {
      TalkerLogType.error.key: AnsiPen()..red(),
      TalkerLogType.info.key: AnsiPen()..green(),
      TalkerLogType.warning.key: AnsiPen()..yellow(),
      TalkerLogType.debug.key: AnsiPen()..gray(),
    },
    enabled: true,
    useHistory: true,
    maxHistoryItems: 100,
    useConsoleLogs: true,
  ),
  logger: TalkerLogger(),
);
