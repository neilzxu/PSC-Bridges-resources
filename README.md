# Zero to Hero: XSEDE, PSC, and Bridges 

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

### Parallel computation

#### [Python](examples/python/python_parallel/README.md) 

#### [R](examples/R/R_parallel/README.md)

## Advanced

TODO
