SAMPLES={"C000GEW":"/home/karastoo/SCRATCH/calls/C000GEW.g.vcf.gz",
"C000V1C":"/home/karastoo/SCRATCH/calls/C000V1C.g.vcf.gz",
"C000V19":"/home/karastoo/SCRATCH/calls/C000V19.g.vcf.gz",
"C000GEU":"/home/karastoo/SCRATCH/calls/C000GEU.g.vcf.gz",
"C000V1D":"/home/karastoo/SCRATCH/calls/C000V1D.g.vcf.gz",
"C000GEO":"/home/karastoo/SCRATCH/calls/C000GEO.g.vcf.gz",
"C000GEZ":"/home/karastoo/SCRATCH/calls/C000GEZ.g.vcf.gz",
"C000GES":"/home/karastoo/SCRATCH/calls/C000GES.g.vcf.gz",
"C000V1E":"/home/karastoo/SCRATCH/calls/C000V1E.g.vcf.gz",
"C000V18":"/home/karastoo/SCRATCH/calls/C000V18.g.vcf.gz",
"C000GFA":"/home/karastoo/SCRATCH/calls/C000GFA.g.vcf.gz",
"C000GEQ":"/home/karastoo/SCRATCH/calls/C000GEQ.g.vcf.gz",
"C000V1B":"/home/karastoo/SCRATCH/calls/C000V1B.g.vcf.gz",
"C000GF8":"/home/karastoo/SCRATCH/calls/C000GF8.g.vcf.gz",
"C000GER":"/home/karastoo/SCRATCH/calls/C000GER.g.vcf.gz",
"C000GEP":"/home/karastoo/SCRATCH/calls/C000GEP.g.vcf.gz",
"C000V1A":"/home/karastoo/SCRATCH/calls/C000V1A.g.vcf.gz",
"C000GEV":"/home/karastoo/SCRATCH/calls/C000GEV.g.vcf.gz",
"C000GEN":"/home/karastoo/SCRATCH/calls/C000GEN.g.vcf.gz",
"C000GF0":"/home/karastoo/SCRATCH/calls/C000GF0.g.vcf.gz",
"C000V1G":"/home/karastoo/SCRATCH/calls/C000V1G.g.vcf.gz",
"C000V1F":"/home/karastoo/SCRATCH/calls/C000V1F.g.vcf.gz",
"C000GET":"/home/karastoo/SCRATCH/calls/C000GET.g.vcf.gz",
"C000GF9":"/home/karastoo/SCRATCH/calls/C000GF9.g.vcf.gz"
}



rule combine_GVCF:
  input:
    ref="/LAB-DATA/BiRD/resources/species/human/cng.fr/hs37d5/hs37d5_all_chr.fasta",
    gvcfs=expand("/SCRATCH-BIRD/users/karastoo/calls/{sample}.g.vcf.gz", sample=SAMPLES.keys())
  output:
    gvcf="/SCRATCH-BIRD/users/karastoo/calls/all.g.vcf.gz"
  params:
    tmpdir="/SCRATCH-BIRD/users/karastoo/calls/"
  run:
    variant_files = []
    for i in input.gvcfs:
      variant_files.append("--variant " + i)
    variant_files = " ".join(variant_files)
  shell:"""gatk --java-options "-Djava.io.tmpdir={params.tmpdir} -XX:ParallelGCThreads=5 -Xmx10g" CombineGVCFs -R {input.ref} {variant_files} -O {output.gvcf}
      """
