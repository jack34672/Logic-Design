set_property PACKAGE_PIN V17 [get_ports {a}]
set_property IOSTANDARD LVCMOS33 [get_ports {a}]

set_property PACKAGE_PIN V16 [get_ports {b}]
set_property IOSTANDARD LVCMOS33 [get_ports {b}]

set_property PACKAGE_PIN W16 [get_ports {cin}]
set_property IOSTANDARD LVCMOS33 [get_ports {cin}]

set_property PACKAGE_PIN U16 [get_ports {s}]
set_property IOSTANDARD LVCMOS33 [get_ports {s}]
                                               
set_property PACKAGE_PIN E19 [get_ports {cout}]
set_property IOSTANDARD LVCMOS33 [get_ports {cout}]

set_property SEVERITY {Warning} [get_drc_checks NSTD-1]

set_property SEVERITY {Warning} [get_drc_checks UCIO-1]