# 개발 워크스테이션 구축

## 1. 프로젝트 개요

이 저장소는 코디세이 미션 1 **「내 컴퓨터에 개발자용 작업실 꾸미기」**의 수행 결과를 정리한 저장소입니다.

macOS 환경에서 터미널, Git, GitHub, OrbStack, Docker, Nginx를 직접 사용했습니다.  
터미널 기본 명령, 파일·디렉터리 권한 변경, Docker 컨테이너 실행과 관리, Dockerfile 기반 웹 서버 제작, 포트 매핑, 바인드 마운트, Docker 볼륨 영속성, GitHub 및 VSCode 연동을 실습했습니다.

---

## 2. 실행 환경

| 항목 | 내용 |
|---|---|
| OS | macOS 15.7.4 |
| Build | 24G517 |
| Shell | zsh (`/bin/zsh`) |
| Git | 2.53.0 |
| Docker | 28.5.2 |
| Docker 실행 환경 | OrbStack |
| Git 기본 브랜치 | `main` |
| 저장소 | `beatles12/codyssey` |

---

## 3. 저장소 구조

```text
codyssey/
├── Dockerfile
├── index.html
├── README.md
├── setup.sh
├── practice/
└── screenshots/
```

- `Dockerfile`: Nginx 기반 커스텀 이미지를 만드는 설정 파일
- `index.html`: Nginx에서 보여주는 웹페이지
- `practice/`: 터미널 명령과 권한 변경 실습 파일
- `screenshots/`: 명령어와 실행 결과 증거 이미지
- `setup.sh`: 개발 환경 설정을 돕는 셸 스크립트

---

## 4. 수행 체크리스트

- [x] 현재 위치 및 숨김 파일 확인
- [x] 폴더 이동·생성
- [x] 파일 생성·내용 확인
- [x] 파일 복사·이름 변경·삭제
- [x] 파일 권한 변경 실습
- [x] 디렉터리 권한 변경 실습
- [x] Docker 버전 및 동작 상태 확인
- [x] Docker 이미지와 컨테이너 목록 확인
- [x] `hello-world` 컨테이너 실행
- [x] Ubuntu 컨테이너 내부 명령 실행
- [x] `docker logs` 확인
- [x] `docker stats` 확인
- [x] Dockerfile 기반 Nginx 이미지 빌드
- [x] 포트 매핑 후 브라우저 접속
- [x] 바인드 마운트 변경 전·후 확인
- [x] Docker 볼륨 영속성 확인
- [x] Git 사용자 설정 및 기본 브랜치 설정
- [x] GitHub SSH 연결
- [x] VSCode에서 저장소와 GitHub 계정 연동
- [x] GitHub에 커밋 및 푸시

---

## 5. 터미널 기본 조작

### 5-1. 현재 위치와 파일 목록 확인

```bash
pwd
ls
ls -la
```

- `pwd`: 현재 내가 들어와 있는 폴더 위치 확인
- `ls`: 현재 폴더의 파일과 폴더 확인
- `ls -la`: 숨김 파일을 포함한 자세한 목록 확인

### 5-2. 폴더와 파일 만들기

```bash
mkdir practice
cd practice
touch original.txt
echo "practice" > original.txt
cat original.txt
```

- `mkdir`: 새 폴더 생성
- `cd`: 다른 폴더로 이동
- `touch`: 빈 파일 생성
- `echo`: 글자를 출력하거나 파일에 저장
- `cat`: 파일 내용 확인

### 5-3. 복사·이름 변경·삭제

```bash
cp original.txt copied.txt
mv copied.txt renamed.txt
rm renamed.txt
ls
```

- `cp`: 파일 복사
- `mv`: 파일 이동 또는 이름 변경
- `rm`: 지정한 파일 삭제

증거:

- [터미널 기본 명령 실습](screenshots/terminal_10_cp_mv_rm.png)

---

## 6. 파일과 디렉터리 권한 실습

리눅스·유닉스 권한은 `r`, `w`, `x`로 표시됩니다.

- `r`: 읽기
- `w`: 쓰기
- `x`: 실행 또는 디렉터리 접근

숫자 권한은 다음 값을 더해 표현합니다.

- 읽기 `4`
- 쓰기 `2`
- 실행 `1`

### 6-1. 파일 권한 변경

```bash
ls -l practice/permission.txt
chmod 777 practice/permission.txt
ls -l practice/permission.txt
chmod 644 practice/permission.txt
ls -l practice/permission.txt
```

- `777`: 소유자·그룹·기타 사용자 모두 읽기·쓰기·실행 가능
- `644`: 소유자는 읽기·쓰기, 나머지는 읽기만 가능

증거:

- [파일 권한 확인](screenshots/rwx_01.png)
- [파일 권한 변경 1](screenshots/rwx_02_chmod1.png)
- [파일 권한 변경 2](screenshots/rwx_03_chmod2.png)

### 6-2. 디렉터리 권한 변경

```bash
mkdir -p practice/permission-dir
ls -ld practice/permission-dir
chmod 700 practice/permission-dir
ls -ld practice/permission-dir
chmod 755 practice/permission-dir
ls -ld practice/permission-dir
```

- `700`: 소유자만 읽기·쓰기·접근 가능
- `755`: 소유자는 읽기·쓰기·접근, 나머지는 읽기·접근 가능

증거:

- [디렉터리 권한 700 → 755](screenshots/directory_permission_700_755.png)

---

## 7. Docker 설치 및 기본 점검

OrbStack을 실행하면 내부 Docker 엔진이 함께 실행됩니다.

```bash
docker --version
docker info
docker images
docker ps
docker ps -a
```

- `docker --version`: Docker 버전 확인
- `docker info`: Docker 엔진 동작 상태 확인
- `docker images`: 내려받거나 직접 만든 이미지 목록 확인
- `docker ps`: 실행 중인 컨테이너 확인
- `docker ps -a`: 종료된 컨테이너를 포함한 전체 목록 확인

증거:

- [Docker 버전·실행·이미지·컨테이너 확인](screenshots/docker_01_ver_run_images_ps.png)
- [전체 컨테이너 목록](screenshots/docker_10_ps_all.png)

---

## 8. Docker 컨테이너 실습

### 8-1. hello-world 실행

```bash
docker run hello-world
```

정상 실행 시 `Hello from Docker!` 문구를 확인했습니다.

### 8-2. Ubuntu 컨테이너 실행

```bash
docker run -it ubuntu bash
pwd
ls
cat /etc/os-release
mkdir -p /home/mytest
echo "Hello Docker" > /home/mytest/test.txt
cat /home/mytest/test.txt
exit
```

증거:

- [Ubuntu 컨테이너 실습 1](screenshots/docker_02_linux1.png)
- [Ubuntu 컨테이너 실습 2](screenshots/docker_03_linux2.png)
- [Ubuntu 내부 명령어](screenshots/docker_04_명령어.png)

### 8-3. `attach` 방식과 `exec` 방식에서 관찰한 차이

```bash
docker run -it ubuntu bash
```

이 방식은 컨테이너의 주 프로세스에 터미널이 직접 연결됩니다.  
컨테이너 안에서 `exit`하면 주 프로세스가 끝나면서 컨테이너도 종료됩니다.

```bash
docker start peaceful_turing
docker exec -it peaceful_turing bash
```

`exec`는 이미 실행 중인 컨테이너 안에 새로운 셸을 추가로 실행합니다.  
`exec`로 들어간 셸에서 나와도 컨테이너의 주 프로세스가 계속 실행 중이라면 컨테이너는 유지됩니다.

### 8-4. 로그와 자원 사용량 확인

```bash
docker logs clever_jang
docker start clever_jang
docker stats --no-stream clever_jang
```

- `docker logs`: 컨테이너 실행 기록 확인
- `docker stats --no-stream`: CPU와 메모리 사용량을 한 번만 측정

증거:

- [Nginx 로그](screenshots/docker_11_nginx_logs.png)
- [Nginx 자원 사용량](screenshots/docker_12_nginx_stats.png)

---

## 9. Dockerfile 기반 Nginx 웹 서버

### 9-1. 사용한 베이스 이미지

Nginx 공식 이미지를 베이스로 사용했습니다.

```dockerfile
FROM nginx
COPY index.html /usr/share/nginx/html/
```

커스텀한 부분은 기본 Nginx 페이지 대신 직접 만든 `index.html`을 복사한 것입니다.

### 9-2. 웹페이지 소스

```html
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Bind Mount Test</title>
</head>
<body>
    <h1>Bind Mount Success!</h1>
    <p>맥에서 수정한 내용이 컨테이너에 바로 반영되었습니다.</p>
</body>
</html>
```

### 9-3. 이미지 빌드

```bash
docker build -t my-nginx .
```

- `docker build`: Dockerfile을 읽어 이미지 제작
- `-t my-nginx`: 이미지 이름을 `my-nginx`로 지정
- `.`: 현재 폴더를 빌드 재료로 사용

증거:

- [Dockerfile 작성](screenshots/docker_05_Dockerfile.png)
- [커스텀 이미지 빌드](screenshots/docker_06_이미지빌드.png)

### 9-4. 포트 매핑 실행

```bash
docker run -p 8080:80 my-nginx
```

- 맥의 `8080` 포트와 컨테이너의 `80` 포트를 연결했습니다.
- 브라우저에서 `http://localhost:8080`으로 접속했습니다.

포트 매핑은 컨테이너 안에서만 열려 있는 웹 서버를 맥의 브라우저에서 볼 수 있게 연결하는 역할을 합니다.

증거:

- [Nginx 컨테이너 실행](screenshots/docker_07_run.png)
- [웹 서버 접속 및 소스](screenshots/docker_08_index_dockerfile.png)

---

## 10. 바인드 마운트 변경 반영

바인드 마운트는 맥의 파일과 컨테이너 안의 파일을 직접 연결하는 방식입니다.

### 10-1. 실행 명령

```bash
docker run -d \
  --name codyssey-bind \
  -p 8081:80 \
  -v "$(pwd)/index.html:/usr/share/nginx/html/index.html:ro" \
  my-nginx
```

- `-d`: 백그라운드 실행
- `--name codyssey-bind`: 컨테이너 이름 지정
- `-p 8081:80`: 맥 8081 포트와 컨테이너 80 포트 연결
- `-v`: 맥의 `index.html`과 컨테이너의 웹페이지 파일 연결
- `:ro`: 컨테이너에서 해당 파일을 읽기 전용으로 사용

### 10-2. 변경 전·후 확인

1. 브라우저에서 `http://localhost:8081` 접속
2. 변경 전 화면 캡처
3. 맥의 `index.html` 내용 수정
4. 파일 저장
5. 브라우저에서 `Command + Shift + R`로 강력 새로고침
6. 바뀐 문구가 즉시 표시되는지 확인

증거:

- [바인드 마운트 변경 전](screenshots/bind_before.png)
- [바인드 마운트 변경 후](screenshots/bind_after.png)

결과: Docker 이미지를 다시 빌드하거나 컨테이너를 다시 만들지 않아도, 맥의 파일 변경이 컨테이너 웹페이지에 바로 반영됐습니다.

---

## 11. Docker 볼륨 영속성 검증

Docker 볼륨은 컨테이너와 분리되어 데이터를 보관합니다.  
따라서 컨테이너를 삭제해도 볼륨을 삭제하지 않으면 데이터가 유지됩니다.

### 11-1. 볼륨 생성

```bash
docker volume create codyssey-data
docker volume ls
```

### 11-2. 첫 번째 컨테이너에서 파일 생성

```bash
docker run -d \
  --name volume-test-1 \
  -v codyssey-data:/data \
  ubuntu sleep infinity
```

```bash
docker exec volume-test-1 bash -lc \
  'echo "Docker volume data" > /data/message.txt && cat /data/message.txt'
```

출력:

```text
Docker volume data
```

### 11-3. 첫 번째 컨테이너 삭제

```bash
docker stop volume-test-1
docker rm volume-test-1
```

이 명령은 시험용 컨테이너만 삭제하고 `codyssey-data` 볼륨은 삭제하지 않습니다.

### 11-4. 두 번째 컨테이너에서 데이터 확인

```bash
docker run \
  --name volume-test-2 \
  -v codyssey-data:/data \
  ubuntu cat /data/message.txt
```

출력:

```text
Docker volume data
```

결과: 첫 번째 컨테이너를 삭제한 뒤 새 컨테이너를 만들어도 볼륨 속 파일이 그대로 유지됐습니다.

증거:

- [Docker 볼륨 영속성 전체 과정](screenshots/docker_volume_persistence.png)

---

## 12. Git 및 GitHub 연동

### 12-1. Git 사용자 및 기본 브랜치 설정

```bash
git config --global user.name "<사용자 이름>"
git config --global user.email "<GitHub 이메일>"
git config --global init.defaultBranch main
git config --global init.defaultBranch
```

출력:

```text
main
```

개인 이메일은 공개 문서와 스크린샷에서 노출되지 않도록 주의했습니다.

### 12-2. GitHub SSH 연결

```bash
ssh-keygen -t ed25519 -C "<GitHub 이메일>"
ssh -T git@github.com
```

SSH 연결 성공 후 비밀번호를 매번 입력하지 않고 GitHub 저장소와 통신할 수 있었습니다.

### 12-3. GitHub 최신 내용 가져오기와 푸시

```bash
git fetch origin
git pull --rebase origin main
git push origin main
git status
```

- `fetch`: GitHub에 새 기록이 있는지 확인
- `pull --rebase`: GitHub 최신 기록을 먼저 놓고 내 커밋을 그 위에 정리
- `push`: 내 로컬 커밋을 GitHub로 업로드
- `status`: 로컬과 GitHub의 동기화 상태 확인

최종 확인 결과:

```text
현재 브랜치 main
브랜치가 'origin/main'에 맞게 업데이트된 상태입니다.

커밋할 사항 없음, 작업 폴더 깨끗함
```

증거:

- [Git 동기화와 깨끗한 작업 폴더](screenshots/git_sync_and_status_clean.png)
- [VSCode GitHub 로그인과 main 브랜치](screenshots/vscode_github_login.png)

---

## 13. 트러블슈팅

### 문제 1. 한글이 깨져 보임

**문제**  
Nginx 웹페이지에서 한글이 정상적으로 표시되지 않았습니다.

**원인 가설**  
브라우저가 HTML 파일의 문자 인코딩을 정확히 알지 못한 것으로 판단했습니다.

**확인**  
`index.html`의 `<head>` 안에 문자 인코딩 설정이 없는지 확인했습니다.

**해결**

```html
<meta charset="UTF-8">
```

를 추가한 뒤 이미지를 다시 빌드하고 컨테이너를 실행했습니다. 이후 한글이 정상적으로 표시됐습니다.

### 문제 2. Docker 데몬에 연결할 수 없음

**문제**

```text
Cannot connect to the Docker daemon...
Is the docker daemon running?
```

오류가 발생했습니다.

**원인 가설**  
OrbStack 앱은 열려 있었지만 Docker 엔진이 `Starting` 상태에서 멈춰 있었습니다.

**확인**  
OrbStack 화면에서 컨테이너 목록이 나타나지 않고 `Starting`만 계속 표시되는 것을 확인했습니다.

**해결**  
OrbStack을 완전히 종료한 뒤 다시 실행했으나 해결되지 않아 macOS를 재시동했습니다. 재시동 후 OrbStack을 실행하자 컨테이너 목록이 정상적으로 나타났고 Docker 명령도 다시 동작했습니다.

### 문제 3. HTML을 수정했지만 브라우저에 예전 내용이 보임

**문제**  
`index.html`을 수정하고 저장했지만 브라우저에는 이전 문구가 계속 표시됐습니다.

**원인 가설**  
브라우저 캐시에 이전 페이지가 남아 있는 것으로 판단했습니다.

**확인**

```bash
cat index.html
```

로 파일 내용을 확인했으며, 터미널에서는 수정된 문구가 정상적으로 보였습니다.

**해결**  
브라우저에서 `Command + Shift + R`을 눌러 캐시를 무시하고 강력 새로고침했습니다. 수정한 내용이 바로 표시됐습니다.

---

## 14. 보안 및 개인정보 보호

- GitHub 비밀번호, 토큰, 인증 코드, 개인키는 저장소에 올리지 않았습니다.
- SSH 개인키 파일은 절대 GitHub에 업로드하지 않습니다.
- Git 이메일이 보이는 스크린샷은 공개 전에 가리거나 제외합니다.
- 공개키는 인증에 사용될 수 있지만 개인키와는 다릅니다.
- 저장소에 민감정보가 포함되지 않았는지 제출 전에 다시 확인합니다.

---

## 15. 주요 검증 순서s

평가자는 다음 순서로 결과를 확인할 수 있습니다.

1. `README.md`에서 전체 수행 내용 확인
2. `Dockerfile`과 `index.html` 확인
3. `screenshots/`에서 터미널·권한·Docker·Git 증거 확인
4. `bind_before.png`와 `bind_after.png` 비교
5. `docker_volume_persistence.png`에서 컨테이너 삭제 전·후 데이터 유지 확인
6. `git_sync_and_status_clean.png`에서 GitHub 동기화 상태 확인
7. `vscode_github_login.png`에서 VSCode GitHub 로그인과 `main` 브랜치 확인

---

## 16. GitHub 저장소

`https://github.com/beatles12/codyssey`
