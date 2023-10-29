// Feather disable all

/// Flushes and fetches texture groups (as directed by calling TexanFlush() / TexanFetch() etc.)
/// This function will complete all Texan operations in a single frame. This is convenient but
/// may lead to a bad user experience if there are long loading times. Instead, consider creating
/// a loading screen and using TexanCommitStep() to gradually handle operations over many frames

function TexanCommitAll()
{
    while(!TexanCommitStep()) {}
}

function TexanYeehaw()
{
    TexanCommitAll();
}