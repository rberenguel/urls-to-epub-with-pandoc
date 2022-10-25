BEGIN {
    show = 0
    entry_tag = 0
    strip = 0
}

$0 ~ /journal-entry-text/ {
    show = 1
    strip = 1
}

$0 ~ /journal-entry-tag/ {
    entry_tag = 1
}

$0 ~ /:::$/ {
    entry_tag = 0
}

$0 ~ /::: {.journal-entry-tag .journal-entry-tag-post-body}/ {
    show = 0
}

{
    if (show == 1 && strip == 1 && $0 ~ /##/) {
        print substr($0, 2)
        strip = 0
    }
    else if (show == 1 && entry_tag == 0) {
        print $0
    }
}
