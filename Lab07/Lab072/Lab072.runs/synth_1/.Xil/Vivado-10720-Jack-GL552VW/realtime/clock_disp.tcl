# 
# Synthesis run script generated by Vivado
# 

namespace eval rt {
    variable rc
}
set rt::rc [catch {
  uplevel #0 {
    set ::env(BUILTIN_SYNTH) true
    source $::env(HRT_TCL_PATH)/rtSynthPrep.tcl
    rt::HARTNDb_resetJobStats
    rt::HARTNDb_startJobStats
    set rt::cmdEcho 0
    rt::set_parameter writeXmsg true
    rt::set_parameter enableParallelHelperSpawn true
    set ::env(RT_TMP) "D:/Jack/NTHU/2018_spring/LD exp/Lab07/Lab072/Lab072.runs/synth_1/.Xil/Vivado-10720-Jack-GL552VW/realtime/tmp"
    if { [ info exists ::env(RT_TMP) ] } {
      file delete -force $::env(RT_TMP)
      file mkdir $::env(RT_TMP)
    }

    rt::delete_design

    set rt::partid xc7a35tcpg236-1
    source $::env(HRT_TCL_PATH)/rtSynthParallelPrep.tcl

    set rt::multiChipSynthesisFlow false
    source $::env(SYNTH_COMMON)/common.tcl
    set rt::defaultWorkLibName xil_defaultlib

    set rt::useElabCache false
    if {$rt::useElabCache == false} {
      rt::read_verilog -include {
    {D:/Jack/NTHU/2018_spring/LD exp/Lab05/lab05pre/lab05pre.srcs/sources_1/new}
    {D:/Jack/NTHU/2018_spring/LD exp/Lab07/Lab072/Lab072.srcs/sources_1/new}
  } {
      {D:/Jack/NTHU/2018_spring/LD exp/Lab05/lab05pre/lab05pre.srcs/sources_1/new/ssd_ctl.v}
      {D:/Jack/NTHU/2018_spring/LD exp/Lab05/lab05pre/lab05pre.srcs/sources_1/new/ssd.v}
      {D:/Jack/NTHU/2018_spring/LD exp/Lab07/Lab072/Lab072.srcs/sources_1/new/freq_div.v}
      {D:/Jack/NTHU/2018_spring/LD exp/Lab07/Lab072/Lab072.srcs/sources_1/new/clock.v}
      {D:/Jack/NTHU/2018_spring/LD exp/Lab07/Lab072/Lab072.srcs/sources_1/new/FSM.v}
      {D:/Jack/NTHU/2018_spring/LD exp/Lab07/Lab072/Lab072.srcs/sources_1/new/clock_disp.v}
    }
      rt::filesetChecksum
    }
    rt::set_parameter usePostFindUniquification false
    set rt::top clock_disp
    set rt::reportTiming false
    rt::set_parameter elaborateOnly true
    rt::set_parameter elaborateRtl true
    rt::set_parameter eliminateRedundantBitOperator false
    rt::set_parameter writeBlackboxInterface true
    rt::set_parameter merge_flipflops true
    rt::set_parameter srlDepthThreshold 3
    rt::set_parameter rstSrlDepthThreshold 4
# MODE: 
    rt::set_parameter webTalkPath {}
    rt::set_parameter enableSplitFlowPath "D:/Jack/NTHU/2018_spring/LD exp/Lab07/Lab072/Lab072.runs/synth_1/.Xil/Vivado-10720-Jack-GL552VW/"
    set ok_to_delete_rt_tmp true 
    if { [rt::get_parameter parallelDebug] } { 
       set ok_to_delete_rt_tmp false 
    } 
    if {$rt::useElabCache == false} {
      rt::run_rtlelab -module $rt::top
    }

    set rt::flowresult [ source $::env(SYNTH_COMMON)/flow.tcl ]
    rt::HARTNDb_stopJobStats
    if { $rt::flowresult == 1 } { return -code error }

    if { [ info exists ::env(RT_TMP) ] } {
      if { [info exists ok_to_delete_rt_tmp] && $ok_to_delete_rt_tmp } { 
        file delete -force $::env(RT_TMP)
      }
    }


    source $::env(HRT_TCL_PATH)/rtSynthCleanup.tcl
  } ; #end uplevel
} rt::result]

if { $rt::rc } {
  $rt::db resetHdlParse
  set hsKey [rt::get_parameter helper_shm_key] 
  if { $hsKey != "" && [info exists ::env(BUILTIN_SYNTH)] && [rt::get_parameter enableParallelHelperSpawn] && [info exists rt::doParallel] && $rt::doParallel} { 
     $rt::db killSynthHelper $hsKey
  } 
  source $::env(HRT_TCL_PATH)/rtSynthCleanup.tcl
  return -code "error" $rt::result
}
