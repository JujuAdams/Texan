// Feather disable all

/// @param array
/// @param index

function __TexanArrayFindIndex(_array, _value)
{
    var _i = 0;
    repeat(array_length(_array))
    {
        if (_array[_i] == _value) return _i;
        ++_i;
    }
    
    return undefined;
}