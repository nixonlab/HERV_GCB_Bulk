#! /usr/bin/env python
# -*- coding utf-8 -*-

################################### FASTQC ###################################

rule fastqc:
    conda: "../envs/fastqc.yaml"
    output:
        R1 = "results/fastqc/{samid}/{samid}_R1_001_fastqc.html",
        R2 = "results/fastqc/{samid}/{samid}_R2_001_fastqc.html"
    input:
        R1 = "samples/{samid}_1.fastq.gz",
        R2 = "samples/{samid}_2.fastq.gz"
    benchmark:
        "benchmarks/fastqc/{samid}_fastqc.tsv"
    params:
        output_prefix = "results/fastqc/{samid}"
    log:
        "results/fastqc/{samid}/{samid}_fastqc.log"
    threads: config['fastqc_threads']
    shell:
        """
        fastqc -t {threads} -o {params.output_prefix} {input} 2> {log}
        """
