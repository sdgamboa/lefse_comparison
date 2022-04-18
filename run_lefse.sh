#! /bin/bash

if [[ "$#" == 0 ]]
then
    echo 
    echo Usage: $0 path/to/conda/bin/activate envrionemnt_name path/to/Rscript
    echo
    exit
fi


# Activate conda environment with lefse installed
source $1 $2

fname='zeller14'

if [[ -f $fname.txt ]]
then
    echo
    echo "$fname.txt already present"
    echo
else
    echo
    echo "$fname.txt not present. Generating from script."
    echo
    $3 --vanilla get_dataset.R
fi

## Remove previous files if present
rm -f $fname.in $fname.res $fname.png

## Format input file
## -c indicate row with classes
## -s indicate row with subclasses
## -u indicate row with subjetcts. This options should be deactivated with -1,
## but it doesn't work. Probably a bug?
echo
echo "Formatting input textfile to binary file..."
echo "Output is $fname.in"
echo
lefse_format_input.py "$fname".txt "$fname".in -c 1 -s 2 -u 3 -o 1000000 # -o means TSS normalization; -u 3 was necessary or I would get an error.

## Run lefse
echo
echo "Running lefse..."
echo "Results will be saved to the $fname.res file."
echo
lefse_run.py -a 0.05 -w 0.05 -l 2.0 $fname.in $fname.res

## Create a plot for the results
echo
echo "Plotting lefse output..."
echo "The plot will be saved to the $fname.png file"
echo
lefse_plot_res.py $fname.res $fname.png


