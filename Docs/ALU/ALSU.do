force -freeze sim:/alsu/Y 16'h00FF 0
force -freeze sim:/alsu/B 16'hFF00 0
force -freeze sim:/alsu/S 5'b00000 0
force -freeze sim:/alsu/F8 1 0
run
#F = FFFF