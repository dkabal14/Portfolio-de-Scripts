@echo off
setlocal EnableDelayedExpansion

REM Input date in the format YYYY-MM-DD
set /p "input_date=Enter the date (YYYY-MM-DD): "
set /p "days_to_add=Enter the number of days to add: "

REM Extract year, month, and day from the input date
set "year=!input_date:~0,4!"
set "month=!input_date:~5,2!"
set "day=!input_date:~8,2!"

REM Perform basic arithmetic to calculate the new date
set /a "day+=days_to_add"
:adjust_day
if %day% gtr 28 (
    set /a "day-=28"
    set /a "month+=1"
    if %month% gtr 12 (
        set /a "month-=12"
        set /a "year+=1"
    )
    goto :adjust_day
)

REM Format the new date
set "new_date=!year!-!month:~-2!-!day:~-2!"

echo The new date after adding %days_to_add% days is: %new_date%