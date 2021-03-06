# 
# Synthesis run script generated by Vivado
# 

set_param xicom.use_bs_reader 1
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7a35tcpg236-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir {D:/Jack/NTHU/2018_spring/LD exp/Lab10/Lab102test/Lab102test.cache/wt} [current_project]
set_property parent.project_path {D:/Jack/NTHU/2018_spring/LD exp/Lab10/Lab102test/Lab102test.xpr} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
read_verilog -library xil_defaultlib {
  {D:/Jack/NTHU/2018_spring/LD exp/Lab10/Lab102test/Lab102test.srcs/sources_1/new/ssd_test.v}
  {D:/Jack/NTHU/2018_spring/LD exp/Lab10/Lab102test/Lab102test.srcs/sources_1/new/keyboard_test.v}
  {D:/Jack/NTHU/2018_spring/LD exp/Lab05/lab05pre/lab05pre.srcs/sources_1/new/ssd_ctl.v}
  {D:/Jack/NTHU/2018_spring/LD exp/Lab05/lab05pre/lab05pre.srcs/sources_1/new/frequency_divider.v}
  {D:/Jack/NTHU/2018_spring/LD exp/Lab10/Lab102test/Lab102test.srcs/sources_1/new/test.v}
}
foreach dcp [get_files -quiet -all *.dcp] {
  set_property used_in_implementation false $dcp
}
read_xdc {{D:/Jack/NTHU/2018_spring/LD exp/Lab10/Lab102test/Lab102test.srcs/constrs_1/new/Lab102test_XDC.xdc}}
set_property used_in_implementation false [get_files {{D:/Jack/NTHU/2018_spring/LD exp/Lab10/Lab102test/Lab102test.srcs/constrs_1/new/Lab102test_XDC.xdc}}]


synth_design -top speaker -part xc7a35tcpg236-1


write_checkpoint -force -noxdef speaker.dcp

catch { report_utilization -file speaker_utilization_synth.rpt -pb speaker_utilization_synth.pb }
