using System;
using Microsoft.ML;
using Microsoft.ML.AutoML;


// ipmo .\bin\Debug\netstandard2.0\win-x64\AutoMLHelper.dll
// Start-Classification -Path C:\dev\datasets\wikipedia-detox-250-line-data.tsv -Label sentiment

namespace AutoMLHelper
{
    internal static class AutoMLHelper {
        private static System.Reflection.MethodInfo InferColumnsMethodInfo;
        static AutoMLHelper() {
            AutoMLHelper.InferColumnsMethodInfo = typeof(Microsoft.ML.AutoML.ColumnInformation).Assembly.GetType("Microsoft.ML.AutoML.ColumnInferenceApi").GetMethod("InferColumns", new Type[] {
                typeof(Microsoft.ML.MLContext),
                typeof(string),
                typeof(Microsoft.ML.AutoML.ColumnInformation),
                typeof(char),
                typeof(bool),
                typeof(bool),
                typeof(bool),
                typeof(bool),
                typeof(bool)
            });
        }

        public static ColumnInferenceResults InferColumns(MLContext context, string path, ColumnInformation columnInfo,
            char? separatorChar, bool? allowQuotedStrings, bool? supportSparse, bool trimWhitespace, bool groupColumns, bool hasHeader = true) 
        {
            try { 
            return (ColumnInferenceResults) InferColumnsMethodInfo.Invoke(null, new object[] {context, path, columnInfo, separatorChar, allowQuotedStrings, supportSparse, trimWhitespace, groupColumns, hasHeader});
            } catch (Exception ex)
            {
                throw ex.InnerException;
            }
        }
    }
}
