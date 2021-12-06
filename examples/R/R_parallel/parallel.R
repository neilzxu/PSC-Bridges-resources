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


