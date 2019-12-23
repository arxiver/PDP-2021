#R0 = 2 , others = 0
force -freeze sim:/cbus/BUSdata 16'h2 0
force -freeze sim:/cbus/R0in 1 0
force -freeze sim:/cbus/RCLK 0 0, 1 {12 ns} -r 25
force -freeze sim:/cbus/RESET_R1 1 0
force -freeze sim:/cbus/RESET_R2 1 0
force -freeze sim:/cbus/RESET_R3 1 0
force -freeze sim:/cbus/RESET_R4 1 0
force -freeze sim:/cbus/RESET_R5 1 0
force -freeze sim:/cbus/RESET_R6 1 0
force -freeze sim:/cbus/RESET_R7 1 0
run
noforce sim:/cbus/BUSdata
noforce sim:/cbus/R0in
force -freeze sim:/cbus/RESET_R1 0 0
force -freeze sim:/cbus/RESET_R2 0 0
force -freeze sim:/cbus/RESET_R3 0 0
force -freeze sim:/cbus/RESET_R4 0 0
force -freeze sim:/cbus/RESET_R5 0 0
force -freeze sim:/cbus/RESET_R6 0 0
force -freeze sim:/cbus/RESET_R7 0 0
force -freeze sim:/cbus/CLK 1 0, 0 {50 ns} -r 100
run
noforce sim:/cbus/BUSdata
noforce sim:/cbus/R0in
force -freeze sim:/cbus/INITREAD 1 0
run
force -freeze sim:/cbus/INITREAD 0 0
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
#R7 = 3 , R3 = 2, R1 = 2 , R0 = 0 


