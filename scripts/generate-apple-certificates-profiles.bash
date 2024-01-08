#!/usr/bin/env bash

# Usage: bash scripts/generate-apple-certificates-profiles.bash

set -e # exit on error
#set -x # print commands

(cd macos && fastlane mac generate_certificates_profiles)
