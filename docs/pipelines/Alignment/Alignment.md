# Alignment
Perform alignment of single end reads to reference via minimap2.

## Inputs

### Required inputs
<p name="Alignment.map_preset">
        <b>Alignment.map_preset</b><br />
        <i>String &mdash; Default: None</i><br />
        ???
</p>
<p name="Alignment.reads">
        <b>Alignment.reads</b><br />
        <i>Array[File]+ &mdash; Default: None</i><br />
        list of input single end fastq files
</p>
<p name="Alignment.ref_fasta">
        <b>Alignment.ref_fasta</b><br />
        <i>File &mdash; Default: None</i><br />
        reference sequence
</p>
<p name="Alignment.RG">
        <b>Alignment.RG</b><br />
        <i>String &mdash; Default: None</i><br />
        ???
</p>

### Other inputs
<details>
<summary> Show/Hide </summary>
<p name="Alignment.library">
        <b>Alignment.library</b><br />
        <i>String? &mdash; Default: None</i><br />
        ???
</p>
<p name="Alignment.prefix">
        <b>Alignment.prefix</b><br />
        <i>String &mdash; Default: "out"</i><br />
        prefix for output files
</p>
<p name="Alignment.runtime_attr_override">
        <b>Alignment.runtime_attr_override</b><br />
        <i>RuntimeAttr? &mdash; Default: None</i><br />
        ???
</p>
<p name="Alignment.tags_to_preserve">
        <b>Alignment.tags_to_preserve</b><br />
        <i>Array[String] &mdash; Default: []</i><br />
        ???
</p>
</details>

## Outputs
<p name="Alignment.aligned_bai">
        <b>Alignment.aligned_bai</b><br />
        <i>File</i><br />
        ???
</p>
<p name="Alignment.aligned_bam">
        <b>Alignment.aligned_bam</b><br />
        <i>File</i><br />
        ???
</p>

<hr />

> Generated using WDL AID (1.0.0)
