# plot.gp
set terminal png font "Arial,20" size 1200,600
set output "monitor.png"

set title "Variable Calculation"
set xlabel "Time (ms)"
set ylabel "Variables processed"
set key top left

set xrange [0:60000]

# plot series (see below for explanation)
# plot [file] with [line type] ls [line style id] [title ...  | notitle]

plot  "monitor-input.log"     with lines   ls 1 title "Input",\
      "monitor-output.log"    with lines   ls 2 title "Output"

