.PHONY: gen gen_offline pub_get_all gen_assets fmt bloc build_release run_web
gen:
		flutter pub get
		flutter pub run build_runner build --delete-conflicting-outputs

gen_offline:
		flutter pub get --offline
		flutter pub run build_runner build --delete-conflicting-outputs

		
pub_get_all:
		sh utils/pub_get_all.sh

gen_assets:
		flutter pub get
		fluttergen -c pubspec.yaml

fmt:
		flutter format . --line-length=100

bloc:
		sh utils/create_bloc.sh

run_web:
		flutter run -d chrome --web-browser-flag "--disable-web-security"
		
build_release:
		flutter build apk --release --obfuscate --split-debug-info=.obfuscate --no-tree-shake-icons --dart-define=APP_ENV=production
		flutter build appbundle --release --obfuscate --split-debug-info=.obfuscate --no-tree-shake-icons --dart-define=APP_ENV=production
