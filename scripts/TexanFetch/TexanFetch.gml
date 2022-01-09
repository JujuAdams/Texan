/// Queues texture groups to be fetched the next time TexanCommit() or TexanCommitStep() are called
/// (If a texture group is queued to be both fetched and flushed then the flush command is ignored)
///
/// @param textureGroup
/// @param [textureGroup...]

function TexanFetch()
{
    if (global.__texanComplete)
    {
        global.__texanComplete   = false;
        global.__texanFetchCount = 0;
        global.__texanFlushCount = 0;
    }
    
    if (ds_list_empty(global.__texanFetch) && !ds_list_empty(global.__texanAlwaysFetch))
    {
        ds_list_copy(global.__texanFetch, global.__texanAlwaysFetch);
        global.__texanFlushCount += ds_list_size(global.__texanAlwaysFetch);
    }
    
    var _i = 0;
    repeat(argument_count)
    {
        var _texture_group = argument[_i];
        
        if (TEXAN_DEBUG_LEVEL >= 2) __TexanTrace("Trying to queue fetch \"", _texture_group, "\"          ", debug_get_callstack());
        
        var _index = ds_list_find_index(global.__texanFlush, _texture_group);
        if (_index >= 0)
        {
            if (TEXAN_DEBUG_LEVEL >= 2) __TexanTrace("Fetch collides with flush for \"", _texture_group, "\", removing flush");
            ds_list_delete(global.__texanFlush, _index);
            global.__texanFlushCount--;
        }
        
        if (ds_list_find_index(global.__texanFetch, _texture_group) < 0)
        {
            if (TEXAN_DEBUG_LEVEL >= 2) __TexanTrace("Queued fetch for \"", _texture_group, "\"");
            ds_list_add(global.__texanFetch, _texture_group);
            global.__texanFetchCount++;
        }
        
        ++_i;
    }
}