# ONT_assembly_with_canu
perform single sample genome assembly on ONT reads using the canu assembler.

## Inputs

### Required inputs
<p name="ONT_assembly_with_canu.fastqs">
        <b>ONT_assembly_with_canu.fastqs</b><br />
        <i>Array[File]+ &mdash; Default: None</i><br />
        ???
</p>
<p name="ONT_assembly_with_canu.participant_name">
        <b>ONT_assembly_with_canu.participant_name</b><br />
        <i>String &mdash; Default: None</i><br />
        ???
</p>
<p name="ONT_assembly_with_canu.prefix">
        <b>ONT_assembly_with_canu.prefix</b><br />
        <i>String &mdash; Default: None</i><br />
        ???
</p>
<p name="ONT_assembly_with_canu.reference">
        <b>ONT_assembly_with_canu.reference</b><br />
        <i>File &mdash; Default: None</i><br />
        ???
</p>

### Other inputs
<details>
<summary> Show/Hide </summary>
<p name="ONT_assembly_with_canu.assemble_error_rate">
        <b>ONT_assembly_with_canu.assemble_error_rate</b><br />
        <i>Float &mdash; Default: 0.15</i><br />
        ???
</p>
<p name="ONT_assembly_with_canu.CallAssemblyVariants.AlignAsPAF.runtime_attr_override">
        <b>ONT_assembly_with_canu.CallAssemblyVariants.AlignAsPAF.runtime_attr_override</b><br />
        <i>RuntimeAttr? &mdash; Default: None</i><br />
        ???
</p>
<p name="ONT_assembly_with_canu.CallAssemblyVariants.Paftools.runtime_attr_override">
        <b>ONT_assembly_with_canu.CallAssemblyVariants.Paftools.runtime_attr_override</b><br />
        <i>RuntimeAttr? &mdash; Default: None</i><br />
        ???
</p>
<p name="ONT_assembly_with_canu.Canu.Assemble.runtime_attr_override">
        <b>ONT_assembly_with_canu.Canu.Assemble.runtime_attr_override</b><br />
        <i>RuntimeAttr? &mdash; Default: None</i><br />
        ???
</p>
<p name="ONT_assembly_with_canu.Canu.Correct.runtime_attr_override">
        <b>ONT_assembly_with_canu.Canu.Correct.runtime_attr_override</b><br />
        <i>RuntimeAttr? &mdash; Default: None</i><br />
        ???
</p>
<p name="ONT_assembly_with_canu.Canu.Trim.runtime_attr_override">
        <b>ONT_assembly_with_canu.Canu.Trim.runtime_attr_override</b><br />
        <i>RuntimeAttr? &mdash; Default: None</i><br />
        ???
</p>
<p name="ONT_assembly_with_canu.ComputeGenomeLength.runtime_attr_override">
        <b>ONT_assembly_with_canu.ComputeGenomeLength.runtime_attr_override</b><br />
        <i>RuntimeAttr? &mdash; Default: None</i><br />
        ???
</p>
<p name="ONT_assembly_with_canu.correct_error_rate">
        <b>ONT_assembly_with_canu.correct_error_rate</b><br />
        <i>Float &mdash; Default: 0.15</i><br />
        ???
</p>
<p name="ONT_assembly_with_canu.medaka_model">
        <b>ONT_assembly_with_canu.medaka_model</b><br />
        <i>String &mdash; Default: "r941_min_high_g360"</i><br />
        ???
</p>
<p name="ONT_assembly_with_canu.MedakaPolish.runtime_attr_override">
        <b>ONT_assembly_with_canu.MedakaPolish.runtime_attr_override</b><br />
        <i>RuntimeAttr? &mdash; Default: None</i><br />
        ???
</p>
<p name="ONT_assembly_with_canu.MergeFastqs.prefix">
        <b>ONT_assembly_with_canu.MergeFastqs.prefix</b><br />
        <i>String &mdash; Default: "merged"</i><br />
        ???
</p>
<p name="ONT_assembly_with_canu.MergeFastqs.runtime_attr_override">
        <b>ONT_assembly_with_canu.MergeFastqs.runtime_attr_override</b><br />
        <i>RuntimeAttr? &mdash; Default: None</i><br />
        ???
</p>
<p name="ONT_assembly_with_canu.Quast.is_large">
        <b>ONT_assembly_with_canu.Quast.is_large</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        ???
</p>
<p name="ONT_assembly_with_canu.Quast.runtime_attr_override">
        <b>ONT_assembly_with_canu.Quast.runtime_attr_override</b><br />
        <i>RuntimeAttr? &mdash; Default: None</i><br />
        ???
</p>
<p name="ONT_assembly_with_canu.trim_error_rate">
        <b>ONT_assembly_with_canu.trim_error_rate</b><br />
        <i>Float &mdash; Default: 0.15</i><br />
        ???
</p>
</details>

## Outputs
<p name="ONT_assembly_with_canu.asm_polished">
        <b>ONT_assembly_with_canu.asm_polished</b><br />
        <i>File</i><br />
        ???
</p>
<p name="ONT_assembly_with_canu.contigs_reports">
        <b>ONT_assembly_with_canu.contigs_reports</b><br />
        <i>File?</i><br />
        ???
</p>
<p name="ONT_assembly_with_canu.paf">
        <b>ONT_assembly_with_canu.paf</b><br />
        <i>File</i><br />
        ???
</p>
<p name="ONT_assembly_with_canu.paftools_vcf">
        <b>ONT_assembly_with_canu.paftools_vcf</b><br />
        <i>File</i><br />
        ???
</p>
<p name="ONT_assembly_with_canu.plots">
        <b>ONT_assembly_with_canu.plots</b><br />
        <i>Array[File]</i><br />
        ???
</p>
<p name="ONT_assembly_with_canu.polished_assembly">
        <b>ONT_assembly_with_canu.polished_assembly</b><br />
        <i>File</i><br />
        ???
</p>
<p name="ONT_assembly_with_canu.quast_summary">
        <b>ONT_assembly_with_canu.quast_summary</b><br />
        <i>Map[String,String]</i><br />
        ???
</p>
<p name="ONT_assembly_with_canu.report_html">
        <b>ONT_assembly_with_canu.report_html</b><br />
        <i>File</i><br />
        ???
</p>
<p name="ONT_assembly_with_canu.report_in_various_formats">
        <b>ONT_assembly_with_canu.report_in_various_formats</b><br />
        <i>Array[File]</i><br />
        ???
</p>
<p name="ONT_assembly_with_canu.report_txt">
        <b>ONT_assembly_with_canu.report_txt</b><br />
        <i>File</i><br />
        ???
</p>

<hr />

> Generated using WDL AID (1.0.0)
