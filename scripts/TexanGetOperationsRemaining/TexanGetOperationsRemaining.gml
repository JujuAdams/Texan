/// Returns the number of operations that have not been completed yet

function TexanGetOperationsRemaining()
{
    static _global = __TexanInitialize();
    return array_length(_global.__flushArray) + array_length(_global.__fetchArray);
}