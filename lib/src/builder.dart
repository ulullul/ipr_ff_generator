import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'rc_generator.dart';

Builder remoteConfig(BuilderOptions options) =>
    SharedPartBuilder([const RemoteConfigGenerator()], 'remote_config');