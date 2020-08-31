#macro TEXAN_TEXTURE_GROUPS  ["Default"] //Array of texture groups in the game. I'd love for this to be automatic but GameMaker doesn't give us that data at runtime...?!
#macro TEXAN_ALWAYS_FETCH    []          //Array of texture groups for Texan to always keep loaded. Always-fetch texture groups cannot be flushed by Texan as a result
#macro TEXAN_COMMIT_ON_BOOT  true        //Whether to call texan_commit() on boot to load in always-fetch texture groups (defined above)

#macro TEXAN_DEBUG_LEVEL     2  //0 = No debug message, 1 = Limited debug messages, 2 = Verbose debug messages
#macro TEXAN_GM_DEBUG_LEVEL  2  //0 = No debug message, 1 = Limited debug messages, 2 = Verbose debug messages






















#region Internal System Stuff

#macro __TEXAN_VERSION  "1.0.0"
#macro __TEXAN_DATE     "2020-08-31"

__texan_trace("Welcome to Texan by @jujuadams! This is version ", __TEXAN_VERSION, ", ", __TEXAN_DATE);

texture_debug_messages(TEXAN_GM_DEBUG_LEVEL);

global.__texan_flush                   = ds_list_create();
global.__texan_fetch                   = ds_list_create();
global.__texan_always_fetch            = ds_list_create();
global.__texan_texture_groups          = ds_list_create();
global.__texan_sprite_to_texture_group = ds_map_create();

//Add texture groups to our internal list
var _array = TEXAN_TEXTURE_GROUPS;
var _i = 0;
repeat(array_length(_array))
{
    var _texture_group = _array[_i];
    
    if (ds_list_find_index(global.__texan_texture_groups, _texture_group) < 0)
    {
        if (TEXAN_DEBUG_LEVEL >= 1) __texan_trace("Adding texture group \"", _texture_group, "\"");
        ds_list_add(global.__texan_texture_groups, _texture_group);
        
        var _sprites = texturegroup_get_sprites(_texture_group);
        var _s = 0;
        repeat(array_length(_sprites))
        {
            var _sprite = _sprites[_s];
            if (TEXAN_DEBUG_LEVEL >= 2) __texan_trace("\"", _texture_group, "\" has sprite ", sprite_get_name(_sprite), " (", _sprite, ")");
            global.__texan_sprite_to_texture_group[? _sprite] = _texture_group;
            ++_s;
        }
    }
    
    ++_i;
}

//Add always-fetch textures to our internal list
var _array = TEXAN_ALWAYS_FETCH;
var _i = 0;
repeat(array_length(_array))
{
    var _texture_group = _array[_i];
    
    if (ds_list_find_index(global.__texan_always_fetch, _texture_group) < 0)
    {
        if (TEXAN_DEBUG_LEVEL >= 2) __texan_trace("Texan: Always fetching \"", _texture_group, "\"");
        ds_list_add(global.__texan_always_fetch, _texture_group);
        texan_fetch(_texture_group);
    }
    
    ++_i;
}

if (TEXAN_COMMIT_ON_BOOT) texan_yeehaw();

function __texan_trace()
{
    var _string = "";
    var _i = 0;
    repeat(argument_count)
    {
        _string += string(argument[_i]);
        ++_i;
    }
    
    show_debug_message("Texan: " + _string);
    return _string;
}

#endregion