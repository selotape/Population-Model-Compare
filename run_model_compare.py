import sys
from model_compare import model_compare
import os

def print_usage_and_leave():
    print(r"Usage: >>> python .\run_model_compare.py .\path\to\gphocs\results")
    exit()

def validate_simulation(simulation):
    assert os.path.isdir(simulation), "\"%s\" is not a directory" % simulation

if __name__ == "__main__":
    simulations = sys.argv[1:]
    if len(simulations) < 1:
        print_usage_and_leave()
    for simulation in simulations:
        validate_simulation(simulation)
        model_compare.model_compare(simulation)