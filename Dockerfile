FROM ubuntu:24.04

WORKDIR /usr/src/app

RUN apt-get update -y \
    && apt-get install -y build-essential g++-12 g++-13 g++-14 cmake ninja-build git wget software-properties-common gnupg \
    && wget https://apt.llvm.org/llvm.sh \
    && chmod +x llvm.sh \
    && ./llvm.sh 17 all \
    && ./llvm.sh 18 all \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*


COPY . ./

# RUN cmake -B build-llvm16 -DCMAKE_CXX_COMPILER=clang++-16 && cmake --build build-llvm16 --config Release && ctest --test-dir build-llvm16 --build-config Release --output-on-failure
RUN cmake -B build-llvm17 -DCMAKE_CXX_COMPILER=clang++-17 && cmake --build build-llvm17 --config Release && ctest --test-dir build-llvm17 --build-config Release --output-on-failure
RUN cmake -B build-llvm18 -DCMAKE_CXX_COMPILER=clang++-18 && cmake --build build-llvm18 --config Release && ctest --test-dir build-llvm18 --build-config Release --output-on-failure
RUN cmake -B build-gcc12 -DCMAKE_CXX_COMPILER=g++-12 && cmake --build build-gcc12 --config Release && ctest --test-dir build-gcc12 --build-config Release --output-on-failure
RUN cmake -B build-gcc13 -DCMAKE_CXX_COMPILER=g++-13 && cmake --build build-gcc13 --config Release && ctest --test-dir build-gcc13 --build-config Release --output-on-failure
RUN cmake -B build-gcc14 -DCMAKE_CXX_COMPILER=g++-14 && cmake --build build-gcc14 --config Release && ctest --test-dir build-gcc14 --build-config Release --output-on-failure


# RUN cmake -B build -G Ninja -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && ctest --test-dir build --build-config Release --output-on-failure && cmake --install build