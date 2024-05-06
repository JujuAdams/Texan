// Feather disable all

/// Queues the texture group associated with the given sprite to be fetched the next time
/// TexanCommit() is called. If a texture group is queued to be both fetched and flushed then the
/// flush command is ignored.
///
/// @param sprite
/// @param [sprite...]

function TexanFetchSprite()
{
    static _global = __TexanInitialize();
    
    if (not TEXAN_ENABLE_SPRITE_FETCHING)
    {
        __TexanError("Please set TEXAN_ENABLE_SPRITE_FETCHING to <true>");
        return;
    }
    
    var _i = 0;
    repeat(argument_count)
    {
        var _sprite = argument[_i];
        
        var _textureGroup = _global.__spriteToTextureGroupDict[$ _sprite];
        if (_textureGroup == undefined)
        {
            if (TEXAN_DEBUG_LEVEL >= 1) __TexanTrace("Warning! Sprite ", _sprite, " (\"", sprite_get_name(_sprite), "\") not recognised. Perhaps its texture group has not been added to the TEXAN_TEXTURE_GROUPS array?");
        }
        else
        {
            TexanFetch(_textureGroup);
        }
        
        ++_i;
    }
}