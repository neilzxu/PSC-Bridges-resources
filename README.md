<h1> Zero to Hero: XSEDE, PSC, and Bridges  </h1>

<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-refresh-toc -->
**Table of Contents**

- [Account setup](#account-setup)
    - [Creating account](#creating-account)
    - [Requesting an allocation](#requesting-an-allocation)
    - [Getting added to an allocation](#getting-added-to-an-allocation)
- [Running your first job](#running-your-first-job)
    - [Logging into Bridges2/PSC via `ssh`](#logging-into-bridges2psc-via-ssh)
    - [Creating a Slurm job script](#creating-a-slurm-job-script)
    - [Parallel computation](#parallel-computation)
        - [[Python](examples/python/python_parallel/README.md)](#pythonexamplespythonpython_parallelreadmemd)
        - [[R](examples/R/R_parallel/README.md)](#rexamplesrr_parallelreadmemd)
- [Advanced](#advanced)

<!-- markdown-toc end -->


## Account setup

### Creating account

If you do not already have an XSEDE account, you can create one 
[here](https://portal.xsede.org/my-xsede?p_p_id=58&p_p_lifecycle=0&p_p_state=maximized&p_p_mode=view&_58_struts_action=%2Flogin%2Fcreate_account).
    
### Requesting an allocation

TODO

### Getting added to an allocation

To use compute resources, you will need to be added to an XSEDE allocation. Your PI and/or allocation manager can add you as a user to a specific project [here](https://portal.xsede.org/group/xup/add-remove-user).


## Running your first job
    
### Logging into Bridges2/PSC via `ssh`

Start by `ssh`ing into the bridges2 server at port 2222:

``` bash
ssh -p 2222 <username>@bridges2.psc.edu
```

You will be prompted for your XSEDE credentials. Use your XSEDE User Portal password.

**_Tip:_** TODO Add tip about .bashrc etc.

**_Warning:_** TODO add warning about randomness when parallelizing

### Creating a Slurm job script

Bridges-2 uses a job-scheduling system called "Slurm", providing a way for users like ourselves to request specific resources for our compute jobs and automatically launch jobs once said resources have become available.

Jobs are submitted using the `sbatch` command along with a **batch script** which we will create. These batch scripts take the following general form.

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



### Parallel computation

#### [Python](examples/python/python_parallel/README.md) 

#### [R](examples/R/R_parallel/README.md)

## Advanced

TODO
