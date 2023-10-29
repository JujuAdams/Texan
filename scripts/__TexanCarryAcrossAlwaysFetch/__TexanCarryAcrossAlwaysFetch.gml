// Feather disable all

function __TexanCarryAcrossAlwaysFetch()
{
    if ((array_length(_global.__fetchArray) <= 0) && (array_length(_global.__alwaysFetchArray) >= 1))
    {
        array_copy(_global.__fetchArray, 0, _global.__alwaysFetchArray, 0, array_length(_global.__alwaysFetchArray));
        _global.__flushCount += array_length(_global.__alwaysFetchArray);
    }
}