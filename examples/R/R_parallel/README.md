# Parallel R example

To run `parallel.R` using the resources requested by `jobscript.job`, use the `sbatch` command:

``` bash
sbatch jobscript.job
```

Example output:

```
Non-parallel compute time: 10.018450498580933 seconds.
Parallel compute time on 96 cores: 0.3378734588623047 seconds.
```

