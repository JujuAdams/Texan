#macro TEXAN_TEXTURE_GROUPS  ["Default"] //Array of texture groups in the game. I'd love for this to be automatic but GameMaker doesn't give us that data at runtime...?!
#macro TEXAN_ALWAYS_FETCH    []          //Array of texture groups for Texan to always keep loaded. Always-fetch texture groups cannot be flushed by Texan as a result
#macro TEXAN_COMMIT_ON_BOOT  true        //Whether to call texan_commit() on boot to load in always-fetch texture groups (defined above)

#macro TEXAN_DEBUG_LEVEL     2  //0 = No debug message, 1 = Limited debug messages, 2 = Verbose debug messages
#macro TEXAN_GM_DEBUG_LEVEL  2  //0 = No debug message, 1 = Limited debug messages, 2 = Verbose debug messages






















#region Internal System Stuff



#endregion