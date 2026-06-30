#!/usr/bin/env bash

# Copyright 2026 Eugene Frolov.
#
# All Rights Reserved.
#
#    Licensed under the Apache License, Version 2.0 (the "License"); you may
#    not use this file except in compliance with the License. You may obtain
#    a copy of the License at
#
#         http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
#    WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
#    License for the specific language governing permissions and limitations
#    under the License.

set -eu
set -x
set -o pipefail

# Pinned release: bump when upgrading (see https://github.com/plantuml/plantuml/releases).
PLANTUML_VERSION="1.2026.2"

sudo apt update
sudo apt dist-upgrade -y
sudo apt install -y ca-certificates graphviz openjdk-21-jre-headless wget

sudo install -d -m 0755 /opt/plantuml
sudo wget -qO /opt/plantuml/plantuml.jar \
  "https://github.com/plantuml/plantuml/releases/download/v${PLANTUML_VERSION}/plantuml.jar"

if ! id -u plantuml >/dev/null 2>&1; then
  sudo useradd --system --home /opt/plantuml --shell /usr/sbin/nologin plantuml
fi

sudo chown -R plantuml:plantuml /opt/plantuml
