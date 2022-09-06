#!/bin/bash

# telegram 
echo "select domain from domain_by_id where domain like '%telegram%'" | sqlite3 ~/pihole/etc-pihole/pihole-FTL.db >> domains/messangers.txt
echo "select domain from domain_by_id where domain like '%t.me%'" | sqlite3 ~/pihole/etc-pihole/pihole-FTL.db >> domains/messangers.txt

# whatsapp
echo "select domain from domain_by_id where domain like '%whatsapp%'" | sqlite3 ~/pihole/etc-pihole/pihole-FTL.db >> domains/messangers.txt

# signal
echo "select domain from domain_by_id where domain like '%signal%'" | sqlite3 ~/pihole/etc-pihole/pihole-FTL.db >> domains/messangers.txt

# netflix
echo "select domain from domain_by_id where domain like '%nflxvideo%'" | sqlite3 ~/pihole/etc-pihole/pihole-FTL.db >> domains/netflix.txt
echo "select domain from domain_by_id where domain like '%netflix%'" | sqlite3 ~/pihole/etc-pihole/pihole-FTL.db >> domains/netflix.txt
echo "select domain from domain_by_id where domain like '%nflxo%'" | sqlite3 ~/pihole/etc-pihole/pihole-FTL.db >> domains/netflix.txt

# linkedin
echo "select domain from domain_by_id where domain like '%linked%'" | sqlite3 ~/pihole/etc-pihole/pihole-FTL.db >> domains/linkedin.txt
echo "select domain from domain_by_id where domain like '%licdn%'" | sqlite3 ~/pihole/etc-pihole/pihole-FTL.db >> domains/linkedin.txt

# facebook
echo "select domain from domain_by_id where domain like '%facebook%'" | sqlite3 ~/pihole/etc-pihole/pihole-FTL.db >> domains/facebook.txt
echo "select domain from domain_by_id where domain like '%fbcdn%'" | sqlite3 ~/pihole/etc-pihole/pihole-FTL.db >> domains/facebook.txt

# youtube
echo "select domain from domain_by_id where domain like '%ggpht%'" | sqlite3 ~/pihole/etc-pihole/pihole-FTL.db >> domains/youtube.txt
echo "select domain from domain_by_id where domain like '%googleusercontent.com%'" | sqlite3 ~/pihole/etc-pihole/pihole-FTL.db >> domains/youtube.txt
echo "select domain from domain_by_id where domain like '%ytimg.com%'" | sqlite3 ~/pihole/etc-pihole/pihole-FTL.db >> domains/youtube.txt

# amazon cloudfront
echo "select domain from domain_by_id where domain like '%cloudfront.net%'" | sqlite3 ~/pihole/etc-pihole/pihole-FTL.db >> domains/cloudfront.txt

for filename in domains/*; do
    echo "Sorting and cleaning dupes in $filename"
    sort -u -o $filename $filename
done
