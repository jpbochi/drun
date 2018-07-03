#!/usr/bin/env bash
set -euo pipefail

MV_OPTS="-n"
[ -t 0 ] && MV_OPTS="-i" # Interactive, prompt before overwrite

while getopts ':v:d:fnx' OPT; do
  case $OPT in
    f) # Don't prompt before overwriting
      MV_OPTS='-f';;
    n) # Don't overwrite an existing file
      MV_OPTS='-n';;
    x)
      XTRACE="y";;
    v)
      DRUN_VERSION="$OPTARG";;
    d)
      INSTALL_DIR="$OPTARG";;
    \?)
      echo >&2 "Unknown option -$OPTARG"
      exit 1;;
    :)
      echo >&2 "Missing argument for option -$OPTARG"
      exit 1;;
  esac
done
shift $((OPTIND-1))

INSTALL_DIR=${INSTALL_DIR:-'/usr/local/bin'}
INSTALL_PATH="${INSTALL_DIR}/drun"
INSTALL_DIR=$(dirname "$INSTALL_PATH")

if [ "${MV_OPTS}" = '-n' ] && [ -e "$INSTALL_PATH" ]; then
  echo >&2 "Not overwriting $INSTALL_PATH"
  exit 0;
fi

if [ -z "${DRUN_VERSION:-}" ]; then
  echo 'Determining latest version…'
  DRUN_VERSION=$(curl -sS https://api.github.com/repos/jpbochi/drun/releases/latest | grep '"tag_name"' | sed 's/.*"tag_name": "v\(.*\)".*/\1/')
fi

echo "Installing drun v${DRUN_VERSION} to ${INSTALL_PATH}…"
TEMP_DIR=$(mktemp -d)
mkdir -p "$INSTALL_DIR"

[ "${XTRACE:-}" = 'y' ] && set -o xtrace
curl -sSLf "https://github.com/jpbochi/drun/archive/v${DRUN_VERSION}.tar.gz" | tar -C "$TEMP_DIR" -zxf - --strip-components=1 "drun-$DRUN_VERSION/drun"
mv -v ${MV_OPTS} "$TEMP_DIR/drun" "$INSTALL_PATH"
