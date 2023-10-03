/// Returns whether Texan has finished processing all of its queued operations

function TexanGetComplete()
{
    static _global = __TexanInitialize();
    return _global.__complete;
}