ipmo C:\dev\MLNETAutoMLPowershellExample\AutoML\AutoMLHelper\bin\Debug\netcoreapp2.1\win-x64\AutoMLHelper.dll


Start-Classification -Path C:\dev\datasets\wikipedia-detox-250-line-data.tsv -Label sentiment -vb
Start-Recommendation -Path C:\dev\datasets\recommendation-ratings-train.csv -Label rating -User userId -Item movieId -vb
Start-Regression -Path C:\dev\datasets\taxi-fare-train.csv -Label fare_amount -vb 