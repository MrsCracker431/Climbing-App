rem Note: Create a temporary virtual python environment to avoid global package mess.
python.exe -m venv .venv
call .venv\Scripts\activate.bat
python -m pip install --upgrade pip

rem Note: To run this following must be installed
python -m pip install pyinstaller
python -m pip install tornado
python -m pip install Pillow
rem Note: CCTP framework needs below installed this needs to be run from same dir as requirements file
pushd .
rem cd ../..
python -m pip install -r requirements.txt
popd

pyinstaller --onefile loop_unit_readout.py --paths="../../framework" --paths="../../framework/locationsfiles"  --add-data "../../framework/locationsfiles/CCTP-AIMLocations.h;locationsfiles/." --add-data "../../framework/locationsfiles/CCTP-MAMLocations.h;locationsfiles/." --add-data "../../framework/locationsfiles/CCTP-TF_STM32Locations.h;locationsfiles/." --icon="../../framework/consilium.ico" --add-data "../../framework/consilium.ico;." --add-data "Consilium.PNG;." --add-data "loop_unit_readout.py;." --clean

del loop_unit_readout.exe
copy dist\loop_unit_readout.exe   /Y
rem sleep in order to have time to copy exe before deleting folder
timeout /t 1
rmdir __pycache__ /S /Q 
rmdir build /S /Q 
rmdir dist /S /Q 
del *.spec
call .venv\Scripts\deactivate.bat
rmdir .venv /S /Q
pause




