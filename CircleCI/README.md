# Autobuilding a website and pushing the results using CircleCI

Using CircleCI, it is possible to store a deploy key that lets CircleCI push to a certain repository/branch.

To automatically deploy a website, first sign up for CircleCI using your GitHub account.

Afterwards, follow [this guide](https://github.com/nielsenramon/kickster#automated-deployment-with-circle-ci),
but use [this file](https://github.com/nu-dev/build-scripts/blob/master/CircleCI/ghpublish.sh) instead of the `automated` script, and
[this file](https://github.com/nu-dev/build-scripts/blob/master/CircleCI/circle.yml) for `circle.yml` (still do replace [lines 3&4](https://github.com/nu-dev/build-scripts/blob/master/CircleCI/circle.yml#L3-4)
with your information, though). Make sure you add the user deploy key - that is the most important part!

Now, when you push to root of that repository, nu will run automatically and build your website, then it will get pushed.
