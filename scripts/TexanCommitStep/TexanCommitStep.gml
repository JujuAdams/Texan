// Feather disable all

/// Flushes all queued texture groups, and then fetches texture groups one at a time (as directed by calling TexanFlush() / TexanFetch() etc.)
/// This function allows for Texan to fetch/flush texture groups over the span of multiple frames to prevent the game from locking up
/// This function returns <true> when the fetch/flush queues have been fully processed, and <false> otherwise

function TexanCommitStep()
{
    static _global = __TexanInitialize();
    
    if (TEXAN_DEBUG_LEVEL >= 1) __TexanTrace("Performing a flush/fetch step");
    
    if (array_length(_global.__flushArray) > 0)
    {
        var _i = 0;
        repeat(array_length(_global.__flushArray))
        {
            var _textureGroup = _global.__flushArray[_i];
            texturegroup_unload(_textureGroup);
            if (TEXAN_DEBUG_LEVEL >= 1) __TexanTrace("Flushed \"", _textureGroup, "\"");
            
            var _index = array_get_index(_global.__fetchedArray, _textureGroup);
            if (_index >= 0) array_delete(_global.__fetchedArray, _index, 1);
            
            ++_i;
        }
        
        array_resize(_global.__flushArray, 0);
    }
    
    var _timeOuter = get_timer();
    while((array_length(_global.__fetchArray) > 0) && (get_timer() - _timeOuter < 1000))
    {
        var _textureGroup = _global.__fetchArray[0];
        
        texturegroup_load(_textureGroup);
        array_delete(_global.__fetchArray, 0, 1);
        array_push(_global.__fetchedArray, _textureGroup);
        
        if ((TEXAN_DEBUG_LEVEL >= 1) && texture_is_ready(_textureGroup))
        {
            __TexanTrace("Fetched \"", _textureGroup, "\"");
        }
    }
    
    if (array_length(_global.__fetchArray) > 0)
    {
        _global.__complete = false;
        return false;
    }
    
    var _i = 0;
    repeat(array_length(_global.__fetchedArray))
    {
        if (not texture_is_ready(_global.__fetchedArray[_i]))
        {
            _global.__complete = false;
            return false;
        }
        
        ++_i;
    }
    
    _global.__complete = true;
    return true;
}