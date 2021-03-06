﻿using System.Reflection;
using System.Management.Automation;
using System.Management.Automation.Runspaces;
using Microsoft.ML;
using Microsoft.ML.AutoML;
using Microsoft.ML.Data;
using System;


// ipmo .\bin\Debug\netstandard2.0\win-x64\AutoMLHelper.dll
// Start-Classification -Path C:\dev\datasets\wikipedia-detox-250-line-data.tsv -Label sentiment

namespace AutoMLHelper
{
    [Cmdlet(VerbsLifecycle.Start,"Classification")]
    [OutputType(typeof(ExperimentResult<MulticlassClassificationMetrics>))]
    public class ClassificationCommand : PSCmdlet
    {
        [Parameter(
            Mandatory = true,
            Position = 0,
            ValueFromPipeline = true,
            ValueFromPipelineByPropertyName = true)]
        public string Path { get; set; }

        [Parameter(
            Mandatory = true,
            Position = 1,
            ValueFromPipeline = true,
            ValueFromPipelineByPropertyName = true)]

        public string Label { get; set; }

        // This method gets called once for each cmdlet in the pipeline when the pipeline starts executing
        protected override void BeginProcessing()
        {
            WriteVerbose("Starting to train!");
        }

        // This method will be called for each input received from the pipeline to this cmdlet; if no input is received, this method is not called
        protected override void ProcessRecord()
        {
            var context = new MLContext();
            var columnInferenceResults = InferColumnsHelper.InferColumns(context, this.Path, new ColumnInformation() { LabelColumnName = this.Label }, null, null, null, false, false, true);
            var textLoader = context.Data.CreateTextLoader(columnInferenceResults.TextLoaderOptions, null);
            var trainDataset = textLoader.Load(new MultiFileSource(this.Path));

            IProgress<RunDetail<MulticlassClassificationMetrics>> progressHandler = new ProgressToCallback<RunDetail<MulticlassClassificationMetrics>>((metric) =>
                 {
                     WriteObject(metric);
                 });

            var results = context.Auto()
                .CreateMulticlassClassificationExperiment(10)
                .Execute(trainDataset, columnInferenceResults.ColumnInformation, null, progressHandler);
        }

        // This method will be called once at the end of pipeline execution; if no input is received, this method is not called
        protected override void EndProcessing()
        {
            WriteVerbose("Done Training!");
        }
    }
}
