// Feather disable all

/// Queues the texture group associated with the given sprite to be fetched the next time TexanCommit() or TexanCommitStep() is called
/// (If a texture group is queued to be both fetched and flushed then the flush command is ignored)
///
/// @param sprite
/// @param [sprite...]

function TexanFetchSprite()
{
    static _global = __TexanInitialize();
    
    var _i = 0;
    repeat(argument_count)
    {
        var _sprite = argument[_i];
        
        var _textureGroup = _global.__spriteToTextureGroupDict[? _sprite];
        if (_textureGroup != undefined) TexanFetch(_textureGroup);
        
        ++_i;
    }
}