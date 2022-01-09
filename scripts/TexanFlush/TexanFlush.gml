/// Queues texture groups to be flushed the next time TexanCommit() or TexanCommitStep() are called
/// (If a texture group is queued to be both fetched and flushed then the flush command is ignored)
///
/// @param textureGroup
/// @param [textureGroup...]

function TexanFlush()
{
    if (global.__texanComplete)
    {
        global.__texanComplete   = false;
        global.__texanFetchCount = 0;
        global.__texanFlushCount = 0;
    }
    
    var _i = 0;
    repeat(argument_count)
    {
        var _texture_group = argument[_i];
        
        if (TEXAN_DEBUG_LEVEL >= 2) __TexanTrace("Trying to queue flush \"", _texture_group, "\"          ", debug_get_callstack());
        
        if ((ds_list_find_index(global.__texanFetch, _texture_group) < 0)
        &&  (ds_list_find_index(global.__texanFlush, _texture_group) < 0))
        {
            if (TEXAN_DEBUG_LEVEL >= 2) __TexanTrace("Queued flush for \"", _texture_group, "\"");
            ds_list_add(global.__texanFlush, argument[_i]);
            global.__texanFlushCount++;
        }
        
        ++_i;
    }
}