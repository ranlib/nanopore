# ONT_assembly_with_raven
Perform single sample genome assembly on ONT reads and variant calling.

## Inputs

### Required inputs
<p name="ONT_assembly_with_raven.fastqs">
        <b>ONT_assembly_with_raven.fastqs</b><br />
        <i>Array[File]+ &mdash; Default: None</i><br />
        input fastq files for a sample
</p>
<p name="ONT_assembly_with_raven.graphical_fragment_assembly">
        <b>ONT_assembly_with_raven.graphical_fragment_assembly</b><br />
        <i>String &mdash; Default: None</i><br />
        graph file of raven assembly
</p>
<p name="ONT_assembly_with_raven.participant_name">
        <b>ONT_assembly_with_raven.participant_name</b><br />
        <i>String &mdash; Default: None</i><br />
        name of the participant from whom these samples were obtained
</p>
<p name="ONT_assembly_with_raven.prefix">
        <b>ONT_assembly_with_raven.prefix</b><br />
        <i>String &mdash; Default: None</i><br />
        prefix for output files
</p>
<p name="ONT_assembly_with_raven.reference">
        <b>ONT_assembly_with_raven.reference</b><br />
        <i>File &mdash; Default: None</i><br />
        reference sequence
</p>

### Other inputs
<details>
<summary> Show/Hide </summary>
<p name="ONT_assembly_with_raven.CallAssemblyVariants.AlignAsPAF.runtime_attr_override">
        <b>ONT_assembly_with_raven.CallAssemblyVariants.AlignAsPAF.runtime_attr_override</b><br />
        <i>RuntimeAttr? &mdash; Default: None</i><br />
        ???
</p>
<p name="ONT_assembly_with_raven.CallAssemblyVariants.Paftools.runtime_attr_override">
        <b>ONT_assembly_with_raven.CallAssemblyVariants.Paftools.runtime_attr_override</b><br />
        <i>RuntimeAttr? &mdash; Default: None</i><br />
        ???
</p>
<p name="ONT_assembly_with_raven.ComputeGenomeLength.runtime_attr_override">
        <b>ONT_assembly_with_raven.ComputeGenomeLength.runtime_attr_override</b><br />
        <i>RuntimeAttr? &mdash; Default: None</i><br />
        ???
</p>
<p name="ONT_assembly_with_raven.medaka_model">
        <b>ONT_assembly_with_raven.medaka_model</b><br />
        <i>String &mdash; Default: "r941_min_high_g360"</i><br />
        Medaka polishing model name
</p>
<p name="ONT_assembly_with_raven.MedakaPolish.runtime_attr_override">
        <b>ONT_assembly_with_raven.MedakaPolish.runtime_attr_override</b><br />
        <i>RuntimeAttr? &mdash; Default: None</i><br />
        ???
</p>
<p name="ONT_assembly_with_raven.MergeFastqs.prefix">
        <b>ONT_assembly_with_raven.MergeFastqs.prefix</b><br />
        <i>String &mdash; Default: "merged"</i><br />
        ???
</p>
<p name="ONT_assembly_with_raven.MergeFastqs.runtime_attr_override">
        <b>ONT_assembly_with_raven.MergeFastqs.runtime_attr_override</b><br />
        <i>RuntimeAttr? &mdash; Default: None</i><br />
        ???
</p>
<p name="ONT_assembly_with_raven.n_rounds">
        <b>ONT_assembly_with_raven.n_rounds</b><br />
        <i>Int &mdash; Default: 1</i><br />
        number of medaka polishing rounds
</p>
<p name="ONT_assembly_with_raven.Quast.is_large">
        <b>ONT_assembly_with_raven.Quast.is_large</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        ???
</p>
<p name="ONT_assembly_with_raven.Quast.runtime_attr_override">
        <b>ONT_assembly_with_raven.Quast.runtime_attr_override</b><br />
        <i>RuntimeAttr? &mdash; Default: None</i><br />
        ???
</p>
<p name="ONT_assembly_with_raven.Raven.disable_checkpoints">
        <b>ONT_assembly_with_raven.Raven.disable_checkpoints</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        ???
</p>
<p name="ONT_assembly_with_raven.Raven.frequency">
        <b>ONT_assembly_with_raven.Raven.frequency</b><br />
        <i>Float &mdash; Default: 0.001</i><br />
        ???
</p>
<p name="ONT_assembly_with_raven.Raven.gap">
        <b>ONT_assembly_with_raven.Raven.gap</b><br />
        <i>Int &mdash; Default: -4</i><br />
        ???
</p>
<p name="ONT_assembly_with_raven.Raven.identity">
        <b>ONT_assembly_with_raven.Raven.identity</b><br />
        <i>Float &mdash; Default: 0.0</i><br />
        ???
</p>
<p name="ONT_assembly_with_raven.Raven.kMaxNumOverlaps">
        <b>ONT_assembly_with_raven.Raven.kMaxNumOverlaps</b><br />
        <i>Int &mdash; Default: 32</i><br />
        ???
</p>
<p name="ONT_assembly_with_raven.Raven.kmer_len">
        <b>ONT_assembly_with_raven.Raven.kmer_len</b><br />
        <i>Int &mdash; Default: 15</i><br />
        ???
</p>
<p name="ONT_assembly_with_raven.Raven.match">
        <b>ONT_assembly_with_raven.Raven.match</b><br />
        <i>Int &mdash; Default: 3</i><br />
        ???
</p>
<p name="ONT_assembly_with_raven.Raven.min_unitig_size">
        <b>ONT_assembly_with_raven.Raven.min_unitig_size</b><br />
        <i>Int &mdash; Default: 9999</i><br />
        ???
</p>
<p name="ONT_assembly_with_raven.Raven.mismatch">
        <b>ONT_assembly_with_raven.Raven.mismatch</b><br />
        <i>Int &mdash; Default: -5</i><br />
        ???
</p>
<p name="ONT_assembly_with_raven.Raven.polishing_rounds">
        <b>ONT_assembly_with_raven.Raven.polishing_rounds</b><br />
        <i>Int &mdash; Default: 2</i><br />
        ???
</p>
<p name="ONT_assembly_with_raven.Raven.resume">
        <b>ONT_assembly_with_raven.Raven.resume</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        ???
</p>
<p name="ONT_assembly_with_raven.Raven.runtime_attr_override">
        <b>ONT_assembly_with_raven.Raven.runtime_attr_override</b><br />
        <i>RuntimeAttr? &mdash; Default: None</i><br />
        ???
</p>
<p name="ONT_assembly_with_raven.Raven.unitig_graphical_fragment_assembly">
        <b>ONT_assembly_with_raven.Raven.unitig_graphical_fragment_assembly</b><br />
        <i>String? &mdash; Default: None</i><br />
        ???
</p>
<p name="ONT_assembly_with_raven.Raven.use_micromizers">
        <b>ONT_assembly_with_raven.Raven.use_micromizers</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        ???
</p>
<p name="ONT_assembly_with_raven.Raven.window_len">
        <b>ONT_assembly_with_raven.Raven.window_len</b><br />
        <i>Int &mdash; Default: 5</i><br />
        ???
</p>
</details>

## Outputs
<p name="ONT_assembly_with_raven.assembly">
        <b>ONT_assembly_with_raven.assembly</b><br />
        <i>File</i><br />
        ???
</p>
<p name="ONT_assembly_with_raven.contigs_reports">
        <b>ONT_assembly_with_raven.contigs_reports</b><br />
        <i>File?</i><br />
        ???
</p>
<p name="ONT_assembly_with_raven.gassembly">
        <b>ONT_assembly_with_raven.gassembly</b><br />
        <i>File?</i><br />
        ???
</p>
<p name="ONT_assembly_with_raven.paf">
        <b>ONT_assembly_with_raven.paf</b><br />
        <i>File</i><br />
        ???
</p>
<p name="ONT_assembly_with_raven.paftools_vcf">
        <b>ONT_assembly_with_raven.paftools_vcf</b><br />
        <i>File</i><br />
        ???
</p>
<p name="ONT_assembly_with_raven.plots">
        <b>ONT_assembly_with_raven.plots</b><br />
        <i>Array[File]</i><br />
        ???
</p>
<p name="ONT_assembly_with_raven.polished_assembly">
        <b>ONT_assembly_with_raven.polished_assembly</b><br />
        <i>File</i><br />
        ???
</p>
<p name="ONT_assembly_with_raven.quast_summary">
        <b>ONT_assembly_with_raven.quast_summary</b><br />
        <i>Map[String,String]</i><br />
        ???
</p>
<p name="ONT_assembly_with_raven.report_html">
        <b>ONT_assembly_with_raven.report_html</b><br />
        <i>File</i><br />
        ???
</p>
<p name="ONT_assembly_with_raven.report_in_various_formats">
        <b>ONT_assembly_with_raven.report_in_various_formats</b><br />
        <i>Array[File]</i><br />
        ???
</p>
<p name="ONT_assembly_with_raven.report_txt">
        <b>ONT_assembly_with_raven.report_txt</b><br />
        <i>File</i><br />
        ???
</p>

<hr />

> Generated using WDL AID (1.0.0)
