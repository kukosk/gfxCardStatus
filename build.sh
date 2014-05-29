set -x
rm -rf build/*
xcodebuild && \
cp build/Release/gfxCardStatusCLI /usr/local/bin/ && \
rm -rf build/*.build
echo STATUR=$?