# SDDM 테마 설정 가이드

[simple-sddm-2](https://github.com/JaKooLit/simple-sddm-2) 테마 기준 설정 가이드입니다.

## 필수 의존성

**최소 요구사항:**
- SDDM >= 0.21.0
- QT6 >= 6.8

### Arch Linux

```bash
sudo pacman -S sddm qt6-svg qt6-virtualkeyboard qt6-multimedia-ffmpeg
```

### Fedora

```bash
sudo dnf install sddm qt6-qtsvg qt6-qtvirtualkeyboard qt6-qtmultimedia
```

### Debian/Ubuntu

```bash
sudo apt install sddm libqt6svg6 qt6-virtualkeyboard-plugin libqt6multimedia6 qml6-module-qtquick-controls qml6-module-qtquick-effects
```

## 테마 설치

```bash
# 테마 디렉토리로 클론
sudo git clone https://github.com/JaKooLit/simple-sddm-2.git /usr/share/sddm/themes/simple_sddm_2
```

## SDDM 설정

`/etc/sddm.conf` 파일을 편집합니다:

```bash
sudo nano /etc/sddm.conf
```

다음 내용을 추가:

```ini
[Theme]
Current=simple_sddm_2

[General]
InputMethod=qtvirtualkeyboard
```

## 테마 커스터마이징

테마 설정 파일 경로: `/usr/share/sddm/themes/simple_sddm_2/theme.conf`

### 시간 형식 변경

기본값은 24시간 형식입니다. AM/PM 형식으로 변경하려면:

```ini
HourFormat="hh:mm AP"
```

### 배경화면 변경

1. 이미지를 `/usr/share/sddm/themes/simple_sddm_2/Backgrounds/` 디렉토리에 복사
2. `theme.conf`에서 파일명 지정:

```ini
Background="your-image.jpg"
```

## SDDM 서비스 활성화

```bash
sudo systemctl enable sddm
```

## 테마 미리보기

```bash
sddm-greeter-qt6 --test-mode --theme /usr/share/sddm/themes/simple_sddm_2
```
