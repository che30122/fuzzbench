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

ARG parent_image
FROM $parent_image

# Download and compile AFL v2.56b.
# Set AFL_NO_X86 to skip flaky tests.
#RUN echo "start"
RUN git clone https://github.com/che30122/AFL.git /afl && \
    cd /afl && \
    AFL_NO_X86=1 make 
RUN apt-get install -y llvm-3.9 llvm-3.9-dev 
RUN apt-get install -y clang-3.9
RUN update-alternatives --install /usr/local/bin/clang clang /usr/bin/clang-3.9 100
RUN update-alternatives --install /usr/local/bin/clang++ clang++ /usr/bin/clang++-3.9 100
RUN update-alternatives --config clang
RUN update-alternatives --config clang++
RUN echo `clang --version`
RUN cd /afl/llvm_mode && export LLVM_CONFIG="llvm-config-3.9" && export cfg_file_path="./CFG" && CFLAGS="" CXXFLAGS="" make

# Use afl_driver.cpp from LLVM as our fuzzing library.
RUN apt-get update && \
    apt-get install wget -y && \
    wget https://raw.githubusercontent.com/llvm/llvm-project/5feb80e748924606531ba28c97fe65145c65372e/compiler-rt/lib/fuzzer/afl/afl_driver.cpp -O /afl/afl_driver.cpp && \
    clang++ -stdlib=libc++ -std=c++11 -O2 -c /afl/afl_driver.cpp && \
	#clang -shared -Wno-pointer-sign -c /afl/llvm_mode/afl-llvm-rt.o.c -I/afl && \
    ar r /libAFL.a *.o
