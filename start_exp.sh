#!/bin/bash
PYTHONPATH=. python3 experiment/run_experiment.py \
	--experiment-config exp_config.yaml \
	--benchmarks freetype2-2017 bloaty_fuzz_target \
	--experiment-name chefuzzer \
	--fuzzers afl libfuzzer che_fuzz
