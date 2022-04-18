# Test with lefse and lefser



Instructions about adding the channels for biobakery can be found at this
url:
https://github.com/biobakery/conda-biobakery#:~:text=To%20get%20started%2C%20install%20conda,for%20many%20of%20their%20dependencies.&text=Now%20install%20a%20bioBakery%20package%20with%20conda.


For installing lefse, create an environment named biobakery (or whatever name,
just not in base), and type:

conda install -c bioconda lefse


In case 'solving environment' of something similar takes forever,
remove all channels and added agai--biobakery last.

Then remove conda-forge and add it. Then remove biobakery and add it.
Use this `conda config --set channel_priority strict`.

Chek this post for more info: https://stackoverflow.com/questions/63734508/stuck-at-solving-environment-on-anaconda



The dataset already included in the lefser package was used as an example.
The dataset was formated in R and exported to the *zeller14.txt file with the
`get_dataset.R` script.

R in the command line was run with the following script:
./run_lefse.sh ~/miniconda3/bin/activate lefse ~/bin/Rscript

The output was imported in the R markdown document
