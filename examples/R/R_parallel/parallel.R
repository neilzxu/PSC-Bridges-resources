library(parallel)

num_iterations <- 100

slow_function <- function(i)
{
  Sys.sleep(0.1)
  return(i + 1)
}

# Non-parallel:
start_time <- Sys.time()
result <- unlist(lapply(1:num_iterations, slow_function))
end_time <- Sys.time()

time_elapsed <- difftime(end_time, start_time, units = "secs")

print(paste("Non-parallel compute time:", time_elapsed, "seconds."))

# Parallel:
n_cores <- detectCores()

start_time <- Sys.time()
result <- unlist(mclapply(1:num_iterations, slow_function, mc.cores=n_cores))
end_time <- Sys.time()

time_elapsed <- difftime(end_time, start_time, units = "secs")

print(paste("Parallel compute time on", n_cores, "cores:", time_elapsed, "seconds."))


