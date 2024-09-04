# ./doit.awk urls -v title=";login: 202408-202107"

BEGIN {
    article = 0
    skip = 0
}

$0 ~ /^-   \[\[Log.*/ {
    article = 0
}

$0 ~ /::: \{.*/{
    skip = 1
}
$0 ~ /^:::\s*$/ {
    skip = 1
}

$0 ~ /::: .*/ {
    skip = 1
}

$0 ~ /^\[Donate.*/ {
    skip = 1
}

$0 ~ /^Today\].*/ {
    skip = 1
}

$0 ~ /^target="_blank"}.*/ {
    skip = 1
}


{
    if(article == 1 && skip == 0){
        if($0 ~ /^# /){
            print gensub(/{.*/, "", "g", $0)
        } else {
            print $0
        }
    }
}

$0 ~ /.*/ {
    skip = 0
}

$0 ~ /::: tabs/ {
    article = 1
}

