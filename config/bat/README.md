# bat config files

https://github.com/sharkdp/bat

## Syntaxes

You can add SublimeText syntax files, like Groovy.
After upgrading bat or adding a syntax file, run:

```shell
$ bat cache --build
$ bat --list-languages
```

## Themes

@see http://tmtheme-editor.herokuapp.com/

You can add SublimeText theme files, like Darkula.
After upgrading bat or adding theme files, run:

```shell
$ bat cache --build
$ bat --list-themes
```

If you want to preview the different themes on a custom file,
you can use the following command:

```shell
$ bat --list-themes | fzf --preview="bat --theme={} --color=always /path/to/file"
```
