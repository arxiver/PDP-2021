force -freeze sim:/alsu_portb_entity/Y 16'h00FF 0
force -freeze sim:/alsu_portb_entity/B 16'hFF00 0
force -freeze sim:/alsu_portb_entity/S 3'h0 0
force -freeze sim:/alsu_portb_entity/F8 1 0
run
#F = 0000 
force -freeze sim:/alsu_portb_entity/S 3'h1 0
run
#F = 00FF
force -freeze sim:/alsu_portb_entity/Y 16'hFF00 0
run
#F = 0000
