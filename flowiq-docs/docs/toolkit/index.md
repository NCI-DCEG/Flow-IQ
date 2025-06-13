# Flow-IQ

<div style="margin-bottom:2rem;">
  <img src="images/flow-iq.png" style="max-width:200px; float:right; margin-left:1rem;"/>
  <h3 class="subtitle">A workflow cloud migration toolkit</h3>
</div>


This project aims to develop a toolkit that assists NIH researchers in migrating their bioinformatics workflows from the Biowulf HPC cluster to the AWS cloud, enhancing efficiency and cost-effectiveness through standardized Nextflow modules and templates.

For more information about this resource, please see the GitHub readme at [NCI-DCEG/Flow-IQ](https://github.com/NCI-DCEG/Flow-IQ).

---


<body>
    <div class="container mainbody">

        <h2 class="flow-h2"><a name="docker-image-builder">Biowulf Module to Docker Image Builder</a></h2>
        <p>Use the dropdown boxes below to locate the equivalent docker image for each Biowulf module.</p>
        <form>
            <div class="row">
                <div class="form-group col-sm-3">
                    <label for="all_modules">Biowulf Module</label>
                    <select class="form-control" id="all_modules">
                        <option value="">[ select ] </option>
                    </select>
                </div>
                <div class="form-group col-sm-3">
                    <label for="version">Version</label>
                    <select class="form-control" id="version" disabled>
                        <option value="">Please select a version</option>
                    </select>
                </div>
            </div>
        </form>



        <h5 class="section-heading">Docker Image</h5>
        <div class="prewrap" id="docker_ref_wrapper">
            <button class="btn" data-clipboard-target="#docker_ref" disabled>Copy</button>
            <pre><code id="docker_ref"><span class="text-muted">waiting for selection&hellip;</span></code></pre>
        </div>



<!-- After this line is the Data Type to Test Data Location Mapper -->
        <hr>
        <br>

        <h2 class="flow-h2"><a name="example-data-builder">Example Data Builder</a></h2>
        <p>Use the dropdown boxes below to locate example datasets for corresponding data types.</p>

        <form>
            <div class="row">
                <div class="form-group col-sm-3">
                    <label for="all_data_types">Data Type</label>
                    <select class="form-control" id="all_data_types">
                        <option value="">[ select ] </option>
                    </select>
                </div>
                <div class="form-group col-sm-3">
                    <label for="data_options">Additional Options</label>
                    <select class="form-control" id="data_options" disabled>
                        <option value="">Please select any additional options </option>
                    </select>
                </div>
            </div>
        </form>

        <h5 class="section-heading">Data Locations</h5>
        <div class="prewrap" id="data_ref_wrapper">
            <!--<button class="btn" data-clipboard-target="#data_ref" disabled>Copy</button>-->
            <pre><code id="data_ref"><span class="text-muted">waiting for selection&hellip;</span></code></pre>
        </div>
        
        <br><br>

        <h5>Description</h5>
        <pre><code id="description"><span class="text-muted">waiting for selection&hellip;</span></code></pre>

    </div>

    <!--
    <div class="footer">
        <div class="container">
            This resource was developed by <a href="https://dceg.cancer.gov/about/organization/tdrp/wong-wendy">Wendy Wong</a>, a bioinformatician
            at the <a href="https://dceg.cancer.gov/">National Cancer Institute - Division of Cancer Epidemiology & Genetics</a>, and Jesse Marks, a bioinformatics software engineer at <a href="https://rti.org">RTI International - GenOmics and Translational Research Center.</a><div class="row mt-4">
                <div class="col-md-4 text-center"><a href="https://aws.amazon.com/grants/"><img
                            title="AWS" src="images/aws-logo.png"></a></div>
                <div class="col-md-4 text-center"><a href="https://nf-co.re/"><img title="nf-core"
                            src="images/nf-core-logo.png" class="sll-logo"></a></div>
                <div class="col-md-4 text-center"><a href="https://hpc.nih.gov/"><img
                            title="Biowulf" src="images/biowulf-logo.png"></a></div>
            </div>
        </div>
    </div>
    -->



    <!--  JavaScript -->
    <script src="https://code.jquery.com/jquery-3.2.1.min.js"
        integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4=" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.4.0/js/tether.min.js"
        integrity="sha384-DztdAPBWPRXSA/3eYEEUWrWCy7G5KFbe8fFjk5JAIxUYHKkDx6Qin1DkWx51bBrb"
        crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/js/bootstrap.min.js"
        integrity="sha384-vBWWzlZJ8ea9aCX4pEW3rVHjgjt7zpkNpZk+02D9phzyeVkE+jo0ieGizqPLForn"
        crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/clipboard.js/1.6.1/clipboard.min.js"></script>
    <script type="text/javascript">

        // Docker Image Section
        $(function () {
            // Initiate clipboard.js
            new Clipboard('.prewrap > .btn');

            // Step 1: Load the JSON mapping files and populate the first dropdown
            $.getJSON('flowiq_mapping.json', function (data) {
                const $biowulfDropdown = $('#all_modules');
                const $versionDropdown = $('#version');
                const $dockerImage = $('#docker_ref');
                const $copyButton = $('#docker_ref_wrapper .btn');

                Object.keys(data).forEach(key => {
                    $biowulfDropdown.append($('<option>', {
                        value: key,
                        text: key
                    }));
                });

                // Populate the second dropdown when the first dropdown changes
                $biowulfDropdown.change(function () {
                    const selectedModule = $(this).val();

                    // Reset the second dropdown and docker image reference
                    $versionDropdown.empty().append('<option value="">Please select a version</option>').prop('disabled', true);
                    $dockerImage.html('<span class="text-muted">waiting for selection&hellip;</span>');
                    $copyButton.prop('disabled', true);

                    if (selectedModule && data[selectedModule]) {
                        // Populate the second dropdown
                        Object.keys(data[selectedModule]).forEach(key => {
                            $versionDropdown.append($('<option>', {
                                value: key,
                                text: key
                            }));
                        });

                        $versionDropdown.prop('disabled', false); // Enable the second dropdown
                    }
                });

                // Update the docker image reference when the second dropdown changes
                $versionDropdown.change(function () {
                    const selectedModule = $biowulfDropdown.val();
                    const selectedVersion = $(this).val();

                    if (selectedModule && selectedVersion && data[selectedModule][selectedVersion]) {
                        // Set the docker image reference and enable the copy button
                        $dockerImage.text(data[selectedModule][selectedVersion]);
                        $copyButton.prop('disabled', false);
                    } else {
                        // Reset the docker image reference and disable the copy button
                        $dockerImage.html('<span class="text-muted">waiting for selection&hellip;</span>');
                        $copyButton.prop('disabled', true);
                    }
                });
            }).fail(function () {
                console.error('Error loading or parsing JSON');
            });
        });






////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////







        // Example Data Section
        $(function () {
            // Initiate clipboard.js
            new Clipboard('.prewrap > .btn');

            // Step 1: Load the JSON mapping files and populate the first dropdown
            $.getJSON('test_data_mapping.json', function (data) {
                const $dataTypeDropdown = $('#all_data_types');
                const $dataOptionDropdown = $('#data_options');
                const $s3Location = $('#data_ref');
                // const $copyButton = $('#data_ref_wrapper .btn');
                const $dataDescription = $('#description');

                Object.keys(data).forEach(key => {
                    $dataTypeDropdown.append($('<option>', {
                        value: key,
                        text: key
                    }));
                });

                // Populate the second dropdown when the first dropdown changes
                $dataTypeDropdown.change(function () {
                    const selectedData = $(this).val();

                    // Reset the second dropdown and data options reference
                    $dataOptionDropdown.empty().append('<option value="">Please select a version</option>').prop('disabled', true);
                    $s3Location.html('<span class="text-muted">waiting for selection&hellip;</span>');
                    // $copyButton.prop('disabled', true);
                    $dataDescription.html('<span class="text-muted">waiting for selection&hellip;</span>').prop('disabled', true)

                    if (selectedData && data[selectedData]) {
                        $dataOptionDropdown.prop('disabled', false); // Enable the second dropdown

                        // Populate the second dropdown
                        Object.keys(data[selectedData]).forEach(key => {
                            if (key !== "Description") {
                                $dataOptionDropdown.append($('<option>', {
                                    value: key,
                                    text: key
                                }));
                            }
                        });
                    }
                });

                // Update the Data Locations + Description when the second dropdown changes
                $dataOptionDropdown.change(function () {
                    const selectedData = $dataTypeDropdown.val();
                    const selectedOption = $(this).val();

                    // Set the Data Locations and Description Boxes
                    if (selectedData && selectedOption && data[selectedData][selectedOption]) {

                         // Parse the array of values
                        const arrayValues = data[selectedData][selectedOption];

                        // Generate a code block if the data is an array
                        if (Array.isArray(arrayValues)) {
                            const formattedValues = arrayValues.join('\n');
                            $s3Location.text(formattedValues); // Add array to code block
                        } else {
                            $s3Location.text(arrayValues); // For non-array data, just display the value
                        }
                        // $copyButton.prop('disabled', false);

                        // Display the description
                        $dataDescription.text(data[selectedData]["Description"]);
                    } else {
                        // Reset Data Locations
                        $s3Location.html('<span class="text-muted">waiting for selection&hellip;</span>');
                        // $copyButton.prop('disabled', true);
                    }
                });
            }).fail(function () {
                console.error('Error loading or parsing JSON');
            });
        });

    </script>
</body>


