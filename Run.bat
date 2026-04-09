@echo off
set PORT=8899
cd /d %~dp0

:: 1. 检查虚拟环境是否存在，不存在则创建
if not exist "venv" (
    echo [INFO] 正在创建虚拟环境...
    python -m venv venv
)

:: 2. 激活虚拟环境
echo [INFO] 正在激活环境...
call venv\Scripts\activate

:: 3. 安装/更新依赖
echo [INFO] 检查依赖库 (flask, yt-dlp)...
pip install -q flask yt-dlp

:: 4. 启动程序
echo.
echo ========================================
echo   ReClip 已启动: http://localhost:%PORT%
echo ========================================
echo.

python app.py

pause