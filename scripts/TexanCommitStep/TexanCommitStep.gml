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
            var _textureGroup = _global.__flushArray[| _i];
            texture_flush(_textureGroup);
            if (TEXAN_DEBUG_LEVEL >= 1) __TexanTrace("Flushed \"", _textureGroup, "\"");
            ++_i;
        }
        
        array_resize(_global.__flushArray, 0);
    }
    
    var _timeOuter = get_timer();
    while((array_length(_global.__fetchArray) > 0) && (get_timer() - _timeOuter < 1000))
    {
        var _textureGroup = _global.__fetchArray[0];
        array_delete(_global.__fetchArray, 0, 1);
        
        var _timeInner = get_timer();
        texture_prefetch(_textureGroup);
            
        if ((TEXAN_DEBUG_LEVEL >= 1) && (get_timer() - _timeInner > 1000))
        {
            __TexanTrace("Fetched \"", _textureGroup, "\"");
        }
        else if (TEXAN_DEBUG_LEVEL >= 2)
        {
            __TexanTrace("Fetched \"", _textureGroup, "\" (but it was probably already loaded)");
        }
    }
    
    _global.__complete = ((array_length(_global.__flushArray) <= 0) && (array_length(_global.__fetchArray) <= 0));
    
    return _global.__complete;
}