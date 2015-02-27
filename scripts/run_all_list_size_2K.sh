#!/bi./scripts/sh
echo "###################### HYBRID 2K, u0, u10, u50, u100"
./scripts/scalability_rep.sh "1 2 4 8 16 32 40 80" 5 median ./bin/lf-ll_hybrid_harris_opt -d3000 -u0 -i1024 -r2048
./scripts/scalability_rep.sh "1 2 4 8 16 32 40 80" 5 median ./bin/lf-ll_hybrid_harris_opt -d3000 -u10 -i1024 -r2048
./scripts/scalability_rep.sh "1 2 4 8 16 32 40 80" 5 median ./bin/lf-ll_hybrid_harris_opt -d3000 -u50 -i1024 -r2048
./scripts/scalability_rep.sh "1 2 4 8 16 32 40 80" 5 median ./bin/lf-ll_hybrid_harris_opt -d3000 -u100 -i1024 -r2048


echo "###################### QSBR 2K, u0, u10, u50, u100"
./scripts/scalability_rep.sh "1 2 4 8 16 32 40 80" 5 median ./bin/lf-ll_qsbr_harris_opt -d3000 -u0 -i1024 -r2048
./scripts/scalability_rep.sh "1 2 4 8 16 32 40 80" 5 median ./bin/lf-ll_qsbr_harris_opt -d3000 -u10 -i1024 -r2048
./scripts/scalability_rep.sh "1 2 4 8 16 32 40 80" 5 median ./bin/lf-ll_qsbr_harris_opt -d3000 -u50 -i1024 -r2048
./scripts/scalability_rep.sh "1 2 4 8 16 32 40 80" 5 median ./bin/lf-ll_qsbr_harris_opt -d3000 -u100 -i1024 -r2048

echo "###################### SMR 2K, u0, u10, u50, u100"
./scripts/scalability_rep.sh "1 2 4 8 16 32 40 80" 5 median ./bin/lf-ll_smr_harris_opt -d3000 -u0 -i1024 -r2048
./scripts/scalability_rep.sh "1 2 4 8 16 32 40 80" 5 median ./bin/lf-ll_smr_harris_opt -d3000 -u10 -i1024 -r2048
./scripts/scalability_rep.sh "1 2 4 8 16 32 40 80" 5 median ./bin/lf-ll_smr_harris_opt -d3000 -u50 -i1024 -r2048
./scripts/scalability_rep.sh "1 2 4 8 16 32 40 80" 5 median ./bin/lf-ll_smr_harris_opt -d3000 -u100 -i1024 -r2048

echo "###################### SMR no MEMBAR 2K, u0, u10, u50, u100"
./scripts/scalability_rep.sh "1 2 4 8 16 32 40 80" 5 median ./bin/lf-ll_smr_no_membar_harris_opt -d3000 -u0 -i1024 -r2048
./scripts/scalability_rep.sh "1 2 4 8 16 32 40 80" 5 median ./bin/lf-ll_smr_no_membar_harris_opt -d3000 -u10 -i1024 -r2048
./scripts/scalability_rep.sh "1 2 4 8 16 32 40 80" 5 median ./bin/lf-ll_smr_no_membar_harris_opt -d3000 -u50 -i1024 -r2048
./scripts/scalability_rep.sh "1 2 4 8 16 32 40 80" 5 median ./bin/lf-ll_smr_no_membar_harris_opt -d3000 -u100 -i1024 -r2048

echo "###################### HARRIS OPT 2K, u0, u10, u50, u100"
./scripts/scalability_rep.sh "1 2 4 8 16 32 40 80" 5 median ./bin/lf-ll_harris_opt -d3000 -u0 -i1024 -r2048
./scripts/scalability_rep.sh "1 2 4 8 16 32 40 80" 5 median ./bin/lf-ll_harris_opt -d3000 -u10 -i1024 -r2048
./scripts/scalability_rep.sh "1 2 4 8 16 32 40 80" 5 median ./bin/lf-ll_harris_opt -d3000 -u50 -i1024 -r2048
./scripts/scalability_rep.sh "1 2 4 8 16 32 40 80" 5 median ./bin/lf-ll_harris_opt -d3000 -u100 -i1024 -r2048

echo "###################### HYBRID LAZY 2K, u0, u10, u50, u100"
./scripts/scalability_rep.sh "1 2 4 8 16 32 40 80" 5 median ./bin/lf-ll_hybrid_lazy -d3000 -u0 -i1024 -r2048
./scripts/scalability_rep.sh "1 2 4 8 16 32 40 80" 5 median ./bin/lf-ll_hybrid_lazy -d3000 -u10 -i1024 -r2048
./scripts/scalability_rep.sh "1 2 4 8 16 32 40 80" 5 median ./bin/lf-ll_hybrid_lazy -d3000 -u50 -i1024 -r2048
./scripts/scalability_rep.sh "1 2 4 8 16 32 40 80" 5 median ./bin/lf-ll_hybrid_lazy -d3000 -u100 -i1024 -r2048
