# Faker

Genuine to Fake, Fake to Genuine.

## What this?

You can create *fake file*, which is the copy of the current *genuine file*.

And you can replace the *geinuine file* to the *fake file* after editing the *fake file*.

## Setup

```el
;; write the code as bellow in your init.el
(add-to-list 'load-path "/path/to/faker")
(require 'faker)
```

## Usage

You can execute commands bellow.

### `genuine-to-fake`

Create *fake file* in faker-directory.

The *fake file* is the copy of the current file.

### `fake-to-genuine`

The *genuine file* is replaced by *fake file*.

### `find-fake`

Find whether the current file has *fake file*.

If it has, open the *fake file*.

### `find-genuine`

Find whether the *fake file* has *genuine file*.

If it has, open the *genuine file*.
