<p align="center"><img src="https://raw.githubusercontent.com/JujuAdams/Texan/master/LOGO.png" style="display:block; margin:auto; width:300px"></p>
<h1 align="center">Texan 2.2.2</h1>

<p align="center">Texture group flush/fetch manager for GameMaker 2022 LTS</p>

<p align="center"><a href="https://github.com/JujuAdams/Texan/releases/">Download the .yymps</a></p>

<p align="center">Chat about Texan on the <a href="https://discord.gg/7uyVURrT6P">Discord server</a></p>

&nbsp;

&nbsp;

Executing individual texture fetches and texture flushes in GameMaker is straight-forwards. However, you may have noticed some minor difficulties when trying to make multiple flush and fetch commands as smooth as possible for the player. Texan helps you with this problem by automating the logic of texture flushing and fetching.

For example, let's say you have an semi-open world game in the vein of the 2D Zelda games where you need two different sets of textures in two different rooms. There's a little bit of overlap between the two rooms - they share textures A and B - but there are also differences. Room 1 needs texture C, room 2 needs texture D. For the purposes of demonstration, let's say we're moving from room 1 to 2. This means we'll need to keep textures A and B, flush texture C, and fetch texture D.

The stopgap solution (uncharitably we'd call this "naive") is to flush all the textures and then load everything we need. This is guaranteed to work but is, regretably, slow. Loading three textures (A, B, and D) from scratch is going to take a while, even after the recent texture decompression optimisations. Ideally we just want to load texture D. In this simple situation you'd probably hardcode the solution, but when you've got a multitude of textures to juggle in an on-going production this task fast escapes what is reasonable to hardcode.

This is where Texan steps in. You give Texan a list of textures you want to fetch and a list of textures you want to flush. If a texture is in both lists, the texture is fetched. That's it! It's a really simple solution. You can also elect to try to flush all unwanted textures which is great if you're looking to be conservative with your memory usage.

Texan has been used in [The Swords Of Ditto](https://store.steampowered.com/app/619780/The_Swords_of_Ditto_Mormos_Curse/) and [Skies Of Chaos](https://www.youtube.com/watch?v=dSyWXQv3HOY) to great success, improving load times whilst also reducing the overall memory footprint.
