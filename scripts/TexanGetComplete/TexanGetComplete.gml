/// Returns whether Texan has finished processing all of its queued operations

function TexanGetComplete()
{
    return global.__texanComplete;
}