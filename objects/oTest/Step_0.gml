if (keyboard_check_pressed(ord("1")))
{
    TexanFetch("Default");
}

if (keyboard_check_pressed(ord("2")))
{
    TexanFetch("tgDynamic");
}

if (keyboard_check_pressed(vk_enter))
{
    TexanCommit();
}