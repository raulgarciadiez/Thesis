# read distance data
set prog ./PilatusKreisFit
set prefix /messung/kmc/daten/2015/1Q/pilatus_201501_
set vprefix resultset/visual_

# read exported position info from HDF files
proc read_hdfdata {fn} {
	variable hdfinfo
	set fd [open $fn r]
	foreach line [split [read $fd] \n] {
		# skip comment and blank line
		set line [string trim $line]
		if {[string match #* $line] || [string length $line]==0} { continue }
		set info [lassign $line nr]
		dict set hdfinfo $nr $info
	}
	close $fd
}
		

proc fitdurchlauf {fn x y r} {
	variable hdfinfo
	set fd [open $fn w]
	fconfigure $fd -buffering line
	set ::stop 0
	set maxversuch 5
	dict for {i info} $hdfinfo {
		set number [format %04d $i]
		set versuch 0
		while {!$::stop && $versuch<$maxversuch && [lindex [ \
			set result [exec -ignorestderr  $::prog $::prefix$number.tif $::vprefix$number.ppm $r $x $y] \
			] end] <= 10} { update; incr versuch }
		
		if {$versuch>=$maxversuch}  { continue }
		lassign $result x y r fitness
		puts $fd "$i $r $x $y $fitness $info"
		puts $result
		update
		if {$::stop} { close $fd; error Interrupt }
	}
	close $fd
}


# read positional info 

read_hdfdata fcm_201501_460_78.dat

# scan for distance & homogeneity
fitdurchlauf distancefit_78.dat 505 551 550
