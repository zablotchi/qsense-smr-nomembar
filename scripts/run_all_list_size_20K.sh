#!/bin/sh
echo "###################### HYBRID 20K, u0, u10, u50, u100"
./scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_hybrid_harris_opt -d3000 -u0   -i10000 -r20000
./scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_hybrid_harris_opt -d3000 -u10  -i10000 -r20000
./scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_hybrid_harris_opt -d3000 -u50  -i10000 -r20000
./scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_hybrid_harris_opt -d3000 -u100 -i10000 -r20000

echo "###################### QSBR 20K, u0, u10, u50, u100"
./scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_qsbr_harris_opt -d3000 -u0   -i10000 -r20000
./scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_qsbr_harris_opt -d3000 -u10  -i10000 -r20000
./scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_qsbr_harris_opt -d3000 -u50  -i10000 -r20000
./scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_qsbr_harris_opt -d3000 -u100 -i10000 -r20000

echo "###################### SMR 20K, u0, u10, u50, u100"
./scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_smr_harris_opt -d3000 -u0  -i10000 -r20000
./scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_smr_harris_opt -d3000 -u10 -i10000 -r20000
./scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_smr_harris_opt -d3000 -u50 -i10000 -r20000
./scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_smr_harris_opt -d3000 -u100 -i10000 -r20000

echo "###################### SMR no MEMBAR 20K, u0, u10, u50, u100"
./scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_smr_no_membar_harris_opt -d3000 -u0   -i10000 -r20000
./scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_smr_no_membar_harris_opt -d3000 -u10  -i10000 -r20000
./scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_smr_no_membar_harris_opt -d3000 -u50  -i10000 -r20000
./scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_smr_no_membar_harris_opt -d3000 -u100 -i10000 -r20000

echo "###################### HARRIS OPT 20K, u0, u10, u50, u100"
./scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_harris_opt -d3000 -u0   -i10000 -r20000
./scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_harris_opt -d3000 -u10  -i10000 -r20000
./scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_harris_opt -d3000 -u50  -i10000 -r20000
./scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_harris_opt -d3000 -u100 -i10000 -r20000

echo "###################### HYBRID LAZY 20K, u0, u10, u50, u100"
./scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_hybrid_lazy -d3000 -u0   -i10000 -r20000
./scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_hybrid_lazy -d3000 -u10  -i10000 -r20000
./scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_hybrid_lazy -d3000 -u50  -i10000 -r20000
./scalability_rep.sh "1 2 4 8 16 32 48" 5 median ./bin/lf-ll_hybrid_lazy -d3000 -u100 -i10000 -r20000
