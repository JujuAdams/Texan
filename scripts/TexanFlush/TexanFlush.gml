// Feather disable all

/// Queues texture groups to be flushed the next time TexanCommit() is called. (If a texture group
/// is queued to be both fetched and flushed then the flush command is ignored.
///
/// @param textureGroup
/// @param [textureGroup...]

function TexanFlush()
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
        
        if (TEXAN_DEBUG_LEVEL >= 2) __TexanTrace("Trying to queue flush \"", _textureGroup, "\"          ", debug_get_callstack());
        
        if ((array_get_index(_global.__fetchArray, _textureGroup) < 0)
        &&  (array_get_index(_global.__flushArray, _textureGroup) < 0))
        {
            if (TEXAN_DEBUG_LEVEL >= 2) __TexanTrace("Queued flush for \"", _textureGroup, "\"");
            array_push(_global.__flushArray, argument[_i]);
            _global.__flushCount++;
        }
        
        ++_i;
    }
}