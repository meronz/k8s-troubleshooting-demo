using Microsoft.JSInterop;

namespace BlazorCharts.Client.Shared;

public class Chartist : IAsyncDisposable
{
    private readonly Lazy<Task<IJSObjectReference>> _moduleTask;

    public Chartist(IJSRuntime jsRuntime)
    {
        var importPath = "./chartist-js/chartistHelper.js";
        _moduleTask = new(() => jsRuntime.InvokeAsync<IJSObjectReference>("import", importPath).AsTask());
    }

    public async ValueTask DisposeAsync()
    {
        if (_moduleTask.IsValueCreated)
        {
            var module = await _moduleTask.Value;
            await module.DisposeAsync();
        }

        GC.SuppressFinalize(this);
    }
    
    public async Task CreateLine(string selector, List<string> labels, List<int> series)
    {
        var module = await _moduleTask.Value;
        await module.InvokeVoidAsync("createLine", selector, labels, series);
    }

    public async Task CreateLine(string selector, List<string> labels, List<float> series)
    {
        var module = await _moduleTask.Value;
        await module.InvokeVoidAsync("createLine", selector, labels, series);
    }
    
    public async Task CreateLine(string selector, List<string> labels, List<double> series)
    {
        var module = await _moduleTask.Value;
        await module.InvokeVoidAsync("createLine", selector, labels, series);
    }
}