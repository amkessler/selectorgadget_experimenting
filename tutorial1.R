#here we'll walk through Hadley's vignette code:
# https://cran.r-project.org/web/packages/rvest/vignettes/selectorgadget.html


# IMDB page for the Lego Movie
# http://www.imdb.com/title/tt1490017/
#   
# Once we’ve determined the css selector, we can use it in R to extract the values we want:
#   

library(rvest)

lego_url <- "http://www.imdb.com/title/tt1490017/"

html <- read_html(lego_url)

cast <- html_nodes(html, ".primary_photo+ td a")

#we now should have actor names and links
length(cast)
cast[1:2]

# Extract just the text from the selected HTML nodes.
html_text(cast, trim = TRUE)

# Let’s say we’re also interested in extracting the links to the actors’ pages. 
# We can access html attributes of the selected nodes using html_attrs().
cast_attrs <- html_attrs(cast)

length(cast_attrs)
cast_attrs[1:2]


# As we can see there’s only one attribute called href which contains relative url to the actor’s page. 
# We can extract it using html_attr(), indicating the name of the attribute of interest. 
# Relative urls can be turned to absolute urls using url_absolute().
cast_rel_urls <- html_attr(cast, "href")

length(cast_rel_urls)

cast_rel_urls[1:2]

cast_abs_urls <- html_attr(cast, "href") %>% 
  url_absolute(lego_url)

cast_abs_urls[1:2]
