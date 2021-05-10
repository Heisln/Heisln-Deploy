SCRIPT_DIR=$(realpath $(dirname "$0"))
TARGET_BASE_DIR="${SCRIPT_DIR}/../../heisln-infrastructure"
GITHUB_ORG="Heisln"

REPOS=(\
  Heisln-Api-CarRentalService \
  Heisln-UserService \
  Heisln-currency-converter \
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
        git clone git@github.com:$GITHUB_ORG/$repo.git "${REPO_DIR}"
        git checkout develop
    else
        cd "${REPO_DIR}" && git pull
    fi
done

# run compose files
for repo in "${REPOS[@]}"; do
  REPO_DIR=${TARGET_BASE_DIR}/$repo
  if [ -f "${REPO_DIR}/docker-compose.yml" ]; then
     docker-compose up -d
  else
    echo "No docker-compose found ... skipping"
  fi
done

echo [*] Done

echo ""
echo "# Connect to api-gateway service"
echo "open http://localhost:6001"
echo ""
echo "# Connect to stammdaten service"
echo "open http://localhost:6002"
echo ""
echo "# Connect to verfahren service"
echo "open http://localhost:6003"
echo ""
echo "# Connect to reporting-engine service"
echo "open http://localhost:6004"
echo ""