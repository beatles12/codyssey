# 개발 워크스테이션 구축

## 환경
- OS: macOS
- Shell: zsh
- Git: 2.53.0
- Docker: 28.5.2

## 구축 내용
1. Git 저장소 초기화 및 GitHub 연동
2. 터미널 기본 명령어 실습
3. 파일 권한 실습 (chmod)
4. Docker 컨테이너 실행
5. Nginx 웹서버 구축 (포트 8080:80)
6. 볼륨 마운트 실습

## 실행 방법
```bash
# 이미지 빌드
docker build -t my-nginx .

# 컨테이너 실행 (볼륨 마운트)
docker run -p 8080:80 -v $(pwd):/usr/share/nginx/html my-nginx
접속
브라우저에서 http://localhost:8080 접속
