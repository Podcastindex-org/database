# Database

This is the main place for database related information, work, exports, etc.

Download our full podcast database as a sqlite3 file [over IPFS](https://cloudflare-ipfs.com/ipns/k51qzi5uqu5dkde1r01kchnaieukg7xy9i6eu78kk3mm3vaa690oaotk1px6wo/podcastindex_feeds.db.tgz) or [using HTTP](https://public.podcastindex.org/podcastindex_feeds.db.tgz).

# Sample export of the "newsfeeds" table

Most of the field names are obvious.  But, for clarity, here are the meanings of others:

* lastcheck - The last time the feed was pulled (successfully or not) by the [aggrivate](https://github.com/Podcastindex-org/aggregator) app.
* lastupdate - The channel level pubdate if we can determine one.
* lastmod - The value of the http "Last-Modified" header on the last pull.
* errors - Errors encountered by aggrivate when pulling.
* updated - A flag set by aggrivate to let the parser know if the feed has updated content it should parse.  This is set to the node id 
            that the current copy of aggrivate is running on.  This node id number is how the parser knows which node the file containing the new
            feed content lives on.
* lastitemid - Not currently used.
* pubdate - Not currently used.
* contenthash - An MD5 hash of the current feed content
* dead - The feed has had too many errors and should not be checked anymore
* original_url - The url of this feed when it was first added to the database.
* artwork_url_600 - Sometimes we can get a hi-res image url from itunes.  If so, it lives here.
* type - 0 = RSS, 1 = ATOM
* parse_errors - The number of errors encountered while parsing the feed
* pullnow - This is a flag. If set to 1, aggrivate will always pull it first before anything else.
* parsenow - This is a flag. If set to 1, partytime will parse this feed first before anything else.
* newest_item_pubdate - The unix timestamp of the newest item we could find in the feed.
* update_frequency - Set to a number 1-9 based on the interval between what "newest_item_pubdate" is now and what "newest_item_pubdate" was before 
                     that.  The smaller the number, the shorter that interval was.
* priority - This is a flag.  Some podcasts are just really popular and need to be checked frequently to make sure they aren't missed.  This can be 
             set manually or through automated popularity discovery.
* detected_language - Not used yet.


Everything in this repo is under the [MIT](https://opensource.org/licenses/MIT) license.
