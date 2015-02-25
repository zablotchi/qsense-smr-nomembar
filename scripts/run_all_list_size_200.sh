#!/bin/sh
echo "###################### HYBRID 200, u0, u10, u50, u100"
./scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_hybrid_harris_opt -d3000 -u0   -i128 -r256
./scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_hybrid_harris_opt -d3000 -u10  -i128 -r256
./scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_hybrid_harris_opt -d3000 -u50  -i128 -r256
./scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_hybrid_harris_opt -d3000 -u100 -i128 -r256

echo "###################### QSBR 200, u0, u10, u50, u100"
./scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_qsbr_harris_opt -d3000 -u0   -i128 -r256
./scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_qsbr_harris_opt -d3000 -u10  -i128 -r256
./scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_qsbr_harris_opt -d3000 -u50  -i128 -r256
./scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_qsbr_harris_opt -d3000 -u100 -i128 -r256

echo "###################### SMR 200, u0, u10, u50, u100"
./scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_smr_harris_opt -d3000 -u0    -i128 -r256
./scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_smr_harris_opt -d3000 -u10   -i128 -r256
./scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_smr_harris_opt -d3000 -u50   -i128 -r256
./scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_smr_harris_opt -d3000 -u100  -i128 -r256

echo "###################### SMR no MEMBAR 200, u0, u10, u50, u100"
./scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_smr_no_membar_harris_opt -d3000 -u0   -i128 -r256
./scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_smr_no_membar_harris_opt -d3000 -u10  -i128 -r256
./scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_smr_no_membar_harris_opt -d3000 -u50  -i128 -r256
./scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_smr_no_membar_harris_opt -d3000 -u100 -i128 -r256

echo "###################### HARRIS OPT 200, u0, u10, u50, u100"
./scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_harris_opt -d3000 -u0   -i128 -r256
./scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_harris_opt -d3000 -u10  -i128 -r256
./scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_harris_opt -d3000 -u50  -i128 -r256
./scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_harris_opt -d3000 -u100 -i128 -r256

echo "###################### HYBRID LAZY 200, u0, u10, u50, u100"
./scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_hybrid_lazy -d3000 -u0   -i128 -r256
./scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_hybrid_lazy -d3000 -u10  -i128 -r256
./scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_hybrid_lazy -d3000 -u50  -i128 -r256
./scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_hybrid_lazy -d3000 -u100 -i128 -r256
