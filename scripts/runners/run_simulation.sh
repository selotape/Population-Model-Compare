#!/bin/bash
set -o nounset
set -o errexit

# run_simulation assumes:
# - you have the G-PhoCS binary in your environment Path
# - you have python anaconda in Path
# - model_comparisons runner is located in '../run_model_compare.py'



MODEL_COMPARE_PY="../run_model_compare.py"
GPHOCS_EXE="G-PhoCS-1-2-3"

# $1 - control-file path
function run_gphocs {
	echo "Running G-PhoCS on Control file: "$1;
	$GPHOCS_EXE $1;
}

# $1 - simulation name
function run_model_compare {
	echo "Running Model_Compare on simulation: "$1;
	python $MODEL_COMPARE_PY $1;
}

# $var - simulation names
main() {
	for var;
	do
		ctl_file="$var/control-file.ctl"
		if [ -f $ctl_file ]; then
			run_gphocs $ctl_file &
		else
			echo "ERROR: Target control-file " $ctl_file " is not a valid file"  >&2
			exit 1
		fi;
	done

	wait

	for var;
	do
		simulation=$var
		run_model_compare $simulation &
	done

	wait
	
	date
	echo "DONE"
}
 
main "$@"
