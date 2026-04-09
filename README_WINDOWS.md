**ReClip Windows 快速上手指南** 以及 **一键启动脚本** 的 Markdown 版本。

---

# ReClip Windows 快速上手指南 (Quick Start)

针对 Windows 环境下的路径差异与命令兼容性，请参考以下指南进行配置与启动。

## 1. 环境准备 (Pre-requisites)

* **Python:** 建议安装 Python 3.10 或更高版本。
    * 验证命令：`python --version`
* **FFmpeg (核心依赖):**
    1.  前往 [ffmpeg.org](https://ffmpeg.org/download.html) 下载 Windows 编译版。
    2.  解压后将 `bin` 文件夹的绝对路径添加到系统的 **环境变量 (Path)** 中。
    3.  验证命令：`ffmpeg -version` (必须能看到版本信息)。

---

## 2. Windows 常见坑点汇总 (Troubleshooting)

| 坑点 | 原因 | 解决方法 |
| :--- | :--- | :--- |
| **`brew` 命令报错** | 它是 macOS 专用包管理器 | Windows 用户需通过官网下载安装包或使用 `pip` 安装组件。 |
| **找不到 `yt-dlp`** | Windows 全局路径未识别 | 建议在 **虚拟环境 (venv)** 内重新安装，确保环境独立。 |
| **`activate` 路径错误** | Win/Linux 目录结构不同 | Windows 激活路径为 `venv\Scripts\activate`，而非 `venv/bin/activate`。 |
| **`python3` 命令无效** | Windows 默认命令为 `python` | 在执行脚本或指令时，统一将 `python3` 替换为 `python`。 |

---

## 3. Windows 一键启动脚本 (.bat)

为了避免每次都打开 Git Bash 并手动输入多行命令，请在项目根目录下（与 `app.py` 同级）创建一个名为 `start_reclip.bat` 的文件，并将以下代码粘贴进去：

```batch
@echo off
set PORT=8899
cd /d %~dp0

:: 1. 检查虚拟环境是否存在，不存在则创建
if not exist "venv" (
    echo [INFO] Creating virtual environment...
    python -m venv venv
)

:: 2. 激活虚拟环境
echo [INFO] Activating environment...
call venv\Scripts\activate

:: 3. 安装或更新必要的依赖库
echo [INFO] Checking dependencies (flask, yt-dlp)...
pip install -q flask yt-dlp

:: 4. 启动程序
echo.
echo ========================================
echo   ReClip is running at http://localhost:%PORT%
echo ========================================
echo.

python app.py

pause
```

---

## 4. 使用说明

1.  **日常启动：** 直接双击运行 `start_reclip.bat` 即可。
2.  **保持运行：** 运行期间请勿关闭弹出的黑色命令行窗口。
3.  **访问界面：** 在浏览器地址栏输入 `http://localhost:8899` 即可开始使用。
4.  **更新项目：** 若执行了 `git pull` 更新代码，再次运行 `.bat` 脚本会自动处理可能新增的依赖。