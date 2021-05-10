SCRIPT_DIR=$(realpath $(dirname "$0"))
TARGET_BASE_DIR="${SCRIPT_DIR}/../../heisln-infrastructure"
GITHUB_ORG="Heisln"

REPOS=(\
  Heisln-currency-converter \
  Heisln-Api-CarRentalService \
  Heisln-UserService \
)

echo Create heisln-net network
docker network create heisln-net || true


mkdir "${TARGET_BASE_DIR}" || true

# git clone/pull repos
for repo in "${REPOS[@]}"; do
    echo [*] Checking presence of $repo
    REPO_DIR=${TARGET_BASE_DIR}/$repo
    if [ ! -d "${REPO_DIR}" ]; then
      echo Repository missing. Cloning...
      git clone -b develop git@github.com:$GITHUB_ORG/$repo.git "${REPO_DIR}"
    else
      cd "${REPO_DIR}" && git pull
    fi
done

# run compose files
for repo in "${REPOS[@]}"; do
  REPO_DIR=${TARGET_BASE_DIR}/$repo
  if [ -f "${REPO_DIR}/docker-compose.dev.yml" ]; then
      cd "${REPO_DIR}" && docker-compose -f docker-compose.dev.yml up -d --build
  else
    echo "No docker-compose found ... skipping"
  fi
done

echo [*] Done

echo ""
echo "# Currency Converter"
echo "open http://localhost:9000"

echo ""
echo "# User API"
echo "open http://localhost:9001"

echo ""
echo "# Car API"
echo "open http://localhost:9002"
