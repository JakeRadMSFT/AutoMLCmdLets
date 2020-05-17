Add-Type -Path  bin\Debug\netcoreapp3.1\win-x64\Microsoft.ML.AutoML.dll
Add-Type -Path  bin\Debug\netcoreapp3.1\win-x64\Microsoft.ML.Data.dll

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

$inferResults = $inferColumnsMethod.invoke($null, 
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