# ONT_assembly_with_flye
Perform single sample genome assembly on ONT reads and variant calling.

## Inputs

### Required inputs
<p name="ONT_assembly_with_flye.fastqs">
        <b>ONT_assembly_with_flye.fastqs</b><br />
        <i>Array[File]+ &mdash; Default: None</i><br />
        input fastq files for a sample
</p>
<p name="ONT_assembly_with_flye.participant_name">
        <b>ONT_assembly_with_flye.participant_name</b><br />
        <i>String &mdash; Default: None</i><br />
        name of the participant from whom these samples were obtained
</p>
<p name="ONT_assembly_with_flye.prefix">
        <b>ONT_assembly_with_flye.prefix</b><br />
        <i>String &mdash; Default: None</i><br />
        prefix for output files
</p>
<p name="ONT_assembly_with_flye.reference">
        <b>ONT_assembly_with_flye.reference</b><br />
        <i>File &mdash; Default: None</i><br />
        reference sequence
</p>

### Other inputs
<details>
<summary> Show/Hide </summary>
<p name="ONT_assembly_with_flye.CallAssemblyVariants.AlignAsPAF.runtime_attr_override">
        <b>ONT_assembly_with_flye.CallAssemblyVariants.AlignAsPAF.runtime_attr_override</b><br />
        <i>RuntimeAttr? &mdash; Default: None</i><br />
        ???
</p>
<p name="ONT_assembly_with_flye.CallAssemblyVariants.Paftools.runtime_attr_override">
        <b>ONT_assembly_with_flye.CallAssemblyVariants.Paftools.runtime_attr_override</b><br />
        <i>RuntimeAttr? &mdash; Default: None</i><br />
        ???
</p>
<p name="ONT_assembly_with_flye.ComputeGenomeLength.runtime_attr_override">
        <b>ONT_assembly_with_flye.ComputeGenomeLength.runtime_attr_override</b><br />
        <i>RuntimeAttr? &mdash; Default: None</i><br />
        ???
</p>
<p name="ONT_assembly_with_flye.Flye.Assemble.runtime_attr_override">
        <b>ONT_assembly_with_flye.Flye.Assemble.runtime_attr_override</b><br />
        <i>RuntimeAttr? &mdash; Default: None</i><br />
        ???
</p>
<p name="ONT_assembly_with_flye.medaka_model">
        <b>ONT_assembly_with_flye.medaka_model</b><br />
        <i>String &mdash; Default: "r941_min_high_g360"</i><br />
        Medaka polishing model name
</p>
<p name="ONT_assembly_with_flye.MedakaPolish.runtime_attr_override">
        <b>ONT_assembly_with_flye.MedakaPolish.runtime_attr_override</b><br />
        <i>RuntimeAttr? &mdash; Default: None</i><br />
        ???
</p>
<p name="ONT_assembly_with_flye.MergeFastqs.prefix">
        <b>ONT_assembly_with_flye.MergeFastqs.prefix</b><br />
        <i>String &mdash; Default: "merged"</i><br />
        ???
</p>
<p name="ONT_assembly_with_flye.MergeFastqs.runtime_attr_override">
        <b>ONT_assembly_with_flye.MergeFastqs.runtime_attr_override</b><br />
        <i>RuntimeAttr? &mdash; Default: None</i><br />
        ???
</p>
<p name="ONT_assembly_with_flye.n_rounds">
        <b>ONT_assembly_with_flye.n_rounds</b><br />
        <i>Int &mdash; Default: 1</i><br />
        number of medaka polishing rounds
</p>
<p name="ONT_assembly_with_flye.Quast.is_large">
        <b>ONT_assembly_with_flye.Quast.is_large</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        ???
</p>
<p name="ONT_assembly_with_flye.Quast.runtime_attr_override">
        <b>ONT_assembly_with_flye.Quast.runtime_attr_override</b><br />
        <i>RuntimeAttr? &mdash; Default: None</i><br />
        ???
</p>
</details>

## Outputs
<p name="ONT_assembly_with_flye.assembly">
        <b>ONT_assembly_with_flye.assembly</b><br />
        <i>File</i><br />
        ???
</p>
<p name="ONT_assembly_with_flye.contigs_reports">
        <b>ONT_assembly_with_flye.contigs_reports</b><br />
        <i>File?</i><br />
        ???
</p>
<p name="ONT_assembly_with_flye.gassembly">
        <b>ONT_assembly_with_flye.gassembly</b><br />
        <i>File</i><br />
        ???
</p>
<p name="ONT_assembly_with_flye.paf">
        <b>ONT_assembly_with_flye.paf</b><br />
        <i>File</i><br />
        ???
</p>
<p name="ONT_assembly_with_flye.paftools_vcf">
        <b>ONT_assembly_with_flye.paftools_vcf</b><br />
        <i>File</i><br />
        ???
</p>
<p name="ONT_assembly_with_flye.plots">
        <b>ONT_assembly_with_flye.plots</b><br />
        <i>Array[File]</i><br />
        ???
</p>
<p name="ONT_assembly_with_flye.polished_assembly">
        <b>ONT_assembly_with_flye.polished_assembly</b><br />
        <i>File</i><br />
        ???
</p>
<p name="ONT_assembly_with_flye.quast_summary">
        <b>ONT_assembly_with_flye.quast_summary</b><br />
        <i>Map[String,String]</i><br />
        ???
</p>
<p name="ONT_assembly_with_flye.report_html">
        <b>ONT_assembly_with_flye.report_html</b><br />
        <i>File</i><br />
        ???
</p>
<p name="ONT_assembly_with_flye.report_in_various_formats">
        <b>ONT_assembly_with_flye.report_in_various_formats</b><br />
        <i>Array[File]</i><br />
        ???
</p>
<p name="ONT_assembly_with_flye.report_txt">
        <b>ONT_assembly_with_flye.report_txt</b><br />
        <i>File</i><br />
        ???
</p>

<hr />

> Generated using WDL AID (1.0.0)
