vsim +access+r;
run -all;
acdb save -o udemy.acdb;
acdb report -db udemy.acdb -txt -o cov.txt -verbose
exec cat cov.txt;
exit