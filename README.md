# Mvmv

Simple batch renaming script.

## Installation

    $ gem install mvmv

## Usage

```
usage:    mvmv [OPTIONS] <command> [<args>] <files>

commands:
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

options:
          -f, --force       Force rename
              --no-color    Disable ANSI color codes
```

## Examples

### Adding simple prefix and suffix to files

```
mvmv prefix old_ *.txt
mvmv suffix .bak *.txt
```

### Numbering files

You can attach sequence numbers to files with a series of `#`s.
Depending on the number of `#`s, numbers will be padded with zeros.

```
mvmv name Photo#### *.jpg *.gif *.png
mvmv name-suffix -## *.jpg
```

### Advanced renaming with regular expressions

`regexp` command performs regular expression substitutions. (`regexpi` is the case-insensitive version.)
`name-regexp` command performs regular expression subsitution only on the name parts of the given files.

```
mvmv name-regexp '^(.*)_-_(.*)$' '\2 - \1' *.mp3
```

