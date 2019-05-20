Personal notes for publishing a new version:

1. Tag the version with Git (e.g. `git tag v1.2.3`)
1. Push the tag out (`git push --tags`)
1. Go to https://github.com/nvie/git-toolbelt/tags
1. Create a release from a tag
1. Compute the SHA1 hash:  
       `wget -O - https://github.com/nvie/git-toolbelt/archive/v1.2.2.tar.gz | sha256sum`
1. `cd homebrew-tap`
1. Update URL + sha256 value
