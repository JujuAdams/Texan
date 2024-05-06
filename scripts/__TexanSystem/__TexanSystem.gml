// Feather disable all

#macro __TEXAN_VERSION  "3.0.1"
#macro __TEXAN_DATE     "2023-12-15"

__TexanInitialize();

function __TexanInitialize()
{
    static _global = undefined;
    if (_global != undefined) return _global;
    
    __TexanTrace("Welcome to Texan by @jujuadams! This is version ", __TEXAN_VERSION, ", ", __TEXAN_DATE);
    
    _global = {
        __complete: false,
        __flushCount: 0,
        __fetchCount: 0,
        __flushArray: [],
        __fetchArray: [],
        __fetchedArray: [],
        __alwaysFetchArray: [],
        __textureGroupArray: texturegroup_get_names(),
        __spriteToTextureGroupDict: {},
        __textureGroupDynamicDict: {},
    };
    
    if (GM_build_type == "run") global.Texan = _global;
    
    texture_debug_messages(TEXAN_GM_DEBUG_LEVEL);
    
    //Add texture groups to our internal array
    var _array = _global.__textureGroupArray;
    var _i = 0;
    repeat(array_length(_array))
    {
        var _textureGroup = _array[_i];
        
        if (texturegroup_get_status(_textureGroup) == texturegroup_status_unloaded)
        {
            if (TEXAN_DEBUG_LEVEL >= 2) __TexanTrace("\"", _textureGroup, "\" is unloaded on boot, presuming it is a dynamic texture group");
            _global.__textureGroupDynamicDict[$ _textureGroup] = true;
        }
        
        if (TEXAN_ENABLE_SPRITE_FETCHING)
        {
            var _sprites = texturegroup_get_sprites(_textureGroup);
            var _s = 0;
            repeat(array_length(_sprites))
            {
                var _sprite = _sprites[_s];
                if (TEXAN_DEBUG_LEVEL >= 2) __TexanTrace("\"", _textureGroup, "\" has sprite ", sprite_get_name(_sprite), " (", _sprite, ")");
                _global.__spriteToTextureGroupDict[$ _sprite] = _textureGroup;
                ++_s;
            }
        }
        
        ++_i;
    }

    //Add always-fetch textures to our internal array
    var _dict = {};
    var _array = TEXAN_ALWAYS_FETCH;
    var _i = 0;
    repeat(array_length(_array))
    {
        var _textureGroup = _array[_i];
        
        if (not variable_struct_exists(_dict, _textureGroup))
        {
            if (TEXAN_DEBUG_LEVEL >= 2) __TexanTrace("Texan: Always fetching \"", _textureGroup, "\"");
            array_push(_global.__alwaysFetchArray, _textureGroup);
            TexanFetch(_textureGroup);
        }
        
        ++_i;
    }

    if (TEXAN_COMMIT_ON_BOOT) TexanYeehaw();
    
    return _global;
}