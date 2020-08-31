/// Queues texture groups to be flushed the next time texan_commit() is called
/// (If a texture group is queued to be both fetched and flushed then the flush command is ignored)
///
/// @param textureGroup
/// @param [textureGroup...]

function texan_flush()
{
    var _i = 0;
    repeat(argument_count)
    {
        var _texture_group = argument[_i];
        
        if (TEXAN_DEBUG_LEVEL >= 2) __texan_trace("Trying to queue flush \"", _texture_group, "\"          ", debug_get_callstack());
        
        if ((ds_list_find_index(global.__texan_fetch, _texture_group) < 0)
        &&  (ds_list_find_index(global.__texan_flush, _texture_group) < 0))
        {
            if (TEXAN_DEBUG_LEVEL >= 2) __texan_trace("Queued flush for \"", _texture_group, "\"");
            ds_list_add(global.__texan_flush, argument[_i]);
        }
        
        ++_i;
    }
}