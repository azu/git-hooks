# @azu/git-hooks [![Actions Status](https://github.com/azu/git-hooks/workflows/test/badge.svg)](https://github.com/azu/git-hooks/actions?query=workflow%3A"test")

[@azu](https://github.com/azu)'s global git hooks.

## Features

- Global Git Hooks collection
    - Using [`core.hooksPath`](https://git-scm.com/docs/githooks) on Git 2.9+
- If project has set up local git hook, call local hooks too
    - Order: local hooks -> global hooks 
- Define ignoring project by `IGNORE_GLOBAL_HOOKS` file

## Hooks

- `pre-commit`
    - [secretlint](https://github.com/secretlint/secretlint) prevent to commit credentials

## Installation

**Requirement:**

- Node.js 22+
- Git 2.9+
- 1Password CLI

Check if you already have any global git hooks:

    git config --global core.hooksPath

If output is not empty, run following steps:

```shell script
# clone this repository
git clone https://github.com/azu/git-hooks.git git-hooks
cd git-hooks
# Install Dependencies
yarn install
# setup git config
git config --global core.hooksPath $(pwd)/hooks
```

## Load env using 1Password CLI

    op inject --in-file .env.local.template --out-file .env

## Zsh Integration

Some project have defined `core.hooksPath` in git config.

- Example: [Git Hooks without extra dependencies like Husky in Node.js project - DEV Community 👩‍💻👨‍💻](https://dev.to/azu/git-hooks-without-extra-dependencies-like-husky-in-node-js-project-jjp)

Git prefer to use local `core.hooksPath` than global `core.hooksPath`.

So, I've overridden the local `core.hooksPath` with global hooks paths.

```
# Override <project>/.githook → <global>/git-hooks/hooks/
function preexec_git_global_hooks() {
  inside_git_repo="$(git rev-parse --is-inside-work-tree 2>/dev/null)"
  if [ "$inside_git_repo" ]; then
      githooksDir=$(git rev-parse --show-toplevel)"/.githooks"
      if [ -d "${githooksDir}" ]; then
        git config --local core.hooksPath "/path/to/git-hooks/hooks"
      fi;
  fi
}
autoload -Uz add-zsh-hook
add-zsh-hook preexec preexec_git_global_hooks
```

## Options

You have set up, then bootstrap script create `IGNORE_GLOBAL_HOOKS` file.
It is collection of absolute path to ignore global hooks.

`IGNORE_GLOBAL_HOOKS`:
```
/path/to/my-project-a
/path/to/my-project-b
```

If the project path is included in `IGNORE_GLOBAL_HOOKS`, global git hook does not run. 

## FAQ

### How to ignore `pre-commit` hook

Use [`--no-verify`](https://git-scm.com/docs/git-commit#Documentation/git-commit.txt---no-verify) options.

```
git commit --no-verify
```

## Contributing

Pull requests and stars are always welcome.

For bugs and feature requests, [please create an issue](https://github.com/azu/git-hooks/issues).

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D

## Author

- [github/azu](https://github.com/azu)
- [twitter/azu_re](https://twitter.com/azu_re)

## License

MIT © azu

## Acknowledgement

- [globalなgit-hooksを設定して、すべてのリポジトリで共有のhooksを使う - Qiita](https://qiita.com/ik-fib/items/55edad2e5f5f06b3ddd1)
