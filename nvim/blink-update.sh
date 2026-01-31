#!/bin/bash
set -e

BLINK_DIR="$HOME/.local/share/nvim/site/pack/core/opt/blink.cmp"
TARGET_DIR="$BLINK_DIR/target/release"
ARCH="$(uname -m)"

case "$ARCH" in
    x86_64)  TRIPLE="x86_64-unknown-linux-gnu" ;;
    aarch64) TRIPLE="aarch64-unknown-linux-gnu" ;;
    *)       echo "지원하지 않는 아키텍처: $ARCH"; exit 1 ;;
esac

if [ ! -d "$BLINK_DIR" ]; then
    echo "blink.cmp이 설치되어 있지 않습니다."
    echo "nvim을 실행하여 vim.pack.add로 먼저 설치해주세요."
    exit 1
fi

# 현재 버전 확인
cd "$BLINK_DIR"
CURRENT=$(git describe --tags --exact-match 2>/dev/null || git rev-parse --short HEAD)

# 최신 릴리스 태그 가져오기
git fetch --tags --quiet
LATEST=$(git tag --sort=-v:refname | head -1)

echo "현재 버전: $CURRENT"
echo "최신 버전: $LATEST"

if [ "$CURRENT" = "$LATEST" ] && [ -f "$TARGET_DIR/libblink_cmp_fuzzy.so" ]; then
    echo "이미 최신 버전입니다."
    exit 0
fi

# 최신 태그로 체크아웃
echo "-> $LATEST 체크아웃..."
git checkout "$LATEST" --quiet

# prebuilt binary 다운로드
mkdir -p "$TARGET_DIR"
URL="https://github.com/saghen/blink.cmp/releases/download/${LATEST}/${TRIPLE}.so"

echo "-> prebuilt binary 다운로드 중..."
if curl -fSL "$URL" -o "$TARGET_DIR/libblink_cmp_fuzzy.so" 2>/dev/null; then
    echo "완료! blink.cmp $LATEST 설치됨."
    echo "nvim을 재시작하세요."
else
    echo "다운로드 실패: $URL"
    echo "해당 버전의 prebuilt binary가 아직 없을 수 있습니다."
    exit 1
fi
