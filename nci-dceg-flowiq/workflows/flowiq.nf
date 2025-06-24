
/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    IMPORT MODULES / SUBWORKFLOWS / FUNCTIONS
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/

include { paramsSummaryMap       } from 'plugin/nf-schema'
include { paramsSummaryMultiqc   } from '../subworkflows/nf-core/utils_nfcore_pipeline'
include { softwareVersionsToYAML } from '../subworkflows/nf-core/utils_nfcore_pipeline'
include { methodsDescriptionText } from '../subworkflows/local/utils_nfcore_flowiq_pipeline'
include { MANTA_GERMLINE } from '../modules/nf-core/manta/germline/main'                                                                       
/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    CHANNEL DEFINITIONS
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/

// Channel for the first input: tuple val(meta), path(input), path(index), path(target_bed), path(target_bed_tbi)
Channel.from([
    tuple(
        [ id: 'test' ],                                                              // meta
        file(params.manta_input_data_base_path + 'genomics/homo_sapiens/illumina/cram/test.paired_end.sorted.cram', checkIfExists: true), // input (CRAM)
        file(params.manta_input_data_base_path + 'genomics/homo_sapiens/illumina/cram/test.paired_end.sorted.cram.crai', checkIfExists: true), // index (CRAI)
        [],                                                                        // target_bed (null because we don't have one for the base test)
        []                                                                         // target_bed_tbi (null)
    )
]).set { manta_main_input_ch } // This channel matches the first input signature

// Channel for the second input: tuple val(meta2), path(fasta)
Channel.from([
    tuple(
        [ id: 'genome' ],                                                          // meta2
        file(params.manta_input_data_base_path + 'genomics/homo_sapiens/genome/genome.fasta', checkIfExists: true) // fasta
    )
]).set { manta_fasta_ch }

// Channel for the third input: tuple val(meta3), path(fai)
Channel.from([
    tuple(
        [ id: 'genome' ],                                                          // meta3
        file(params.manta_input_data_base_path + 'genomics/homo_sapiens/genome/genome.fasta.fai', checkIfExists: true) // fai
    )
]).set { manta_fai_ch }

// Channel for the fourth input: path(config)
Channel
    .of("[manta]", "enableRemoteReadRetrievalForInsertionsInGermlineCallingModes = 0")
    .collectFile(name: "manta_options.ini", newLine: true)
    .set { manta_config_ch }



/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    RUN MAIN WORKFLOW
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/

workflow FLOWIQ {

    main:

    MANTA_GERMLINE(
      manta_main_input_ch, // Corresponds to `tuple val(meta), path(input), path(index), path(target_bed), path(target_bed_tbi)`
      manta_fasta_ch,      // Corresponds to `tuple val(meta2), path(fasta)`
      manta_fai_ch,        // Corresponds to `tuple val(meta3), path(fai)`
      manta_config_ch      // Corresponds to `path(config)`
    )

    emit:
    candidate_small_indels_vcf = MANTA_GERMLINE.out.candidate_small_indels_vcf
    candidate_small_indels_vcf_tbi = MANTA_GERMLINE.out.candidate_small_indels_vcf_tbi
    candidate_sv_vcf = MANTA_GERMLINE.out.candidate_sv_vcf
    candidate_sv_vcf_tbi = MANTA_GERMLINE.out.candidate_sv_vcf_tbi
    diploid_sv_vcf = MANTA_GERMLINE.out.diploid_sv_vcf
    diploid_sv_vcf_tbi = MANTA_GERMLINE.out.diploid_sv_vcf_tbi
    versions = MANTA_GERMLINE.out.versions

    //candidate_small_indels_vcf.view()

}


/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    THE END
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/
