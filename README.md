# @azu/git-hooks

[@azu](https://github.com/azu)'s global git hooks.

## Features

- Global Git Hooks collection
    - Using [`core.hooksPath`](https://git-scm.com/docs/githooks) on Git 2.9+
- If project has setup local git hook, call local hooks too
    - Order: local hooks -> global hooks 

## Hooks

- `pre-commit`
    - [secretlint](https://github.com/secretlint/secretlint) prevent to commit credentials

## Installation

**Requirement:**

- Node.js 12+
- Git 2.9+

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

## FAQ

### Ignore `pre-commit` hook when commit example

Use [`--no-verify`](https://git-scm.com/docs/git-commit#Documentation/git-commit.txt---no-verify) options.

```
git commit --no-verify
```

## Changelog

See [Releases page](https://github.com/azu/git-hooks/releases).

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
