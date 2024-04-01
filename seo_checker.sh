#!/bin/bash

# Function to check the Title tag of a website
check_title() {
    title=$(curl -s "$1" | grep -o '<title>.*</title>' | sed -e 's/<title>//g' -e 's/<\/title>//g')
    if [ -z "$title" ]; then
        echo "Title: Not found"
    else
        echo "Title: $title"
    fi
}

# Function to check the Meta Description of a website
check_meta_description() {
    meta_desc=$(curl -s "$1" | grep -o '<meta name="description" content=".*">' | sed -e 's/<meta name="description" content="//' -e 's/">//')
    if [ -z "$meta_desc" ]; then
        echo "Meta Description: Not found"
    else
        echo "Meta Description: $meta_desc"
    fi
}

# Function to check WordPress version
check_wordpress_version() {
    wp_version=$(curl -s "$1/readme.html" | grep -i '<h1 id="wordpress-version">' | sed -e 's/<[^>]*>//g')
    if [ -z "$wp_version" ]; then
        echo "WordPress Version: Not found"
    else
        echo "WordPress Version: $wp_version"
    fi
}

# Function to check WordPress post titles
check_wordpress_posts() {
    posts=$(curl -s "$1" | grep -Eo '<h[1-6][^>]*><a [^>]*title="[^"]*"' | sed -E 's/<[^>]*>//g')
    if [ -z "$posts" ]; then
        echo "WordPress Posts Titles: Not found"
    else
        echo "WordPress Posts Titles:"
        echo "$posts"
    fi
}

# Function to check Image Alt attributes
check_image_alt() {
    image_alt=$(curl -s "$1" | grep -o '<img [^>]*alt="[^"]*"[^>]*>' | sed -e 's/<img [^>]*alt="//' -e 's/"[^>]*>//')
    if [ -z "$image_alt" ]; then
        echo "Image Alt Attributes: Not found"
    else
        echo "Image Alt Attributes: $image_alt"
    fi
}

# Function to check the HTTP status code of a website
check_http_status() {
    http_status=$(curl -s -o /dev/null -w "%{http_code}" "$1")
    echo "HTTP Status Code: $http_status"
}

# Main function to run checks
main() {
    if [ $# -eq 0 ]; then
        read -p "Enter the website URL: " website_url
    else
        website_url=$1
    fi

    echo "Checking SEO for: $website_url"
    check_title "$website_url"
    check_meta_description "$website_url"
    check_wordpress_version "$website_url"
    check_wordpress_posts "$website_url"
    check_image_alt "$website_url"
    check_http_status "$website_url"
}

# Call main function
main "$@"
