# Convert some (particular) URLs to an EPUB

I want to read _several_ of the pages in the [`examples`](http://highscalability.com/blog/category/example) category in the [High Scalability](http://highscalability.com) blog, enough that I felt a bit sick when I started opening tabs.

Since I recently got a Kindle Paperwhite I'm really liking ([here's another recent EPUB related project for it](https://github.com/rberenguel/paprika-epub)) I thought _Can't I just convert these pages into a book?_

## The process

- A list of URLs is available in the file `urls`, which is parsed via…
- The `doit.awk` script ([name inspiration](https://disenchantment.fandom.com/wiki/Luci)), by running `./doit.awk urls` (you need gawk).

The script, in turn:

- Reads URLs line by line from the `urls` file;
- Creates a neat orderable filename based on each URL;
- Creates a `pandoc` command to fetch from the URL into the filename;
- Runs a `clean.awk` script that purges anything in the markdown file outside the body of the post;
- Sleeps 15 seconds to avoid being nasty to the destination server;
- Creates an EPUB from the cleaned-up markdowns sorted in lexicographical order.

## Why did you use AWK to do this?

I like AWK, and iterating through "arrays" in bash scripts or makefiles is a pain (imagine Captain Kirk screaming `xargs` instead of Khan), whereas iterating through lines in AWK and running a command is very natural. I have skipped checking for errors in the `pandoc` commands (you can get the output code from `system` as a return value, though) for brevity, but seriously, AWK is very convenient when you have something kick, dirty and where you know `bash` is going to be a pain.