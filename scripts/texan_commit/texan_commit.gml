/// Flushes and fetches texture groups (as directed by calling texan_flush() / texan_fetch() etc.)
/// The fetch and flush queues are cleared at the end of this function

function texan_commit()
{
    if (TEXAN_DEBUG_LEVEL >= 1) __texan_trace("Committing flush/fetch changes");
    
    var _i = 0;
    repeat(ds_list_size(global.__texan_flush))
    {
        var _texture_group = global.__texan_flush[| _i];
        texture_flush(_texture_group);
        if (TEXAN_DEBUG_LEVEL >= 1) __texan_trace("Flushed \"", _texture_group, "\"");
        ++_i;
    }
    
    var _i = 0;
    repeat(ds_list_size(global.__texan_fetch))
    {
        var _texture_group = global.__texan_fetch[| _i];
        
        var _t = get_timer();
        texture_prefetch(_texture_group);
        
        if ((TEXAN_DEBUG_LEVEL >= 1) && (get_timer() - _t > 1000))
        {
            __texan_trace("Fetched \"", _texture_group, "\"");
        }
        else if (TEXAN_DEBUG_LEVEL >= 2)
        {
            __texan_trace("Fetched \"", _texture_group, "\" (but it was probably already loaded)");
        }
        
        ++_i;
    }
    
    ds_list_clear(global.__texan_flush);
    ds_list_clear(global.__texan_fetch);
    
    ds_list_copy(global.__texan_fetch, global.__texan_always_fetch);
}

function texan_yeehaw()
{
    texan_commit();
}