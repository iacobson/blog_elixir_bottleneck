# plot.gp
set terminal png font "Arial,14" size 1400,1000
set output "monitor.png"

set title "Monitor the variable calculation in the MagicNumber"
set xlabel "Time (ms)"
set ylabel "Variables processed"
set key top left

set xrange [0:60000]

# plot series (see below for explanation)
# plot [file] with [line type] ls [line style id] [title ...  | notitle]

plot  "monitor-input.log"     with lines   ls 1 title "Input",\
      "monitor-output.log"    with lines   ls 2 title "Output"

