set PI [expr 4*atan(1.0)]
set g 9.81
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
set Fy [expr $Cy*$Vmax]
set b 0.01
uniaxialMaterial Steel01 1 $Fy $K $b
set ViscousMatID 2
set C [expr 2*0.05*$M*$Wn]
uniaxialMaterial Viscous $ViscousMatID $C 1
set ParallelMatID 3
uniaxialMaterial Parallel $ParallelMatID $SpringMatID $ViscousMatID 
element zeroLength 1 1 2 -mat $ParallelMatID  -dir 1 

set path1 "RESULT/$fileName/$R"
file mkdir $path1;
recorder Node -file $path1/$Tn.txt -time -node 2 -dof 1 disp

pattern UniformExcitation 2 1 -accel $InputAcc 
constraints Plain 
numberer RCM
system SparseGeneral -piv
test EnergyIncr 1e-4 2000
algorithm Newton
integrator Newmark 0.5 0.25
analysis Transient

set Time 0.0
set analysisConverged 0 
set dT $AnalysisDt 
set tCurrent [getTime] 
while { $analysisConverged == 0 && $tCurrent < $Tfinal } { 
         set analysisConverged [analyze 1 $dT] 
         if { $analysisConverged != 0 } {
               puts "analysisConverged=$analysisConverged"
         }
       set tCurrent [getTime]
}
