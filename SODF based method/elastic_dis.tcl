set Tn $Tn 
set Tfinal $DurationAnalysisTime 
set M 1
set Wn [expr 2*$PI/$Tn] 
set K [expr $M*$Wn*$Wn] 

wipe 
model Basic -ndm 1 -ndf 1 
node 1 0
node 2 0 -mass $M
fix 1 1

set SpringMatID 1
uniaxialMaterial Elastic 1 $K
set ViscousMatID 2
set C [expr 2*0.05*$M*$Wn]
uniaxialMaterial Viscous $ViscousMatID $C 1
set ParallelMatID 3
uniaxialMaterial Parallel $ParallelMatID $SpringMatID $ViscousMatID 
element zeroLength 1 1 2 -mat $ParallelMatID  -dir 1 
recorder EnvelopeNode -file node2.txt -node 2 -dof 1 disp 

pattern UniformExcitation 2 1 -accel $InputAcc 
constraints Plain 
numberer RCM
system SparseGeneral -piv
test EnergyIncr 1e-4 2000
#test NormDispIncr 1e-6 200
algorithm Newton
integrator Newmark 0.5 0.25 
analysis Transient 

set time 0
set analysisConverged 0 
set dT $AnalysisDt
set tCurrent [getTime]
while {$analysisConverged==0 && $tCurrent<$Tfinal} { 
      set analysisConverged [analyze 1 $dT] 
      if { $analysisConverged != 0 } { 
      puts "analysisConverged=$analysisConverged" 
      }
      set tCurrent [getTime]
}
set inFileID [open "node2.txt" "r"]
remove recorders
set min [gets $inFileID] 
set max [gets $inFileID]
set Sd_e [gets $inFileID]
set Vmax [expr pow($Wn,2)*$Sd_e*$M]
close $inFileID

