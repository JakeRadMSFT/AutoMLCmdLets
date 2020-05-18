ipmo .\bin\Debug\netcoreapp2.1\win-x64\AutoMLDotNetCmdLets.dll


Start-Classification -Path C:\dev\datasets\wikipedia-detox-250-line-data.tsv -Label sentiment -vb | ForEach-Object {$_.ValidationMetrics}
Start-Recommendation -Path C:\dev\datasets\recommendation-ratings-train.csv -Label rating -User userId -Item movieId -vb | ForEach-Object {$_.ValidationMetrics}
Start-Regression -Path C:\dev\datasets\taxi-fare-train.csv -Label fare_amount -vb | ForEach-Object {$_.ValidationMetrics}