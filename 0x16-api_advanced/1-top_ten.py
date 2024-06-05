#!/usr/bin/python3
"""Prints the titles of the first 10 hot posts listed for a given subreddit."""

import requests


import requests

def top_ten(subreddit):
    url = f"https://www.reddit.com/r/{subreddit}/hot.json?limit=10"
    headers = {'User-Agent': 'Mozilla/5.0'}
    response = requests.get(url, headers=headers, allow_redirects=False)

    if response.status_code == 200:
        data = response.json()
        posts = data['data']['children']
        if not posts:
            print("No posts found for this subreddit.")
        else:
            for post in posts:
                print(post['data']['title'])
    else:
        print("None")
