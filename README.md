# Neovio

```
# build burrito binary
MIX_ENV=prod mix release
```

Maybe relink the binary in xcode:

- Delete in sidebar
  - Remove reference
- Drag binary into sidebar
  - Tick "copy items if needed
  - Select "Create groups"
  - Select App target
- Go to Apps Build Phases
  - Add reference in "Copy files" phase
  - Destination of phase should be Executables

## Learn more

- Official website: https://www.phoenixframework.org/
- Guides: https://hexdocs.pm/phoenix/overview.html
- Docs: https://hexdocs.pm/phoenix
- Forum: https://elixirforum.com/c/phoenix-forum
- Source: https://github.com/phoenixframework/phoenix
