@echo off
rem 環境変数

rem start-pointの設定
rem QSVEncC/NVEncC/VCEEncC使用時：keyframe
rem ffmpeg使用時：firstpacket
rem その他はtsreplaceのreadme参照
set startpoint=keyframe

rem tsreplace.exeを別の場所に移動した場合は変更
set exepath=bat\tsreplace\

rem -----------------------------------------------
echo ツール類のパス：%exepath%
set tsfile=%IN_PATH%
set mp4file=%OUT_PATH%
set LOG_PATH="%LOG_PATH:.log=.txt%"

rem ログファイルから出力フォーマットを取得
for /f "tokens=1,3 delims=:" %%A in ('findstr /n "出力フォーマット" %LOG_PATH%') do (
if %%A == 8 (
set format=%%B
goto endformat
)
)
:endformat
set format=%format:~1%
set format=%format:M=m%
set format=%format:P=p%
set format=%format:K=k%
set format=%format:V=v%
set format=%format:T=t%
set format=%format:S=s%

set outformat=.ts
if %format% == ts (
set outformat=_out.ts
goto endoutformat
)
:endoutformat

echo [TSデータ生成]
echo %exepath%tsreplace.exe -i "%IN_PATH%" -r "%OUT_PATH%.%format%" --start-point %startpoint% -o "%OUT_PATH%%outformat%"
%exepath%tsreplace.exe -i "%IN_PATH%" -r "%OUT_PATH%.%format%" --start-point %startpoint% -o "%OUT_PATH%%outformat%"
echo TSデータ生成終了
