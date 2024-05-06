// Feather disable all

/// Flushes all queued texture groups, and then fetches texture groups one at a time (as directed by calling TexanFlush() / TexanFetch() etc.)
/// This function allows for Texan to fetch/flush texture groups over the span of multiple frames to prevent the game from locking up
/// This function returns <true> when the fetch/flush queues have been fully processed, and <false> otherwise

function TexanCommit()
{
    static _global = __TexanInitialize();
    
    if (TEXAN_DEBUG_LEVEL >= 1) __TexanTrace("Committing changes");
    
    if (array_length(_global.__flushArray) > 0)
    {
        var _i = 0;
        repeat(array_length(_global.__flushArray))
        {
            var _textureGroup = _global.__flushArray[_i];
            
            if (_global.__textureGroupDynamicDict[$ _textureGroup])
            {
                texturegroup_unload(_textureGroup);
            }
            else
            {
                texture_flush(_textureGroup);
            }
            
            if (TEXAN_DEBUG_LEVEL >= 1) __TexanTrace("Flushed \"", _textureGroup, "\"");
            
            var _index = array_get_index(_global.__fetchedArray, _textureGroup);
            if (_index >= 0) array_delete(_global.__fetchedArray, _index, 1);
            
            ++_i;
        }
        
        array_resize(_global.__flushArray, 0);
    }
    
    repeat(array_length(_global.__fetchArray))
    {
        var _textureGroup = _global.__fetchArray[0];
        var _status = texturegroup_get_status(_textureGroup);
        
        if (_global.__textureGroupDynamicDict[$ string_lower(_textureGroup)] && (_status == texturegroup_status_unloaded))
        {
            _global.__complete = false;
            texturegroup_load(_textureGroup, true);
            
            if ((TEXAN_DEBUG_LEVEL >= 1) && (texturegroup_get_status(_textureGroup) == texturegroup_status_loading))
            {
                __TexanTrace("Loading \"", _textureGroup, "\"");
            }
        }
        else
        {
            if (_status != texturegroup_status_fetched)
            {
                _global.__complete = false;
                texture_prefetch(_textureGroup);
                
                if ((TEXAN_DEBUG_LEVEL >= 1) && (texturegroup_get_status(_textureGroup) == texturegroup_status_fetched))
                {
                    __TexanTrace("Fetched \"", _textureGroup, "\"");
                }
            }
        }
        
        array_push(_global.__fetchedArray, _textureGroup);
    }
    
    array_resize(_global.__fetchArray, 0);
}

function TexanYeehaw()
{
    return TexanCommit();
}