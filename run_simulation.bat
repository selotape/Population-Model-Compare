@echo off

if [%1]==[] (
	set /p simulation="Enter Simulation: "
) else (
	set simulation=%1
)

set control="experiments\simulations\%simulation%\control-file.ctl"
echo Running G-PhoCS on Control file: "%control%"
"..\G-PhoCS\code\G-PhoCS\bin\G-PhoCS-1-2-3.exe" "experiments\simulations\%simulation%\control-file.ctl"

if %errorlevel% neq 0 goto exit /b %errorlevel%

echo Running Model_Compare on simulation: "%simulation%"
python main.py %simulation%