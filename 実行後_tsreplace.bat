@echo off
rem ���ϐ�

rem start-point�̐ݒ�
rem QSVEncC/NVEncC/VCEEncC�g�p���Fkeyframe
rem ffmpeg�g�p���Ffirstpacket
rem ���̑���tsreplace��readme�Q��
set startpoint=keyframe

rem Amatsukaze�ŏo�͂����G���R�[�h��t�@�C�����폜����
rem ����t�@�C���Ƃ��Ă͏o�̓t�H���_��TS�t�@�C���̂ݎc��܂�
rem ���t�H���_�ɂł���ass��log�͍폜���܂���
rem 1=�폜����
set delfile=1

rem tsreplace.exe��ʂ̏ꏊ�Ɉړ������ꍇ�͕ύX
set exepath=bat\tsreplace\

rem -----------------------------------------------
echo �c�[���ނ̃p�X�F%exepath%
set tsfile=%IN_PATH%
set LOG_PATH="%LOG_PATH:.log=.txt%"

rem ���O�t�@�C������o�̓p�X���o��
rem �W����OUT_PATH�ϐ����Ɖ��H�O�̕ςȃp�X��Ԃ����Ƃ����邽��
for /f "tokens=1,3-4 delims=:" %%A in ('findstr /n "�o��" %LOG_PATH%') do (
if %%A == 6 (
set mp4file=%%B:%%C
goto endmp4file
)
)
:endmp4file
set mp4file=%mp4file:~1%
set mp4file=%mp4file:/=\%

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
echo %exepath%tsreplace.exe -i "%tsfile%" -r "%mp4file%.%format%" --start-point %startpoint% -o "%OUT_PATH%%outformat%"
%exepath%tsreplace.exe -i "%tsfile%" -r "%mp4file%.%format%" --start-point %startpoint% -o "%OUT_PATH%%outformat%"
echo TS�f�[�^�����I��

rem �I�v�V��������
if %delfile%==1 (
echo [TS���O�G���R�[�h�t�@�C���폜]
del "%mp4file%.%format%"
echo TS���O�G���R�[�h�t�@�C���폜����
)