# Everything::Cli

A script to help automate regular tasks on your `everything` repo.

## Install

Once you have the source loally, install the needed gems.

`bundle install --path=.bundle`

## Advanced

To make the everything CLI available anywhere, we can modify the PATH to
append the `bin` directory and create an alias so that Bundler is used
correctly.

If you use `zsh`, you can add this to your `.zshrc`:

```
export PATH=$PATH:/path/to/your/copy/of/everything-cli/bin
alias ev="BUNDLE_GEMFILE=/path/to/your/copy/of/everything-cli/Gemfile bundle exec ev ${@:2}"

```

Now, when you're in your `everything` repo, you can use the everything CLI
like:

```
ev open_new the-title-for-your-new-piece
```

### Commands

#### ev new {PIECE_NAME}

Create a new `everything` piece at your current location.

A folder will be created with the piece name you give. The piece name should
be `in-the-spinal-case-format`.

Inside this folder will be an `index.md`, which has a markdown title for the
piece, and some additional whitespace, so you can get to writing your content
immediately.

There will also be an `index.yaml`, which has some default content, to specify
that this piece is not public. This setting, or any others you provide, might
be used by various `everything` extensions.

### ev open {PIECE_NAME}

Uses the `everything` piece by the name you give, which it finds in the
currect directory.

Opens the content and metadata files in `gvim` in a vertical split.

This makes it fast to edit an existing `everything` piece.

Note: If you're in the piece's folder, you can do `ev open .`!

### ev open_new {PIECE_NAME}

Creates a new `everything` piece, like `new` above.
Then opens the piece, like `open` above.

Since `new` gives the files some boilerplate content, and `open_new` opens the
files in `gvim`, this makes it very fast to start writing a new `everything`
piece!

## License

MIT

