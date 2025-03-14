# Knowledge management tools

a collection of shell-script hackery that I use to manage pdfs and notes.
Mostly these concern ebooks and academic papers. I prefer a visual style
representation of my books, even as a command line troll.

## tools
### pdftc
create a table of contents from a pdf file. Useful for inclusion in a
note taking system such as roam, notion, or plain text files

![pdftc sample run](https://github.com/idrisr/knotools/blob/main/gifs/pdftc.gif)

To try it out after you have nix installed:

```
nix run --extra-experimental-features nix-command --extra-experimental-features flakes github:idrisr/knotools#pdftc <book.pdf>
```

### seder
remove a particular string from a pdf file. Useful for removing text watermarks.

### newcover
prepend an image to the title page of a pdf file, ie give a book a new cover.

### roamnamer
rename a node in the zettelkasten and all accompanying references

### booknote
create a table of contents from a pdf and add it to the zettelkasten
