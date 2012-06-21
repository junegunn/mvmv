# Mvmv

"Move! Move!"

## Installation

    $ gem install mvmv

## Usage

```
usage: mvmv <command> [<args>] <files>

       mvmv prefix       <prefix>     <files>
       mvmv suffix       <suffix>     <files>
       mvmv name         <name>       <files>
       mvmv name-suffix  <suffix>     <files>
       mvmv ext          <.extension> <files>
       mvmv upper                     <files>
       mvmv lower                     <files>

       mvmv regexp       <from> <to>  <files>
       mvmv regexpi      <from> <to>  <files>
       mvmv name-regexp  <from> <to>  <files>
       mvmv name-regexpi <from> <to>  <files>

    -f, --force                      Force rename
        --no-color                   Disable ANSI color codes
        --help                       Show this message
```

## Examples

### Adding simple prefix and suffix to files

```
mvmv prefix old_ *.txt
mvmv suffix .bak *.txt
```

### Numbering files

You can attach sequence numbers to files with a series of `#`s.

```
mvmv name Photo#### *.jpg *.gif *.png
mvmv name-suffix -#### *.jpg
```

### Advanced renaming with regular expressions

`regexp` command performs regular expression substitutions. (`regexpi` is the case-insensitive version.)
`name-regexp` command performs regular expression subsitution only on the name parts of the given files.

```
mvmv name-regexp '^(.*)_-_(.*)$' '\2 - \1' *.mp3
```

