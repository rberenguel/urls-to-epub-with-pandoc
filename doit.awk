#!/opt/homebrew/bin/gawk -f

@include "messages.awk"

BEGIN { 
    FS = "/"
}

{
    # The following separator via / is to handle YYYY/MM/DD style URL paths, assuming the 
    # URL looks like foo.bar.baz/whatever/YYYY/MM/DD/final-element-of-the-path
    filename = sprintf("%04d%02d%02d-%s", $(NF-3), $(NF-2), $(NF-1), $(NF))
    sub(/\.html/, "", filename)
    if(download == 1){
        pd="pandoc --request-header User-Agent:\"Mozilla/5.0\" --standalone --from html " $0 " --to markdown --output markdown/" filename ".md --embed-resources"
        print green("Fetching URL " $0)
        print "Command: " amber(pd)
        system(pd)
    }
    awk="awk -f clean.awk markdown/" filename ".md > markdown/" filename "-clean.md"
    print green("Cleaning up " filename)
    print "Command: " amber(awk)
    system(awk)
    print green("Sleeping")
    if(download == 1){
        system("sleep 15")
    }
}

END {
    print green("--------------------")
    print green("Generating EPUB")
    epub="zsh -c \"pandoc -f markdown -t epub -o output/output.epub --metadata title='" title "' --toc --toc-depth 1 markdown/*clean.md\""
    print "Command: " amber(epub)
    system(epub)
}
