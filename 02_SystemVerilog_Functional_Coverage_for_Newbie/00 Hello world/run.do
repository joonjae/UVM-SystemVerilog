vsim +access+r;
run -all;
acdb save;
acdb report -db fcover.acdv -txt -o cov.txt -verbose
exec cat cov.txt;
exit