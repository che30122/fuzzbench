#!/bin/bash
PYTHONPATH=. python3 experiment/run_experiment.py \
	--experiment-config exp_config.yaml \
	--benchmarks freetype2-2017 libpng-1.2.56 harfbuzz-1.3.2 openthread-2019-12-23\
	--experiment-name  fastfairche \
	--fuzzers aflfast fairfuzz che_fuzz
