#!/bin/bash
PYTHONPATH=. python3 experiment/run_experiment.py \
	--experiment-config exp_config.yaml \
	--benchmarks freetype2-2017 \
	--experiment-name tttestfuzzer \
	--fuzzers afl che_fuzz
