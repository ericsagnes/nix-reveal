# Reveal.js slides Nix builder

example slides are in example/presentation.md.

Can be built by running:

```sh
$ nix-build --option build-use-sandbox false example
```

NOTE that `--option build-use-sandbox false` is required when using a
different theme than the default one and when `selfContained` is enabled
because Pandoc needs network access.
