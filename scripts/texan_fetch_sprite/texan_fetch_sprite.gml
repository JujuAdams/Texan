/// Queues the texture group associated with the given sprite to be fetched the next time texan_commit() is called
/// (If a texture group is queued to be both fetched and flushed then the flush command is ignored)
///
/// @param sprite
/// @param [sprite...]

function texan_fetch_sprite()
{
    var _i = 0;
    repeat(argument_count)
    {
        var _sprite = argument[_i];
        
        var _texture_group = global.__texan_sprite_to_texture_group[? _sprite];
        if (_texture_group != undefined) texan_fetch(_texture_group);
        
        ++_i;
    }
}