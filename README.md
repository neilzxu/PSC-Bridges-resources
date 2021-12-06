<h1> Crash course: parallelization on XSEDE/PSC/Bridges-2  </h1>

This document aims to outline the essential steps for getting up-and-running as quickly as possible on the Pittsburgh Supercomputing Center (PSC) and Bridges-2, with a particular focus on running parallel computation in Python and R.

These notes should be treated as a specific application-focused complement to the [official documentation](https://portal.xsede.org/psc-bridges-2#running-sbatch) rather than a substitute.

This document is a work in progress. Please feel free to contribute to it by submitting a [pull request](https://github.com/WannabeSmith/PSC-Bridges-resources/pulls) 🙂

<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-refresh-toc -->
**Table of Contents**

- [Account setup](#account-setup)
    - [Creating account](#creating-account)
    - [Requesting a new allocation](#requesting-a-new-allocation)
    - [Getting added to an existing allocation](#getting-added-to-an-existing-allocation)
- [Running your first job](#running-your-first-job)
    - [Logging into Bridges2/PSC via `ssh`](#logging-into-bridges2psc-via-ssh)
    - [Creating a slurm job batch script](#creating-a-slurm-job-batch-script)
    - [Parallel computation](#parallel-computation)
        - [Python](#python)
        - [R](#r)
        - [Running the Python or R script via `sbatch`](#running-the-python-or-r-script-via-sbatch)
- [Advanced](#advanced)

<!-- markdown-toc end -->


## Account setup

### Creating account

If you do not already have an XSEDE account, you can create one 
[here](https://portal.xsede.org/my-xsede?p_p_id=58&p_p_lifecycle=0&p_p_state=maximized&p_p_mode=view&_58_struts_action=%2Flogin%2Fcreate_account).
    
### Requesting a new allocation

TODO

### Getting added to an existing allocation

To use compute resources, you will need to be added to an XSEDE allocation. Your PI and/or allocation manager can add you as a user to a specific project [here](https://portal.xsede.org/group/xup/add-remove-user).

## Running your first job
    
### Logging into Bridges2/PSC via `ssh`

Start by `ssh`ing into the bridges2 server at port 2222:

``` bash
ssh -p 2222 <username>@bridges2.psc.edu
```

You will be prompted for your XSEDE credentials. Use your XSEDE User Portal password.


### Creating a slurm job batch script

Bridges-2 uses a job-scheduling system called "slurm", providing a way for users like ourselves to request specific resources for our compute jobs and automatically launch jobs once said resources have become available.

Jobs are submitted using the `sbatch` command along with a **batch script** which we must create. 

A batch script may look like the following.

``` bash
#!/bin/bash
#SBATCH -p EM
#SBATCH -N 1
#SBATCH -n 24
#SBATCH --mem 5GB
#SBATCH -t 00:01:00
#SBATCH --mail-type=ALL

# Load Anaconda
module load anaconda3
conda activate

python parallel.py
```

The above script requests the Extreme Memory (EM) partition, with one node, 24 cores, 5GB of memory, for 1 minute, and sends an email to the job runner once the script begins/finishes/fails/etc. This script then loads a `conda` environment and runs a python script called `parallel.py` which we will discuss in the [python](#python) example.

More generally, these batch scripts take the following form.

``` bash
#!/bin/bash

### REQUEST RESOURCES ###
#SBATCH -arg1 argument1
#SBATCH -arg2 argument2 
# .
# .
# .
#SBATCH -arg3 argument3

### LOAD MODULES ###
module load some_module

### RUN SCRIPTS ###
python myscript.py
Rscript myscript.R
```

The area under "REQUEST RESOURCES" is where we request specific resources such as the partition of your allocation to run on (e.g. RM or EM for regular memory or extreme memory, respectively), the amount of compute time, the number of nodes, the number of cores, and so on.

Some common options are given in the following table.

| Argument               | Description                                                    | Example                                 |
|------------------------|----------------------------------------------------------------|-----------------------------------------|
| `-p <partition>`       | Partition                                                      | `-p EM`                                 |
| `-t <HH:MM:SS>`        | Amount of compute time                                         | `-t 00:01:00` (equivalent to 1 hour)    |
| `-N <nodes>`           | Number of nodes                                                | `-N 1`                                  |
| `-n <cores>`           | Number of total cores                                          | `-n 25`                                 |
| `--mem=<memory in GB>` | Amount of RAM in GB                                            | `--mem=10GB`                            |
| `--mail-type=<type>`   | Type of mail to receive (one of `ALL`, `FAIL`, `START`, `END`) | `--mail-type=ALL` or `--mail-type=FAIL` |

For a comprehensive list, see <https://portal.xsede.org/psc-bridges-2#running-sbatch>.

"LOAD MODULES" is where you load the required modules to run your scripts. For example, loading python often requires a conda environment. To see the list of all possible modules, you can run `module avail`.

"RUN SCRIPTS" is where you run your python/R/julia/etc. scripts. If executed correctly, these scripts will have access to the resources requested by the batch script. 

Let's see some of these ideas used in a parallel computing example.

### Parallel computation

In this section, we will perform parallel computations using the examples in [examples](examples) with implementations in both Python and R, alongside an appropriately designed slurm job batch script.

Clone this repository wherever you keep your projects on bridges2.psc.edu.

``` bash
# After logging into bridges2.psc.edu.
# In my/projects/folder

git clone https://github.com/WannabeSmith/PSC-Bridges-resources.git
```

Using either Python or R, we will be running a function `slow_successor(i)` which simply returns `i+1` but with a time delay. We will run this function on the integers 0 through 99, using parallel and non-parallel implementations to see the difference in computation time.

To use Python, continue on to the next section. To use R, jump to [R](#r). 

#### Python

We will recreate the example from [examples/python/python_parallel](examples/python/python_parallel).

Enter the folder `examples/python/python_parallel`.

``` bash
cd examples/python/python_parallel
```

We will be running a rather simple function `slow_successor(i)` which simply returns `i+1` but with a time delay. We will run this function on the integers 0 through 99, using parallel and non-parallel implementations to see the difference in computation time.

Our slurm batch script `jobscript.job` is written as the following.

``` bash
# jobscript.job

#!/bin/bash
#SBATCH -p EM
#SBATCH -N 1
#SBATCH -n 24
#SBATCH --mem 5GB
#SBATCH -t 00:01:00
#SBATCH --mail-type=ALL

# Load Anaconda
module load anaconda3
conda activate

python parallel.py
```

The above batch script requests several resources, loads a `conda` environment, and runs a python file `parallel.py`. This file `parallel.py` is written as follows.

``` python
# parallel.py

import multiprocessing
import time


def slow_successor(i):
    """
    An intentionally slow function that we wish to parallelize
    """
    time.sleep(0.1)
    return i + 1


# We will run `slow_successor` on the numbers 0 through num_iterations-1.
num_iterations = 100

# Non-parallel implementation:
start_time = time.time()
result = list(map(slow_successor, range(num_iterations)))
end_time = time.time()

print("Non-parallel compute time: " + str(end_time - start_time) + " seconds.")


# Parallel implementation:
n_cores = multiprocessing.cpu_count()
start_time = time.time()
with multiprocessing.Pool(n_cores) as p:
    result = p.map(slow_successor, range(num_iterations))
end_time = time.time()

print(
    "Parallel compute time on "
    + str(n_cores)
    + " cores: "
    + str(end_time - start_time)
    + str(" seconds")
)
```

We can now run `parallel.py` using the resources allocated via `jobscript.job` with the `sbatch` command.

``` bash
sbatch jobscript.job
```

Running `sbatch` will submit a job with particular job ID (e.g. 1234567). The output from the job will then be written to `slurm-<jobid>.out` (e.g. `slurm-1234567.out`). The output from `jobscript.job` should look something like

```
Non-parallel compute time: 10.018450498580933 seconds.
Parallel compute time on 96 cores: 0.3378734588623047 seconds
```


#### R

We will recreate the example from [examples/R/R_parallel](examples/R/R_parallel).


Enter the folder `examples/R/R_parallel`.

``` bash
cd examples/R/R_parallel
```


Our slurm batch script `jobscript.job` is written as the following.

``` bash
# jobscript.job

#!/bin/bash
#SBATCH -p EM
#SBATCH -N 1
#SBATCH -n 24
#SBATCH --mem 5GB
#SBATCH -t 00:01:00
#SBATCH --mail-type=ALL

Rscript parallel.R
```

The above batch script requests several resources, and runs an R script `parallel.R`. This file `parallel.R` is written as follows.

``` R
# parallel.R

library(parallel)


# An intentionally slow function that we wish to parallelize
slow_successor <- function(i)
{
  Sys.sleep(0.1)
  return(i + 1)
}


# We will run `slow_successor` on the numbers 0 through num_iterations-1.
num_iterations <- 100


# Non-parallel implementation:
start_time <- Sys.time()
result <- unlist(lapply(1:num_iterations, slow_successor))
end_time <- Sys.time()

time_elapsed <- difftime(end_time, start_time, units = "secs")

print(paste("Non-parallel compute time:", time_elapsed, "seconds."))


# Parallel implementation:
n_cores <- detectCores()

start_time <- Sys.time()
result <- unlist(mclapply(0:(num_iterations-1), slow_successor, mc.cores=n_cores))
end_time <- Sys.time()

time_elapsed <- difftime(end_time, start_time, units = "secs")

print(paste("Parallel compute time on", n_cores, "cores:", time_elapsed, "seconds."))

```

#### Running the Python or R script via `sbatch`
We can now run our Python or R script using the resources allocated via `jobscript.job` with the `sbatch` command.

``` bash
sbatch jobscript.job
```

Running `sbatch` will submit a job with particular job ID (e.g. 1234567). The output from the job will then be written to `slurm-<jobid>.out` (e.g. `slurm-1234567.out`). The output from `jobscript.job` should look something like

```
Non-parallel compute time: 10.018450498580933 seconds.
Parallel compute time on 96 cores: 0.3378734588623047 seconds.
```

## Advanced

TODO

**_Warning:_** TODO add warning about random number generation when parallelizing with numpy
