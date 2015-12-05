+++
copyright = "Copyright 2015 Jonathan Bowman. All documentation and code contained on this page may be freely shared in compliance with [the Apache License, Version 2.0](http://www.apache.org/licenses/LICENSE-2.0), and is **provided \"AS IS\" without warranties or conditions of any kind**."
date = "2015-10-24T06:47:43-04:00"
description = "Build a static website using Hugo, a generator written in Go (golang), and build a theme from scratch."
title = "Building a static website from scratch (unthemed) with Hugo"

+++

This article shares the experience of creating a new website, with the following goals:

- Use the [Hugo](http://gohugo.io) static website generator
- Use custom styling (do not re-use an existing Hugo theme)

## Step 1: install Hugo

Install Hugo by going to [the website](http://gohugo.io), downloading and installing it according to your platform.

## Step 2: initialization

As an example, the rest of these instructions will assume we are constructing a site featuring commentary on various programming languages. The site's name will be "Polyglot."

You will find this much more interesting if you work on your own ideas, so please make the appropriate substitutions of title, settings, and content. Of course, you, too, may have a burning desire to write about programming languages! Feel free to imitate and/or adapt.

So, let's get started. From the command line:

```
hugo new site polyglot
```

Now enter the `polyglot` directory and edit the `config.toml` configuration file.

```toml
baseurl = "http://bowmansolutions.github.io/polyglot/"
languageCode = "en-us"
title = "Polyglot"
pluralizeListTitles = false
```

I use `pluralizeListTitles = false` because otherwise Hugo tries to be too helpful, pluralizing section titles, for instance.


We need at least *some* content, so let's create a home page. Here is mine:

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>{{ .Site.Title }}</title>
</head>
<body>
  <h1>Welcome to {{ .Site.Title }}</h1>
</body>
</html>
```

Note that we used a Hugo variable (`.Site.Title` in this case, which is set in the `config.toml` file). You may [read about other variables](https://gohugo.io/templates/variables/) in the Hugo documentation.

## Step 3: start local development server

Let's see if the site works. From the command-line:

```
hugo server --watch
```

Hugo should respond with a URL, something like `http://localhost/polyglot:1313`. Using your browser of choice, simply navigate to whatever URL it tells you. Hopefully, you have successfully launched a working Hugo-generated site!

Impressive.

Note that, when `hugo server` is launched with the flag `--watch`, any changes you make to relevant files will re-generate the site, and refresh your browser. Convenient.

## Step 4: versioning and deployment

You likely have a deployment strategy in mind, and you can deploy at any time. Skip this step if you are not ready.  Now is a great time to commit your work to version control, though, and your deployment and version control may be connected, if they are like mine.

So, if appropriate, commit to version control now (using [Git](https://git-scm.com/), [Subversion](https://subversion.apache.org/), [Mercurial](https://www.mercurial-scm.org/), [Bazaar](http://bazaar.canonical.com), or similar tool).

I use Git, in this case hosted by [Github](https://github.com/), and also plan to use [Github pages](https://pages.github.com/) to host the website. If you, too, plan to host your Hugo site using Github pages, you may want to take a look at [Github's instructions](https://help.github.com/articles/creating-project-pages-manually/) or [Hugo's instructions](https://gohugo.io/tutorials/github-pages-blog/) for further guidance.

## Step 5: organize

Feel free to skip this step and generate some content first (go to step 6).

Hugo organizes your content according to sections, as determined by your directory structure. You can [read more about this in the Hugo docs](https://gohugo.io/content/organization/).

Because my project is about computer programming languages, I am going to organize my posts into three sections, based on a highly technical categorization scheme:

- Programming languages I like
- Programming languages I avoid
- Programming languages I am curious about

So, I can create these directories in the `content` directory:

```
cd content
mkdir like avoid curious
cd ..
```

Note that I could have waited and let Hugo create these directories when I create the individual pages. Just trying to plan ahead.

## Step 6: add some content

Now is a good time to create a few posts, so that when we work on our layout, we can actually view how the layout affects the content. I create content using [Markdown](https://daringfireball.net/projects/markdown/), the default for Hugo, using the `hugo new` command:

```
hugo new like/python.md
hugo new like/go.md
hugo new like/lua.md
hugo new avoid/visualbasic.md
hugo new avoid/cobol.md
hugo new curious/rust.md
hugo new curious/elm.md
```

Now I'll edit each one, adding content. I will spare you the details, but as examples, here are the entries for lua and rust:

```markdown
+++
tags = [ "fast", "embeddable", "interpreted", "procedural" ]
categories = [ "Applications" ]
date = "2015-11-09T09:40:47-05:00"
description = "Lua, a small, fast scripting language"
draft = true
title = "Lua"
+++

From [the Lua "about" page](http://www.lua.org/about.html):

> Lua is a powerful, fast, lightweight, embeddable scripting language.
>
> Lua combines simple procedural syntax with powerful data description
> constructs based on associative arrays and extensible semantics. Lua is
> dynamically typed, runs by interpreting bytecode for a register-based virtual
> machine, and has automatic memory management with incremental garbage
> collection, making it ideal for configuration, scripting, and rapid
> prototyping. 
```
<br>
```markdown
+++
tags = [ "fast", "managed", "compiled", "thread-safe" ]
categories = [ "Systems" ]
date = "2015-11-09T09:40:47-05:00"
description = "Rust, a low-level compiled systems programming language aiming to be fast and safe"
draft = true
title = "Rust"
+++

From [the Rust book](https://doc.rust-lang.org/stable/book/):

> Rust is a systems programming language focused on three goals: safety, speed,
> and concurrency. It maintains these goals without having a garbage collector,
> making it a useful language for a number of use cases other languages aren’t
> good at: embedding in other languages, programs with specific space and time
> requirements, and writing low-level code, like device drivers and operating
> systems. It improves on current languages targeting this space by having a
> number of compile-time safety checks that produce no runtime overhead, while
> eliminating all data races. Rust also aims to achieve 'zero-cost abstractions'
> even though some of these abstractions feel like those of a high-level
> language. Even then, Rust still allows precise control like a low-level
> language would.
```

## Step 7: layout

If your site is like mine, it looks quite boring now. At this point, we can [install a theme](https://gohugo.io/themes/installing) that someone else has made. There are many good ones over at the [Hugo themes site](https://themes.gohugo.io/). If that is the route you choose now, I suggest you delete `layouts/index.html`, install a theme of your choosing, and have fun.

If you want to work on your own layout, however, then read on.

For now, I do not plan to create a reusable theme, so I will not use a `themes` directory. Instead, the layout will exist in `layouts`, and style sheets in `static`. If you prefer to start with a new theme in the `themes` directory, take a look at [the theme docs](http://gohugo.io/themes/creation/).

We have already begun the layout with `layouts/index.html`. This file is not absolutely necessary, unless, like me, you want a landing page.

Two files that *are* necessary for most any site, especially blogs, are `layouts/_default/single.html` for displaying a single entry, and `layouts/_default/list.html` for listing entries. You can create those files now.

To reduce redundant HTML in these three templates, let's make some partials for the header and footer material. These can then be shared across the templates. Partials live in the `layouts/partials` directory.

Here is my `layouts/partials/header.html`:

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="generator" content="Hugo {{ .Hugo.Version }}">
  <title>{{ .Site.Title }}: {{ title .Title }}</title>
  <link rel="stylesheet" href="{{ .Site.BaseURL }}assets/main.css">
</head>
<body>
<h1>{{ title .Title }}</h1>
```

Note that I threw a CSS style sheet link in there, which corresponds to a file in `static/assets/main.css`. Put whatever styles you want in your file; I am going to continue with my ugly/boring motif.

Also note the use of the `title` template function at several points. This simply renders a string in "titlecase" (capitalizing first letters). There are [many more Hugo template functions](https://gohugo.io/templates/functions/) available.

And here is `layouts/partials/footer.html`:

```html
<hr>
Built {{ .Now.Format "Monday, January 2, 2006 at 3:04 pm" }}.
</body>
</html>
```

Side note: when writing a format string in Go, the reference time is `Mon Jan 2 15:04:05 MST 2006` (aka `01/02 03:04:05PM '06 -0700`. Now isn't that clever?) Format that time however you want in your format string. See the [Go programming documentation for `time`](https://golang.org/pkg/time/) for more information. 

With the `header.html` and `footer.html` partials, `layouts/_default/single.html` might look like this:

```html
{{ partial "header.html" . }}
{{ .Content }}
{{ partial "footer.html" . }}
```

Fairly simple. Each page has a `.Content` variable that contains the parsed content of that page. In this case, the markdown text is converted to HTML.

Just a reminder: [read the variable reference](http://gohugo.io/templates/variables/) to see what all is available. Experiment.

Now let's get a tad more complex with `layouts/_default/list.html`:

```html
{{ partial "header.html" . }}
<ul>
  {{ range .Data.Pages }}
  <li><a href="{{ .Permalink }}">{{ title .Title }}</a></li>
  {{ end }}
</ul>
{{ partial "footer.html" . }}
```

This uses the `range` function to iterate over the pages relevant to this list, extracting the link and title of each page. Within the `range` loop, the context is represented by `.` so that `.Permalink` and so on refer only to the page (in this case) currently being iterated over. [Read the Go template primer](http://gohugo.io/templates/go-templates/) from the Hugo docs or [read the Go docs](https://golang.org/pkg/html/template/) for more details.

Let's do something similar with `layouts/index.html`:

```html
{{ partial "header.html" . }}
<ul>
{{ range $section, $pages := .Site.Sections }}
  <li><a href="{{ $.Site.BaseURL }}{{ $section }}">{{ title $section }}</a></li>
{{ end }}
</ul>
{{ partial "footer.html" . }}
```

The `range` function is used again here, this time with variables specified, instead of just assuming context. `.Site.Sections` is a Go map, so it will be iterated over in key/value pairs, with `$section` receiving the key. In this case, that will be the section directory name.

## Conclusion

The site should be in a usable state at this point. Edit the style sheet, add content, and continue to edit and add layout components, using partials as needed. And, of course, [explore the Hugo docs](http://gohugo.io/overview/introduction/).
