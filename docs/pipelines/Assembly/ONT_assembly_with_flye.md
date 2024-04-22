# ONT_assembly_with_flye
Perform single sample genome assembly on ONT reads from one or more flow cells. The workflow merges multiple samples into a single BAM prior to genome assembly and variant calling.

## Inputs

### Required inputs
<p name="ONT_assembly_with_flye.fastq">
        <b>ONT_assembly_with_flye.fastq</b><br />
        <i>File &mdash; Default: None</i><br />
        ???
</p>
<p name="ONT_assembly_with_flye.participant_name">
        <b>ONT_assembly_with_flye.participant_name</b><br />
        <i>String &mdash; Default: None</i><br />
        ???
</p>
<p name="ONT_assembly_with_flye.prefix">
        <b>ONT_assembly_with_flye.prefix</b><br />
        <i>String &mdash; Default: None</i><br />
        ???
</p>
<p name="ONT_assembly_with_flye.ref_map_file">
        <b>ONT_assembly_with_flye.ref_map_file</b><br />
        <i>File &mdash; Default: None</i><br />
        ???
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
<p name="ONT_assembly_with_flye.genome_size">
        <b>ONT_assembly_with_flye.genome_size</b><br />
        <i>Int &mdash; Default: 3900000</i><br />
        ???
</p>
<p name="ONT_assembly_with_flye.medaka_model">
        <b>ONT_assembly_with_flye.medaka_model</b><br />
        <i>String &mdash; Default: "r941_prom_high_g360"</i><br />
        ???
</p>
<p name="ONT_assembly_with_flye.MedakaPolish.runtime_attr_override">
        <b>ONT_assembly_with_flye.MedakaPolish.runtime_attr_override</b><br />
        <i>RuntimeAttr? &mdash; Default: None</i><br />
        ???
</p>
<p name="ONT_assembly_with_flye.out_root_dir">
        <b>ONT_assembly_with_flye.out_root_dir</b><br />
        <i>String &mdash; Default: "pipeline"</i><br />
        ???
</p>
</details>

## Outputs
<p name="ONT_assembly_with_flye.assembly">
        <b>ONT_assembly_with_flye.assembly</b><br />
        <i>File</i><br />
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
<p name="ONT_assembly_with_flye.polished_assembly">
        <b>ONT_assembly_with_flye.polished_assembly</b><br />
        <i>File</i><br />
        ???
</p>

<hr />

> Generated using WDL AID (1.0.0)
