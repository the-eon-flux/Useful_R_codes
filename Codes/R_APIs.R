# Reading from APIs

'
Twitter Dev URL : https://developer.twitter.com/en
API_Key : knJUBKGZfkh8ZMoQkV5svcdpm

API_Secret_Key : YwJaUli1Ppre4IcIko0UOdM2m3ZXxmkSmJSCBg5rRCG20K7ksm

Bearer Token : AAAAAAAAAAAAAAAAAAAAAMZOHAEAAAAAe5XppHgp2%2FoG3k9ckc75tVHzZM0%3DOaphVYdIXkzBwcFhC8j9oaX1NznxQz8gtgy5xOd96N3sNjbyu5

Access Token : 2889468079-KzIiFjPdrkMc2XnxSymfYJTUkkbZbmGkmH6z4vY

Access Secret Token : tHJUqO4LgguxSjPVPbUnBEAUO5t6O29viIQa7GKTXuNuR

'

library(httr)

myApp = oauth_app("twitter", key = "knJUBKGZfkh8ZMoQkV5svcdpm", secret = "YwJaUli1Ppre4IcIko0UOdM2m3ZXxmkSmJSCBg5rRCG20K7ksm")
sig = sign_oauth1.0(myApp, token = "2889468079-KzIiFjPdrkMc2XnxSymfYJTUkkbZbmGkmH6z4vY",
                      token_secret = "tHJUqO4LgguxSjPVPbUnBEAUO5t6O29viIQa7GKTXuNuR")

# Following API is for getting TL of home user
homeTL = GET("https://api.twitter.com/1.1/statuses/home_timeline.json", sig)
json1 = content(homeTL)


# Following API is for getting TL of specific user
TejusTL = GET("https://api.twitter.com/1.1/statuses/user_timeline.json", user_id = "ShindeTejus", sig)
TejusTL_Content = content(TejusTL) # Returns a complex structure

# Alternative
TejusTL_Content2 = fromJSON(toJSON(TejusTL_Content))


## Github APIs
#
API = "https://api.github.com/users/jtleek/repos"


# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. To make your own application, register at
#    https://github.com/settings/developers. Use any URL for the homepage URL
#    (http://github.com is fine) and  http://localhost:1410 as the callback url
#
#    Replace your key and secret below.

Token = "817ed8d4b0ee0ab1fdbe"
Token_Secret = "c056b54c88eb8f38a161b3ee370253a6901647fe"

myApp <- oauth_app("github", key = Token, secret = Token_Secret)

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myApp)

# 4. Use API
gtoken <- config(token = github_token)
jtLeek_TL <- GET(API, gtoken)


stop_for_status(req)
content(req)
