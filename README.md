# cap-git-tags

## What is it?

This is a capistrano 3 plugin for auto tagging your git deploys.

## Installation

In a gemfile:

```ruby
gem 'cap-git-tags'
```

In your *Capfile*:

```ruby
require 'cap-git-tags'
```

* * *

## Usage

### When you deploy to staging

You are prompted for a deploy note of what you have just changed, from this a staging tag is created:

    # We replace all non alpha-numeric characters in your notes with a '-'
    staging-YYYY-MM-DD-HH-mm-your-release-notes

### When you deploy to production

We lookup the latest staging tag in your git repo and go to deploy.
**You are prompted to confirm the deploy first**

We then create a new tag switching out the *staging* keyword for *prodution*.

### Overriding the production deploy tag/branch

If you set an environment variable **TAG** we'll use that for your production deploy e.g.

```sh
$ TAG=old_staging_release_tag cap production deploy
```

* * *

Copyright (c) 2014 Pete Hawkins, Adrian Dugan

MIT License

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
