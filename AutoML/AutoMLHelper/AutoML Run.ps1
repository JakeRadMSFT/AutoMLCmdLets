Add-Type -Path  bin\Debug\netcoreapp3.1\win-x64\Microsoft.ML.AutoML.dll
Add-Type -Path  bin\Debug\netcoreapp3.1\win-x64\Microsoft.ML.Data.dll

$context = new-object Microsoft.ML.MLContext -ArgumentList 0

$columns = [Microsoft.ML.Data.TextLoader+Column[]](
    [Microsoft.ML.Data.TextLoader+Column]::new("Label", [Microsoft.ML.Data.DataKind]::String, 0),
    [Microsoft.ML.Data.TextLoader+Column]::new("text", [Microsoft.ML.Data.DataKind]::String, 1)
)

$trainDataView = [Microsoft.ML.TextLoaderSaverCatalog]::LoadFromTextFile(
    $context.Data,
    "C:\dev\datasets\wikipedia-detox-250-line-data.tsv",
    $columns,
    [char]9,
    $true , $false, $false, $false
    );

$autoCatalog = [Microsoft.ML.AutoML.MLContextExtension]::Auto($context)
$experiment = $autoCatalog.CreateMulticlassClassificationExperiment(10);

$bestRun = $experiment.Execute($trainDataView).BestRun;

Write-Host "Best Trainer : " $bestRun.TrainerName
Write-Host "ConfusionMatrix : " $bestRun.ValidationMetrics.ConfusionMatrix
Write-Host "LogLoss : " $bestRun.ValidationMetrics.LogLoss 
Write-Host "LogLossReduction : " $bestRun.ValidationMetrics.LogLossReduction 
Write-Host "MacroAccuracy : " $bestRun.ValidationMetrics.MacroAccuracy 
Write-Host "MicroAccuracy : " $bestRun.ValidationMetrics.MicroAccuracy 
Write-Host "PerClassLogLoss : " $bestRun.ValidationMetrics.PerClassLogLoss
Write-Host "TopKAccuracy : " $bestRun.ValidationMetrics.TopKAccuracy 
Write-Host "TopKPredictionCount : " $bestRun.ValidationMetrics.TopKPredictionCount  

