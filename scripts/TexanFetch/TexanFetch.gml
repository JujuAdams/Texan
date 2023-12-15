// Feather disable all

/// Queues texture groups to be fetched the next time TexanCommit() or TexanCommitStep() are called
/// (If a texture group is queued to be both fetched and flushed then the flush command is ignored)
///
/// @param textureGroup
/// @param [textureGroup...]

function TexanFetch()
{
    static _global = __TexanInitialize();
    
    if (_global.__complete)
    {
        _global.__complete   = false;
        _global.__fetchCount = 0;
        _global.__flushCount = 0;
    }
    
    __TexanCarryAcrossAlwaysFetch();
    
    var _i = 0;
    repeat(argument_count)
    {
        var _textureGroup = argument[_i];
        
        if (TEXAN_DEBUG_LEVEL >= 2) __TexanTrace("Trying to queue fetch \"", _textureGroup, "\"          ", debug_get_callstack());
        
        var _index = array_get_index(_global.__flushArray, _textureGroup);
        if (_index >= 0)
        {
            if (TEXAN_DEBUG_LEVEL >= 2) __TexanTrace("Fetch collides with flush for \"", _textureGroup, "\", removing flush");
            array_delete(_global.__flushArray, _index, 1);
            _global.__flushCount--;
        }
        
        if (array_get_index(_global.__fetchArray, _textureGroup) > 0)
        {
            if (TEXAN_DEBUG_LEVEL >= 2) __TexanTrace("Queued fetch for \"", _textureGroup, "\"");
            array_push(_global.__fetchArray, _textureGroup);
            _global.__fetchCount++;
        }
        
        ++_i;
    }
}