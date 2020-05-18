using System;
using System.Collections.Generic;
using System.Text;

namespace AutoMLHelper
{
    public class ProgressToCallback<T> : IProgress<T>
    {
        private readonly Action<T> callback;

        public ProgressToCallback(Action<T> callback)
        {
            this.callback = callback;
        }
        public void Report(T value)
        {
            callback(value);
        }
    }
}
