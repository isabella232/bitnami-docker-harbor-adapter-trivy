#!/bin/bash

# shellcheck disable=SC1091

set -o errexit
set -o nounset
set -o pipefail
# set -o xtrace

# Load libraries
. /opt/bitnami/scripts/libfs.sh
. /opt/bitnami/scripts/libos.sh
. /opt/bitnami/scripts/harbor-adapter-trivy-env.sh
. /opt/bitnami/scripts/libharbor.sh

# Create directories
for dir in "${SCANNER_TRIVY_CACHE_DIR}" "${SCANNER_TRIVY_REPORTS_DIR}"; do
    ensure_dir_exists "${dir}"
    if am_i_root; then
        chown -R "${SCANNER_TRIVY_DAEMON_USER}:${SCANNER_TRIVY_DAEMON_GROUP}" "$dir"
    fi
done

install_custom_certs
