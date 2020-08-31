/// Flushes and fetches texture groups (as directed by calling texan_flush() / texan_fetch() etc.)
/// The fetch and flush queues are cleared at the end of this function

function texan_commit()
{
    while(!texan_commit_step()) {}
}

function texan_yeehaw()
{
    texan_commit();
}