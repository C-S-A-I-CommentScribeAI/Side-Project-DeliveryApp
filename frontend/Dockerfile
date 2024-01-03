# 기반이 될 이미지 선택
FROM debian:12-slim

# 환경 설정
ENV DEBIAN_FRONTEND=noninteractive

# 기본 패키지 설치
RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    xz-utils \
    libglu1-mesa \
    && rm -rf /var/lib/apt/lists/*

# Node.js와 npm을 설치합니다.
RUN apt-get update && apt-get install -y nodejs npm

# Firebase CLI를 npm을 통해 설치합니다.
RUN npm install -g firebase-tools

# Flutter SDK 설치
ENV FLUTTER_HOME=/usr/local/flutter
ENV PATH=$FLUTTER_HOME/bin:$PATH
RUN git clone https://github.com/flutter/flutter.git $FLUTTER_HOME
RUN flutter precache

# Flutter 환경 설정
RUN flutter doctor -v
RUN flutter config --enable-web

# 앱 소스코드 복사
WORKDIR /app
COPY . /app

# 앱 빌드
RUN flutter channel master
RUN flutter upgrade
RUN flutter build web

# 웹 서버 설정
RUN apt-get update && apt-get install -y nginx
RUN cp -r /app/build/web/* /var/www/html/

# Nginx 설정 변경
# 설정 파일을 생성하고 Dockerfile에 적용합니다.
RUN echo "server { listen 80; root /var/www/html; index index.html; location / { try_files \$uri \$uri/ /index.html; } }" > /etc/nginx/sites-available/default

# 기존의 심볼릭 링크를 제거하고 새로운 링크를 생성합니다.
RUN rm -f /etc/nginx/sites-enabled/default && ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/

# 포트 노출 및 웹 서버 실행
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
