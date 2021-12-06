# Parallel Python example

First install the `multiprocess` package which allows more flexibility in objects and functions that can be used for concurrency. The native `multiprocessing` package restricts what kind of functions can be passed to its concurrent processing calls (e.g instance methods)

`pip install multiprocess`


To run `parallel.py` using the resources requested by `jobscript.job`, use the `sbatch` command:

``` bash
sbatch jobscript.job
```

Example output (to be found in `slurm-<jobid>.out`):

```
Non-parallel compute time: 10.018450498580933 seconds.
Parallel compute time on 96 cores: 0.3378734588623047 seconds.
```
