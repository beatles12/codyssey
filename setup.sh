#!/bin/bash

echo "🚀 Codyssey 환경 세팅 시작!"

# 1. Git 사용자 설정
git config --global user.name "beatles12"
git config --global user.email "happy1200000@gmail.com"
echo "✅ Git 설정 완료"

# 2. SSH 키 생성 (없을 때만)
if [ ! -f ~/.ssh/id_ed25519 ]; then
    ssh-keygen -t ed25519 -C "happy1200000@gmail.com" -f ~/.ssh/id_ed25519 -N ""
    echo "✅ SSH 키 생성 완료"
    echo ""
    echo "📋 아래 키를 GitHub에 등록하세요:"
    echo "<https://github.com/settings/ssh/new>"
    echo ""
    cat ~/.ssh/id_ed25519.pub
else
    echo "✅ SSH 키 이미 존재 - 스킵"
fi

# 3. 공개키 복사 및 다음 단계 안내
pbcopy < ~/.ssh/id_ed25519.pub

echo ""
echo "📋 SSH 공개키가 클립보드에 복사되었습니다."
echo "1. GitHub에 공개키 등록:"
echo "   https://github.com/settings/ssh/new"
echo "2. 연결 테스트:"
echo "   ssh -T git@github.com"
echo "3. 연결 성공 후 저장소 복제:"
echo "   cd ~"
echo "   git clone git@github.com:beatles12/codyssey.git"
echo ""
echo "✅ 1차 세팅 완료!"
