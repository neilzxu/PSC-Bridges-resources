
# Table of Contents

1.  [Zero to Hero: XSEDE, PSC, and Bridges](#zero-to-hero-xsede-psc-and-bridges)
    1.  [Account setup](#account-setup)
        1.  [Creating account](#creating-account)
        2.  [Requesting an allocation](#requesting-an-allocation)
        3.  [Getting added to an allocation](#getting-added-to-an-allocation)
    2.  [Running your first job](#running-your-first-job)
        1.  [Logging into Bridges2/PSC via `ssh`](#logging-into-bridges2psc-via-ssh)
        2.  [Creating a Slurm job script](#creating-a-slurm-job-script)
        3.  [Parallel computation](#parallel-computation)
    3.  [Advanced](#advanced)


<a id="zero-to-hero-xsede-psc-and-bridges"></a>

# Zero to Hero: XSEDE, PSC, and Bridges


<a id="account-setup"></a>

## Account setup


<a id="creating-account"></a>

### Creating account

If you do not already have an XSEDE account, you can create one
[here](https://portal.xsede.org/my-xsede?p_p_id=58&p_p_lifecycle=0&p_p_state=maximized&p_p_mode=view&_58_struts_action=%2Flogin%2Fcreate_account).


<a id="requesting-an-allocation"></a>

### Requesting an allocation

TODO


<a id="getting-added-to-an-allocation"></a>

### Getting added to an allocation

To use compute resources, you will need to be added to an XSEDE
allocation. Your PI and/or allocation manager can add you as a user to a
specific project
[here](https://portal.xsede.org/group/xup/add-remove-user).


<a id="running-your-first-job"></a>

## Running your first job


<a id="logging-into-bridges2psc-via-ssh"></a>

### Logging into Bridges2/PSC via `ssh`

Start by =ssh=ing into the bridges2 server at port 2222:

    ssh -p 2222 <username>@bridges2.psc.edu

You will be prompted for your XSEDE credentials. Use your XSEDE User
Portal password.

***Tip:*** TODO Add tip about .bashrc etc.

***Warning:*** TODO add warning about randomness when parallelizing


<a id="creating-a-slurm-job-script"></a>

### Creating a Slurm job script

Bridges-2 uses a job-scheduling system called &ldquo;Slurm&rdquo;, providing a way
for users like ourselves to request specific resources for our compute
jobs and automatically launch jobs once said resources have become
available.

Jobs are submitted using the `sbatch` command along with a **batch
script** which we will create. These batch scripts take the following
general form.

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


<a id="parallel-computation"></a>

### Parallel computation

1.  [Python](examples/python/python_parallel/README.md)

2.  [R](examples/R/R_parallel/README.md)


<a id="advanced"></a>

## Advanced

TODO

