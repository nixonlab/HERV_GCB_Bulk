# ! /usr/bin/env python
# -*- coding: utf-8 -*-

"""
Download FASTQs
"""

rule fasterq_dump:
    conda: "../envs/sra.yaml"
    output:
        temp("runs/{s}/{s}/{s}.sra"),
        temp("runs/{s}/{s}_1.fastq"),
        temp("runs/{s}/{s}_2.fastq")
    params:
        outdir = "runs/{s}",
        sra_outdir = "runs/{s}/{s}"
    threads: 8
    resources:
        mem_mb = 10000, disk_mb = 60000
    log: "runs/{s}/fasterq_sra_to_fastq.log"
    shell:
        """
        prefetch -O {params.outdir} {wildcards.s}
        fastq-dump --split-3 --skip-technical --origfmt -O {params.outdir} {params.sra_outdir} &> {log[0]}
        """

rule cat_runids_to_samples:
    input:
        R1 = lambda wc: expand("runs/{s}/{s}_1.fastq", s=SAMPLE_RUN[wc.samid]), # input fastqs per run
        R2 = lambda wc: expand("runs/{s}/{s}_2.fastq", s=SAMPLE_RUN[wc.samid])
    output:
        R1 = temp('samples/{samid}_1.fastq'), # output fastqs per sample
        R2 = temp('samples/{samid}_2.fastq')
    shell:
        """
        cat {input.R1} > {output.R1} # fastqs belonging to same sample (multipe runs) are combined
        cat {input.R2} > {output.R2} # fastqs belonging to same sample (multipe runs) are combined
        """
