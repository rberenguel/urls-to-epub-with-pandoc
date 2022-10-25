#!/opt/homebrew/bin/gawk -f

@include "messages.awk"

BEGIN { 
    FS = "/" 
}

NR < 3 {
    filename = sprintf("%04d%02d%02d-%s", $(NF-3), $(NF-2), $(NF-1), $(NF))
    sub(/\.html/, "", filename)
    pd="pandoc --request-header User-Agent:\"Mozilla/5.0\" --standalone --from html " $0 " --to markdown --output markdown/" filename ".md --embed-resources"
    awk="awk -f clean.awk markdown/" filename ".md > markdown/" filename "-clean.md"
    print green("Fetching URL " $0)
    print "Command: " amber(pd)
    system(pd)
    print green("Cleaning up " filename)
    print "Command: " amber(awk)
    system(awk)
    print green("Sleeping")
    system("sleep 15")
}

END {
    print green("--------------------")
    print green("Generating EPUB")
    epub="zsh -c \"pandoc -f markdown -t epub -o output/HS.epub --metadata title='High Scalability examples' --toc-depth 1 markdown/*clean.md(On)\""
    print "Command: " amber(epub)
    system(epub)
}