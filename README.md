## New feature

# 1. Create new branch feature-[name]

* git checkout develop
* git checkout -b feature-export

# 2. Merge back to develop

* git checkout develop
* git merge --no-ff feature-export
* git branch -d feature-export


## New release to AppStore

# 1. Create new brach release-[version-number]

* git checkout develop
* git checkout -b release-v1.0.1

# 2. Upload to iTunesConnect from release-v1.0.1

* Prepare before submitting
* Upload to AppStore
* Fix any issue if being rejected

# 3. When available on AppStore, merge to develop and master

* git checkout develop
* git merge --no-ff release-v1.0.1
* git checkout master
* git merge --no-ff release-v1.0.1

## Key points
* master always has stable code, latest on AppStore
* develop have current working code
