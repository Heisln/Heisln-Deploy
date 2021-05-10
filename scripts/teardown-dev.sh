SCRIPT_DIR=$(realpath $(dirname "$0"))
TARGET_BASE_DIR="${SCRIPT_DIR}/../../heisln-infrastructure"

REPOS=(\
  Heisln-rabbitmq \
  Heisln-currency-converter \
  Heisln-Api-CarRentalService \
  Heisln-UserService \
)

# run compose files
for repo in "${REPOS[@]}"; do
  REPO_DIR=${TARGET_BASE_DIR}/$repo
  if [ -f "${REPO_DIR}/docker-compose.dev.yml" ]; then
     cd "${REPO_DIR}" && docker-compose -f docker-compose.dev.yml down
  else
    echo "No docker-compose found ... skipping"
  fi
done

# echo Deleting bs-kernsystem-net network
# docker network rm bs-kernsystem-net || true

echo [*] Done
