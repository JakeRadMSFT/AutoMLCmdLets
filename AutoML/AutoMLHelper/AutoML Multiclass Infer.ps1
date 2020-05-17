Add-Type -Path  bin\Debug\netcoreapp3.1\win-x64\Microsoft.ML.AutoML.dll
Add-Type -Path  bin\Debug\netcoreapp3.1\win-x64\Microsoft.ML.Data.dll

$context = new-object Microsoft.ML.MLContext -ArgumentList 0

$inferColumnsMethod = [Microsoft.ML.AutoML.ColumnInformation].Assembly.GetType("Microsoft.ML.AutoML.ColumnInferenceApi").GetMethod("InferColumns", [Type[]] (
    [Microsoft.ML.MLContext],
    [string],
    [Microsoft.ML.AutoML.ColumnInformation],
    [char],
    [bool],
    [bool],
    [bool],
    [bool],
    [bool]
    ));

$inferColumnInformation = $inferColumnsMethod.invoke($null, 
(
[Microsoft.ML.MLContext] $context,
[string] "C:\dev\datasets\wikipedia-detox-250-line-data.tsv", 
$columnInformation, 
[Nullable[char]] $null, 
[Nullable[bool]] $null, 
[Nullable[bool]] $null, 
$false, 
$false, 
$true));

$loader = [Microsoft.ML.TextLoaderSaverCatalog]::CreateTextLoader(
    $context.Data,
    $inferColumnInformation.TextLoaderOptions,
    $null
    );

$trainDataView = [Microsoft.ML.IDataView]$loader.Load([Microsoft.ML.Data.MultiFileSource]::new("C:\dev\datasets\wikipedia-detox-250-line-data.tsv"))


$autoCatalog = [Microsoft.ML.AutoML.MLContextExtension]::Auto($context)
$experiment = $autoCatalog.CreateMulticlassClassificationExperiment(10);

$bestRun = $experiment.Execute($trainDataView, "sentiment").BestRun;

Write-Host "Best Trainer : " $bestRun.TrainerName

$bestRun.ValidationMetrics | Select-Object -Property *
