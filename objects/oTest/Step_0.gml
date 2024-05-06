if (keyboard_check_pressed(ord("1")))
{
    TexanFetch("tgTest");
}

if (keyboard_check_pressed(ord("2")))
{
    TexanFetch("tgDynamic");
}

if (keyboard_check_pressed(ord("3")))
{
    TexanFlush("tgTest");
}

if (keyboard_check_pressed(ord("4")))
{
    TexanFlush("tgDynamic");
}

if (keyboard_check_pressed(vk_enter))
{
    TexanCommit();
}