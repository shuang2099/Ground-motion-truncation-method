set PI [expr 4*atan(1.0)] 
set g  9.81
set EQ {ag
}
set InputDt    0.01
set AnalysisDt 0.01
set DurationAnalysisTime 25

foreach fileName $EQ {

      set savePath "RESULT"
      file mkdir $savePath
      set InputAcc "Path -filePath RECORDER/$fileName.AT2 -dt $InputDt -factor 9.81"  

# Modifying the upper (0.2T1) and lower (2T1) limits of Tn according to the fundamental period (assume T1=1s)
      for { set Tn 0.2 } { $Tn <= 2.0 } { set Tn [expr $Tn+0.1] } {
       puts "$Tn"

          source  elastic_dis.tcl
          foreach R {1. 2. 3. 4. 5. 6.} {     
		set Cy [expr 1./$R]             
                source inelastic_dis.tcl
         
          }
      }
      puts "EQ : $fileName is COMPLETED"
}



