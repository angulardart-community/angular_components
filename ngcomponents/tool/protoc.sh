#!/usr/bin/env bash
#
# Generate Date proto class
# bash tool/install_protoc.sh must be run first


pushd lib/material_datepicker/proto
protoc --dart_out=. *.proto

rm *.pbenum.dart
rm *.pbjson.dart
rm *.pbserver.dart

popd