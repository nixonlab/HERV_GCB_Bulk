# HERV_GCB_Bulk

Analysis of bulk RNA-Seq data from the Germinal Center. 

**Paper:** Holmes, A. B., Corinaldesi, C., Shen, Q., Kumar, R., Compagno, N., Wang, Z., ... & Basso, K. (2020). Single-cell analysis of germinal-center B cells informs on lymphoma cell of origin and outcome. Journal of Experimental Medicine, 217(10).
Chicago	


**To get DAG:** 

``` snakemake --profile profiles/aws  --forceall --dag | dot -Tpdf > dag.pdf   ```

**To get rule graph:** 

``` snakemake --profile profiles/aws  --forceall --rulegraph | dot -Tpdf > rulegraph.pdf   ```

**To get file graph:** 

``` snakemake --profile profiles/aws  --forceall --filegraph | dot -Tpdf > filegraph.pdf   ```

**To run pipeline:**

``` snakemake --profile profiles/aws/ all ```

**To modify pipeline::* 

Change SRA sample table. 
