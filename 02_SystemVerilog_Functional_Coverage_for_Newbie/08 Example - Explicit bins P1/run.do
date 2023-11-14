<<<<<<< HEAD
vsim +access+r;
run -all;
acdb save;
acdb report -db  fcover.acdb -txt -o cov.txt -verbose
exec cat cov.txt;
=======
vsim +access+r;
run -all;
acdb save;
acdb report -db  fcover.acdb -txt -o cov.txt -verbose
exec cat cov.txt;
>>>>>>> origin/main
exit