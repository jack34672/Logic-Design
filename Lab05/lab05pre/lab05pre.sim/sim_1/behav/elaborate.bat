@echo off
set xv_path=D:\\Tools\\Xilinx\\Vivado\\2016.2\\bin
call %xv_path%/xelab  -wto 8c2854bb82d84be1b1d736c696484ced -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot lab05pre_t_behav xil_defaultlib.lab05pre_t xil_defaultlib.glbl -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
