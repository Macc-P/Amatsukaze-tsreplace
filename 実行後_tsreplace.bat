@echo off
rem ���ϐ�

rem start-point�̐ݒ�
rem QSVEncC/NVEncC/VCEEncC�g�p���Fkeyframe
rem ffmpeg�g�p���Ffirstpacket
rem ���̑���tsreplace��readme�Q��
set startpoint=keyframe

rem tsreplace.exe��ʂ̏ꏊ�Ɉړ������ꍇ�͕ύX
set exepath=bat\tsreplace\

rem -----------------------------------------------
echo �c�[���ނ̃p�X�F%exepath%
set tsfile=%IN_PATH%
set mp4file=%OUT_PATH%
set LOG_PATH="%LOG_PATH:.log=.txt%"

rem ���O�t�@�C������o�̓t�H�[�}�b�g���擾
for /f "tokens=1,3 delims=:" %%A in ('findstr /n "�o�̓t�H�[�}�b�g" %LOG_PATH%') do (
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

echo [TS�f�[�^����]
echo %exepath%tsreplace.exe -i "%IN_PATH%" -r "%OUT_PATH%.%format%" --start-point %startpoint% -o "%OUT_PATH%%outformat%"
%exepath%tsreplace.exe -i "%IN_PATH%" -r "%OUT_PATH%.%format%" --start-point %startpoint% -o "%OUT_PATH%%outformat%"
echo TS�f�[�^�����I��
