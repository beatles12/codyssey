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
    echo "https://github.com/settings/ssh/new"
    echo ""
    cat ~/.ssh/id_ed25519.pub
else
    echo "✅ SSH 키 이미 존재 - 스킵"
fi

# 3. 폴더 구조 생성
mkdir -p ~/dev-workspace
cd ~/dev-workspace

# codyssey 폴더가 없을 때만 clone
if [ ! -d "codyssey" ]; then
    git clone git@github.com:beatles12/codyssey.git
    echo "✅ codyssey clone 완료"
else
    echo "✅ codyssey 이미 존재 - 스킵"
fi

echo ""
echo "🎉 세팅 완료!"
echo "📁 작업 폴더: ~/dev-workspace/codyssey"