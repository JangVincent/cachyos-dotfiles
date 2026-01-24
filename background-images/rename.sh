#!/bin/bash

# 이미지 파일 순서 정렬 스크립트
# - 새 파일 추가 시: 순서에 맞게 번호 부여
# - 파일 삭제 시: 빈 번호 없이 재정렬

cd "$(dirname "$0")"

# 이미지 파일 찾기 (jpg, jpeg, png, gif, webp)
files=($(ls -1 *.{jpg,jpeg,png,gif,webp} 2>/dev/null | sort -V))

if [ ${#files[@]} -eq 0 ]; then
    echo "이미지 파일이 없습니다."
    exit 0
fi

echo "총 ${#files[@]}개 파일 발견"

# 1단계: 임시 이름으로 변경 (충돌 방지)
counter=1
for f in "${files[@]}"; do
    ext="${f##*.}"
    mv "$f" ".tmp_${counter}.${ext}"
    counter=$((counter + 1))
done

# 2단계: 최종 이름으로 변경
counter=1
for f in $(ls -1 .tmp_* 2>/dev/null | sort -t_ -k2 -n); do
    ext="${f##*.}"
    mv "$f" "${counter}.${ext}"
    echo "  ${counter}.${ext}"
    counter=$((counter + 1))
done

echo "완료: 1~$((counter - 1)) 번호로 정렬됨"
