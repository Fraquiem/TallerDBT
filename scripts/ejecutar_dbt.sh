#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ENV_FILE="${ROOT_DIR}/config/.env"

if [[ -f "${ENV_FILE}" ]]; then
    while IFS='=' read -r clave valor; do
        [[ -z "${clave}" || "${clave}" == \#* ]] && continue
        if [[ "${clave}" =~ ^[A-Za-z_][A-Za-z0-9_]*$ ]] && [[ -z "${!clave+x}" ]]; then
            export "${clave}=${valor}"
        fi
    done < "${ENV_FILE}"
fi

DBT_BIN="${DBT_BIN:-dbt}"

: "${VENTAS_PG_USER:?Define VENTAS_PG_USER}"
: "${VENTAS_PG_PASSWORD:?Define VENTAS_PG_PASSWORD}"
: "${VENTAS_PG_HOST:?Define VENTAS_PG_HOST}"
: "${VENTAS_PG_PORT:?Define VENTAS_PG_PORT}"
: "${VENTAS_PG_DATABASE:?Define VENTAS_PG_DATABASE}"

if ! command -v "${DBT_BIN}" >/dev/null 2>&1; then
    echo "No se encontró dbt. Activa el entorno Conda o define DBT_BIN." >&2
    exit 1
fi

export VENTAS_DUCKDB_PATH="${VENTAS_DUCKDB_PATH:-${ROOT_DIR}/ventas_olap.duckdb}"

cd "${ROOT_DIR}/ventas_dbt"
"${DBT_BIN}" "$@" --profiles-dir "${ROOT_DIR}/config"
