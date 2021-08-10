#!/usr/bin/env bash
# SPDX-FileCopyrightText: 0000 Author Name <author@example.org>
# SPDX-License-Identifier: CC-PDDC
set -uexo pipefail

echo 'Output check'
[[ "$(project-name)" == "Hello world!" ]]  # TODO: replace
