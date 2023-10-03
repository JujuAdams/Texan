/// Returns the total number of operations queued into Texan, whether they've been completed or not

function TexanGetOperationsCount()
{
    static _global = __TexanInitialize();
    return _global.__fetchCount + _global.__flushCount;
}