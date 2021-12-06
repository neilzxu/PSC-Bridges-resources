import time

import multiprocess as mp

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
n_cores = mp.cpu_count()
start_time = time.time()
with mp.Pool(n_cores) as p:
    result = p.map(slow_successor, range(num_iterations))
end_time = time.time()

print(
    "Parallel compute time on "
    + str(n_cores)
    + " cores: "
    + str(end_time - start_time)
    + str(" seconds.")
)
