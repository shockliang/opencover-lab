REM Create a 'GeneratedReports' folder if it does not exist
if not exist "%~dp0GeneratedReports" mkdir "%~dp0GeneratedReports"
 
REM Remove any previous test execution files to prevent issues overwriting
IF EXIST "%~dp0OpenCoverLab.trx" del "%~dp0OpenCoverLab.trx%"
 
REM Remove any previously created test output directories
CD %~dp0
FOR /D /R %%X IN (%USERNAME%*) DO RD /S /Q "%%X"
 
REM Run the tests against the targeted output
call :RunOpenCoverUnitTestMetrics
 
REM Generate the report output based on the test results
if %errorlevel% equ 0 (
 call :RunReportGeneratorOutput
)
 
REM Launch the report
if %errorlevel% equ 0 (
 call :RunLaunchReport
)
pause
exit /b %errorlevel%
 
:RunOpenCoverUnitTestMetrics
REM "%~dp0..\packages\OpenCover.4.6.519\OpenCover.Console.exe" ^
"%~dp0packages\OpenCover.4.6.519\tools\OpenCover.Console.exe" ^
-register:user ^
-target:"%VS140COMNTOOLS%\..\IDE\mstest.exe" ^
-targetargs:"/testcontainer:\"%~dp0\OpenCoverLab.Tests\bin\Debug\OpenCoverLab.Tests.dll\" /resultsfile:\"%~dp0OpenCoverLab.trx\"" ^
-filter:"+[OpenCoverLab*]* -[OpenCoverLab.Tests]* -[*]OpenCoverLab.RouteConfig" ^
-mergebyhash ^
-skipautoprops ^
-output:"%~dp0\GeneratedReports\OpenCoverLab.xml"
exit /b %errorlevel%
 
:RunReportGeneratorOutput
"%~dp0packages\ReportGenerator.2.5.8\tools\ReportGenerator.exe" ^
-reports:"%~dp0\GeneratedReports\OpenCoverLab.xml" ^
-targetdir:"%~dp0\GeneratedReports\ReportGenerator Output"
exit /b %errorlevel%
 
:RunLaunchReport
start "report" "%~dp0\GeneratedReports\ReportGenerator Output\index.htm"
exit /b %errorlevel%

