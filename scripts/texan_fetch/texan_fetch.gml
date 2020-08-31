/// Queues texture groups to be fetched the next time texan_commit() is called
/// (If a texture group is queued to be both fetched and flushed then the flush command is ignored)
///
/// @param textureGroup
/// @param [textureGroup...]

function texan_fetch()
{
    var _i = 0;
    repeat(argument_count)
    {
        var _texture_group = argument[_i];
        
        if (TEXAN_DEBUG_LEVEL >= 2) __texan_trace("Trying to queue fetch \"", _texture_group, "\"          ", debug_get_callstack());
        
        var _index = ds_list_find_index(global.__texan_flush, _texture_group);
        if (_index >= 0)
        {
            if (TEXAN_DEBUG_LEVEL >= 2) __texan_trace("Fetch collides with flush for \"", _texture_group, "\", removing flush");
            ds_list_delete(global.__texan_flush, _index);
        }
        
        if (ds_list_find_index(global.__texan_fetch, _texture_group) < 0)
        {
            if (TEXAN_DEBUG_LEVEL >= 2) __texan_trace("Queued fetch for \"", _texture_group, "\"");
            ds_list_add(global.__texan_fetch, _texture_group);
        }
        
        ++_i;
    }
}