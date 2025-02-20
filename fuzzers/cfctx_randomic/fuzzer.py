# Copyright 2020 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
"""Integration code for AFLplusplus fuzzer."""

import os

from fuzzers.cfctx_basic import fuzzer as aflplusplus_fuzzer


def build():  # pylint: disable=too-many-branches,too-many-statements
    """Build benchmark."""
    os.environ["CGC_STRATEGY"] = "randomic"
    os.environ["CGC_MAXMAP"] = "262144"  # 256kb
    aflplusplus_fuzzer.build("pcguard", "cmplog", "dict2file", "no_icp")


def fuzz(input_corpus, output_corpus, target_binary):
    """Run fuzzer."""
    aflplusplus_fuzzer.fuzz(input_corpus, output_corpus, target_binary)
