/// Flushes all queued texture groups, and then fetches texture groups one at a time (as directed by calling texan_flush() / texan_fetch() etc.)
/// This function allows for Texan to fetch/flush texture groups over the span of multiple frames to prevent the game from locking up
/// This function returns <true> when the fetch/flush queues have been fully processed, and <false> otherwise

function texan_commit_step()
{
    if (TEXAN_DEBUG_LEVEL >= 1) __texan_trace("Performing a flush/fetch step");
    
    if (!ds_list_empty(global.__texan_flush))
    {
        var _i = 0;
        repeat(ds_list_size(global.__texan_flush))
        {
            var _texture_group = global.__texan_flush[| _i];
            texture_flush(_texture_group);
            if (TEXAN_DEBUG_LEVEL >= 1) __texan_trace("Flushed \"", _texture_group, "\"");
            ++_i;
        }
        
        ds_list_clear(global.__texan_flush);
    }
    
    var _t_outer = get_timer();
    while(!ds_list_empty(global.__texan_flush) && (get_timer() - _t_outer < 1000))
    {
        var _texture_group = global.__texan_fetch[| 0];
        ds_list_delete(global.__texan_fetch, 0);
        
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
    }
    
    if (ds_list_empty(global.__texan_flush))
    {
        ds_list_copy(global.__texan_fetch, global.__texan_always_fetch);
        return true;
    }
    else
    {
        return false;
    }
}