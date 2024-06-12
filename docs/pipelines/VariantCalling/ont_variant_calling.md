# ont_variant_calling
A workflow that performs single sample variant calling on Oxford Nanopore reads from one or more flow cells. The workflow merges multiple flowcells into a single BAM prior to variant calling.

## Inputs

### Required inputs
<p name="ont_variant_calling.aligned_bais">
        <b>ont_variant_calling.aligned_bais</b><br />
        <i>Array[File]+ &mdash; Default: None</i><br />
        ???
</p>
<p name="ont_variant_calling.aligned_bams">
        <b>ont_variant_calling.aligned_bams</b><br />
        <i>Array[File]+ &mdash; Default: None</i><br />
        ???
</p>
<p name="ont_variant_calling.reference">
        <b>ont_variant_calling.reference</b><br />
        <i>File &mdash; Default: None</i><br />
        ???
</p>
<p name="ont_variant_calling.reference_dict">
        <b>ont_variant_calling.reference_dict</b><br />
        <i>File &mdash; Default: None</i><br />
        ???
</p>
<p name="ont_variant_calling.reference_fai">
        <b>ont_variant_calling.reference_fai</b><br />
        <i>File &mdash; Default: None</i><br />
        ???
</p>
<p name="ont_variant_calling.sample_name">
        <b>ont_variant_calling.sample_name</b><br />
        <i>String &mdash; Default: None</i><br />
        ???
</p>

### Other inputs
<details>
<summary> Show/Hide </summary>
<p name="ont_variant_calling.bed_to_compute_coverage">
        <b>ont_variant_calling.bed_to_compute_coverage</b><br />
        <i>File? &mdash; Default: None</i><br />
        ???
</p>
<p name="ont_variant_calling.call_small_variants">
        <b>ont_variant_calling.call_small_variants</b><br />
        <i>Boolean &mdash; Default: true</i><br />
        ???
</p>
<p name="ont_variant_calling.call_svs">
        <b>ont_variant_calling.call_svs</b><br />
        <i>Boolean &mdash; Default: true</i><br />
        ???
</p>
<p name="ont_variant_calling.CallVariantsONT.Clair.chr">
        <b>ont_variant_calling.CallVariantsONT.Clair.chr</b><br />
        <i>String? &mdash; Default: None</i><br />
        ???
</p>
<p name="ont_variant_calling.CallVariantsONT.Clair.runtime_attr_override">
        <b>ont_variant_calling.CallVariantsONT.Clair.runtime_attr_override</b><br />
        <i>RuntimeAttr? &mdash; Default: None</i><br />
        ???
</p>
<p name="ont_variant_calling.CallVariantsONT.minsvlen">
        <b>ont_variant_calling.CallVariantsONT.minsvlen</b><br />
        <i>Int &mdash; Default: 50</i><br />
        ???
</p>
<p name="ont_variant_calling.CallVariantsONT.Sniffles2SV.runtime_attr_override">
        <b>ont_variant_calling.CallVariantsONT.Sniffles2SV.runtime_attr_override</b><br />
        <i>RuntimeAttr? &mdash; Default: None</i><br />
        ???
</p>
<p name="ont_variant_calling.CallVariantsONT.ZipAndIndexClair_gVCF.runtime_attr_override">
        <b>ont_variant_calling.CallVariantsONT.ZipAndIndexClair_gVCF.runtime_attr_override</b><br />
        <i>RuntimeAttr? &mdash; Default: None</i><br />
        ???
</p>
<p name="ont_variant_calling.CallVariantsONT.ZipAndIndexClairVCF.runtime_attr_override">
        <b>ont_variant_calling.CallVariantsONT.ZipAndIndexClairVCF.runtime_attr_override</b><br />
        <i>RuntimeAttr? &mdash; Default: None</i><br />
        ???
</p>
<p name="ont_variant_calling.CallVariantsONT.ZipAndIndexSnifflesVCF.runtime_attr_override">
        <b>ont_variant_calling.CallVariantsONT.ZipAndIndexSnifflesVCF.runtime_attr_override</b><br />
        <i>RuntimeAttr? &mdash; Default: None</i><br />
        ???
</p>
<p name="ont_variant_calling.coverage.ComputeGenomeLength.runtime_attr_override">
        <b>ont_variant_calling.coverage.ComputeGenomeLength.runtime_attr_override</b><br />
        <i>RuntimeAttr? &mdash; Default: None</i><br />
        ???
</p>
<p name="ont_variant_calling.coverage.NanoPlotFromBam.runtime_attr_override">
        <b>ont_variant_calling.coverage.NanoPlotFromBam.runtime_attr_override</b><br />
        <i>RuntimeAttr? &mdash; Default: None</i><br />
        ???
</p>
<p name="ont_variant_calling.fast_less_sensitive_sv">
        <b>ont_variant_calling.fast_less_sensitive_sv</b><br />
        <i>Boolean? &mdash; Default: true</i><br />
        ???
</p>
<p name="ont_variant_calling.MergeAllReads.runtime_attr_override">
        <b>ont_variant_calling.MergeAllReads.runtime_attr_override</b><br />
        <i>RuntimeAttr? &mdash; Default: None</i><br />
        ???
</p>
<p name="ont_variant_calling.sites_vcf">
        <b>ont_variant_calling.sites_vcf</b><br />
        <i>File? &mdash; Default: None</i><br />
        ???
</p>
<p name="ont_variant_calling.sites_vcf_tbi">
        <b>ont_variant_calling.sites_vcf_tbi</b><br />
        <i>File? &mdash; Default: None</i><br />
        ???
</p>
</details>

## Outputs
<p name="ont_variant_calling.aligned_est_fold_cov">
        <b>ont_variant_calling.aligned_est_fold_cov</b><br />
        <i>Float</i><br />
        ???
</p>
<p name="ont_variant_calling.aligned_frac_bases">
        <b>ont_variant_calling.aligned_frac_bases</b><br />
        <i>Float</i><br />
        ???
</p>
<p name="ont_variant_calling.aligned_num_bases">
        <b>ont_variant_calling.aligned_num_bases</b><br />
        <i>Float</i><br />
        ???
</p>
<p name="ont_variant_calling.aligned_num_reads">
        <b>ont_variant_calling.aligned_num_reads</b><br />
        <i>Float</i><br />
        ???
</p>
<p name="ont_variant_calling.aligned_read_length_mean">
        <b>ont_variant_calling.aligned_read_length_mean</b><br />
        <i>Float</i><br />
        ???
</p>
<p name="ont_variant_calling.aligned_read_length_median">
        <b>ont_variant_calling.aligned_read_length_median</b><br />
        <i>Float</i><br />
        ???
</p>
<p name="ont_variant_calling.aligned_read_length_N50">
        <b>ont_variant_calling.aligned_read_length_N50</b><br />
        <i>Float</i><br />
        ???
</p>
<p name="ont_variant_calling.aligned_read_length_stdev">
        <b>ont_variant_calling.aligned_read_length_stdev</b><br />
        <i>Float</i><br />
        ???
</p>
<p name="ont_variant_calling.average_identity">
        <b>ont_variant_calling.average_identity</b><br />
        <i>Float</i><br />
        ???
</p>
<p name="ont_variant_calling.clair_gtbi">
        <b>ont_variant_calling.clair_gtbi</b><br />
        <i>File?</i><br />
        ???
</p>
<p name="ont_variant_calling.clair_gvcf">
        <b>ont_variant_calling.clair_gvcf</b><br />
        <i>File?</i><br />
        ???
</p>
<p name="ont_variant_calling.clair_tbi">
        <b>ont_variant_calling.clair_tbi</b><br />
        <i>File?</i><br />
        ???
</p>
<p name="ont_variant_calling.clair_vcf">
        <b>ont_variant_calling.clair_vcf</b><br />
        <i>File?</i><br />
        ???
</p>
<p name="ont_variant_calling.median_identity">
        <b>ont_variant_calling.median_identity</b><br />
        <i>Float</i><br />
        ???
</p>
<p name="ont_variant_calling.sniffles_tbi">
        <b>ont_variant_calling.sniffles_tbi</b><br />
        <i>File?</i><br />
        ???
</p>
<p name="ont_variant_calling.sniffles_vcf">
        <b>ont_variant_calling.sniffles_vcf</b><br />
        <i>File?</i><br />
        ???
</p>

<hr />

> Generated using WDL AID (1.0.0)
