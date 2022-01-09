/// Returns the number of operations that have not been completed yet

function TexanGetOperationsRemaining()
{
    return ds_list_size(global.__texanFlush) + ds_list_size(global.__texanFetch);
}