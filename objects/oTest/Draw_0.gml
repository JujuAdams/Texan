var _string = string_join("\n",
                          string_concat("Texan ", __TEXAN_VERSION, " test"),
                          "",
                          "1: Fetch Default",
                          "2: Fetch tgDynamic",
                          "3: Flush Default",
                          "4: Flush tgDynamic",
                          "",
                          string_concat("Completed = ", TexanGetComplete()),
                         );

draw_text(10, 10, _string);