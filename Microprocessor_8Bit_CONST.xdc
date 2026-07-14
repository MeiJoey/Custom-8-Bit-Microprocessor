set_property CFGBVS VCCO [current_design]

set_property CONFIG_VOLTAGE 3.3 [current_design]

# Clock
set_property -dict { PACKAGE_PIN W5 IOSTANDARD LVCMOS33 } [get_ports { clk }];
create_clock -period 10.000 [get_ports { clk }];

# EN Switch
set_property -dict { PACKAGE_PIN T18 IOSTANDARD LVCMOS33 } [get_ports { en }];

# Reset Button
set_property -dict { PACKAGE_PIN W19 IOSTANDARD LVCMOS33 } [get_ports { rst }];

# Input Switches
set_property -dict { PACKAGE_PIN V17 IOSTANDARD LVCMOS33 } [get_ports { sw[0] }];
set_property -dict { PACKAGE_PIN V16 IOSTANDARD LVCMOS33 } [get_ports { sw[1] }];
set_property -dict { PACKAGE_PIN W16 IOSTANDARD LVCMOS33 } [get_ports { sw[2] }];
set_property -dict { PACKAGE_PIN W17 IOSTANDARD LVCMOS33 } [get_ports { sw[3] }];
set_property -dict { PACKAGE_PIN W15 IOSTANDARD LVCMOS33 } [get_ports { sw[4] }];
set_property -dict { PACKAGE_PIN V15 IOSTANDARD LVCMOS33 } [get_ports { sw[5] }];
set_property -dict { PACKAGE_PIN W14 IOSTANDARD LVCMOS33 } [get_ports { sw[6] }];
set_property -dict { PACKAGE_PIN W13 IOSTANDARD LVCMOS33 } [get_ports { sw[7] }];

# Opcode Switches
set_property -dict { PACKAGE_PIN T3 IOSTANDARD LVCMOS33 } [get_ports { opcode[0] }];
set_property -dict { PACKAGE_PIN T2 IOSTANDARD LVCMOS33 } [get_ports { opcode[1] }];
set_property -dict { PACKAGE_PIN R3 IOSTANDARD LVCMOS33 } [get_ports { opcode[2] }];
set_property -dict { PACKAGE_PIN W2 IOSTANDARD LVCMOS33 } [get_ports { opcode[3] }];

# Register Select Switches
set_property -dict { PACKAGE_PIN T1 IOSTANDARD LVCMOS33 } [get_ports { RegSelect[0] }];
set_property -dict { PACKAGE_PIN R2 IOSTANDARD LVCMOS33 } [get_ports { RegSelect[1] }];

# Display LED
set_property -dict { PACKAGE_PIN U16 IOSTANDARD LVCMOS33 } [get_ports { LED[0] }];
set_property -dict { PACKAGE_PIN E19 IOSTANDARD LVCMOS33 } [get_ports { LED[1] }];
set_property -dict { PACKAGE_PIN U19 IOSTANDARD LVCMOS33 } [get_ports { LED[2] }];
set_property -dict { PACKAGE_PIN V19 IOSTANDARD LVCMOS33 } [get_ports { LED[3] }];
set_property -dict { PACKAGE_PIN W18 IOSTANDARD LVCMOS33 } [get_ports { LED[4] }];
set_property -dict { PACKAGE_PIN U15 IOSTANDARD LVCMOS33 } [get_ports { LED[5] }];
set_property -dict { PACKAGE_PIN U14 IOSTANDARD LVCMOS33 } [get_ports { LED[6] }];
set_property -dict { PACKAGE_PIN V14 IOSTANDARD LVCMOS33 } [get_ports { LED[7] }];
set_property -dict { PACKAGE_PIN L1 IOSTANDARD LVCMOS33 } [get_ports { Cout }];

# Display 7-Segment
set_property -dict { PACKAGE_PIN W7 IOSTANDARD LVCMOS33 } [get_ports { Segments[0] }];
set_property -dict { PACKAGE_PIN W6 IOSTANDARD LVCMOS33 } [get_ports { Segments[1] }];
set_property -dict { PACKAGE_PIN U8 IOSTANDARD LVCMOS33 } [get_ports { Segments[2] }];
set_property -dict { PACKAGE_PIN V8 IOSTANDARD LVCMOS33 } [get_ports { Segments[3] }];
set_property -dict { PACKAGE_PIN U5 IOSTANDARD LVCMOS33 } [get_ports { Segments[4] }];
set_property -dict { PACKAGE_PIN V5 IOSTANDARD LVCMOS33 } [get_ports { Segments[5] }];
set_property -dict { PACKAGE_PIN U7 IOSTANDARD LVCMOS33 } [get_ports { Segments[6] }];

set_property -dict { PACKAGE_PIN U2 IOSTANDARD LVCMOS33 } [get_ports { an[0] }];
set_property -dict { PACKAGE_PIN U4 IOSTANDARD LVCMOS33 } [get_ports { an[1] }];
set_property -dict { PACKAGE_PIN V4 IOSTANDARD LVCMOS33 } [get_ports { an[2] }];
set_property -dict { PACKAGE_PIN W4 IOSTANDARD LVCMOS33 } [get_ports { an[3] }];

