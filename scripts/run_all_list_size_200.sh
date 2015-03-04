#!/bin/scripts/sh

echo "###################### SMR 200, u0, u10, u50, u100"
./scripts/scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_smr_harris_opt -d3000 -u0    -i128 -r256
./scripts/scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_smr_harris_opt -d3000 -u10   -i128 -r256
./scripts/scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_smr_harris_opt -d3000 -u50   -i128 -r256
./scripts/scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_smr_harris_opt -d3000 -u100  -i128 -r256

echo "###################### SMR no MEMBAR 200, u0, u10, u50, u100"
./scripts/scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_smr_no_membar_harris_opt -d3000 -u0   -i128 -r256
./scripts/scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_smr_no_membar_harris_opt -d3000 -u10  -i128 -r256
./scripts/scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_smr_no_membar_harris_opt -d3000 -u50  -i128 -r256
./scripts/scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_smr_no_membar_harris_opt -d3000 -u100 -i128 -r256

echo "###################### OPT 0 200, u0, u10, u50, u100"
./scripts/scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_smr_no_membar_igor_opt0 -d3000 -u0   -i128 -r256
./scripts/scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_smr_no_membar_igor_opt0 -d3000 -u10  -i128 -r256
./scripts/scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_smr_no_membar_igor_opt0 -d3000 -u50  -i128 -r256
./scripts/scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_smr_no_membar_igor_opt0 -d3000 -u100 -i128 -r256

echo "###################### OPT 1 200, u0, u10, u50, u100"
./scripts/scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_smr_no_membar_igor_opt1 -d3000 -u0   -i128 -r256
./scripts/scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_smr_no_membar_igor_opt1 -d3000 -u10  -i128 -r256
./scripts/scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_smr_no_membar_igor_opt1 -d3000 -u50  -i128 -r256
./scripts/scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_smr_no_membar_igor_opt1 -d3000 -u100 -i128 -r256

echo "###################### OPT 2 200, u0, u10, u50, u100"
./scripts/scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_smr_no_membar_igor_opt2 -d3000 -u0   -i128 -r256
./scripts/scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_smr_no_membar_igor_opt2 -d3000 -u10  -i128 -r256
./scripts/scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_smr_no_membar_igor_opt2 -d3000 -u50  -i128 -r256
./scripts/scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_smr_no_membar_igor_opt2 -d3000 -u100 -i128 -r256

echo "###################### OPT 3 200, u0, u10, u50, u100"
./scripts/scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_smr_no_membar_igor_opt3 -d3000 -u0   -i128 -r256
./scripts/scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_smr_no_membar_igor_opt3 -d3000 -u10  -i128 -r256
./scripts/scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_smr_no_membar_igor_opt3 -d3000 -u50  -i128 -r256
./scripts/scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_smr_no_membar_igor_opt3 -d3000 -u100 -i128 -r256

echo "###################### OPT 4 200, u0, u10, u50, u100"
./scripts/scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_smr_no_membar_igor_opt4 -d3000 -u0   -i128 -r256
./scripts/scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_smr_no_membar_igor_opt4 -d3000 -u10  -i128 -r256
./scripts/scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_smr_no_membar_igor_opt4 -d3000 -u50  -i128 -r256
./scripts/scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_smr_no_membar_igor_opt4 -d3000 -u100 -i128 -r256

echo "###################### OPT 5 200, u0, u10, u50, u100"
./scripts/scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_smr_no_membar_igor_opt5 -d3000 -u0   -i128 -r256
./scripts/scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_smr_no_membar_igor_opt5 -d3000 -u10  -i128 -r256
./scripts/scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_smr_no_membar_igor_opt5 -d3000 -u50  -i128 -r256
./scripts/scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_smr_no_membar_igor_opt5 -d3000 -u100 -i128 -r256

echo "###################### OPT 6 200, u0, u10, u50, u100"
./scripts/scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_smr_no_membar_igor_opt6 -d3000 -u0   -i128 -r256
./scripts/scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_smr_no_membar_igor_opt6 -d3000 -u10  -i128 -r256
./scripts/scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_smr_no_membar_igor_opt6 -d3000 -u50  -i128 -r256
./scripts/scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_smr_no_membar_igor_opt6 -d3000 -u100 -i128 -r256

echo "###################### OPT 7 200, u0, u10, u50, u100"
./scripts/scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_smr_no_membar_igor_opt7 -d3000 -u0   -i128 -r256
./scripts/scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_smr_no_membar_igor_opt7 -d3000 -u10  -i128 -r256
./scripts/scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_smr_no_membar_igor_opt7 -d3000 -u50  -i128 -r256
./scripts/scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_smr_no_membar_igor_opt7 -d3000 -u100 -i128 -r256