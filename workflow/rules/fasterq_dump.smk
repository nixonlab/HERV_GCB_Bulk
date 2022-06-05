# ! /usr/bin/env python
# -*- coding: utf-8 -*-

"""
Download FASTQs
"""

rule fasterq_dump:
    conda: "../envs/sra.yaml"
    output:
        temp("runs/{runid}/{runid}.fastq")
    params:
        outdir = "runs/{runid}"
    threads: 8
    resources:
        mem_mb = 10000, disk_mb = 60000
    log: "runs/{runid}/fasterq_sra_to_fastq.log"
    shell:
        """
        fastq-dump --split-3 --skip-technical -O {params.outdir} {wildcards.runid} &> {log[0]}
        """

rule cat_runids_to_samples:
    input:
        single = lambda wc: expand("runs/{s}/{s}.fastq", s=SAMPLE_RUN[wc.samid]) # input fastqs per run
    output:
        single = "samples/{samid}.fastq.gz"
    shell:
        """
        cat {input.single} | gzip > {output.single}
        """

rule conversion_complete:
    input:
        expand("samples/{samid}.fastq.gz", samid=SAMPLES)
