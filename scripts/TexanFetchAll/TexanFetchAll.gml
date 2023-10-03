// Feather disable all

/// Queues *all* texture groups to be fetched the next time TexanCommit() or TexanCommitStep() are called
/// (If a texture group is queued to be both fetched and flushed then the flush command is ignored)

function TexanFetchAll()
{
    static _global = __TexanInitialize();
    
    var _i = 0;
    repeat(array_length(_global.__textureGroupArray))
    {
        TexanFetch(_global.__textureGroupArray[| _i]);
        ++_i;
    }
}