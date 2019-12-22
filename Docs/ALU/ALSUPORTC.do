force -freeze sim:/alsu_portc_entity/Y 16'h00FF 0
force -freeze sim:/alsu_portc_entity/B 16'hFF00 0
force -freeze sim:/alsu_portc_entity/S 3'h0 0
force -freeze sim:/alsu_portc_entity/F8 1 0
run
# F = 007F 
force -freeze sim:/alsu_portc_entity/S 3'h1 0
run 
#F = 01FE