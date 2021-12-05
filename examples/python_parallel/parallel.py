import multiprocess
import time


def slow_function(i):
    time.sleep(0.1)
    return i + 1


num_iterations = 100

# Non-parallel:
start_time = time.time()
result = list(map(slow_function, range(num_iterations)))
end_time = time.time()

print("Non-parallel compute time: " + str(end_time - start_time) + " seconds.")


# Parallel:
n_cores = multiprocess.cpu_count()
start_time = time.time()
with multiprocess.Pool(n_cores) as p:
    result = p.map(slow_function, range(num_iterations))
end_time = time.time()

print(
    "Parallel compute time on "
    + str(n_cores)
    + " cores: "
    + str(end_time - start_time)
    + str(" seconds")
)
