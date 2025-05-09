### Add the Original Repo as Upstream

This allows you to pull the latest updates from `bizz84`'s repo later:

```bash
git remote add upstream https://github.com/bizz84/flutter-firebase-masterclass.git
```

Check remotes with:

```bash
git remote -v
```

You should see:

```
origin    https://github.com/yourusername/flutter-firebase-masterclass.git (fetch)
upstream  https://github.com/bizz84/flutter-firebase-masterclass.git (fetch)
```

---

###  Create Your Own Branches, Make Changes, and Commit

For example:

```bash
git checkout -b my-tweaks
# Make your code changes
git add .
git commit -m "My custom changes"
git push origin my-tweaks
```

Now it's on your GitHub and tracked under your own commit history.

---

###  Stay Updated with Original Repo

To pull updates from `bizz84`:

```bash
git checkout main
git pull upstream main
git push origin main
```

To sync branches:

```bash
git fetch upstream
git checkout some-branch
git merge upstream/some-branch
git push origin some-branch
```

