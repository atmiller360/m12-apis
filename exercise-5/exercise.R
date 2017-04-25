### Exercise 5 ###
library(jsonlite)
library(dplyr)
library(httr)

# Write a function that allows you to specify a movie, that does the following:
GetReview <- function(movie) {
  
  # Construct a search query using YOUR api key
  # The base URL is https://api.nytimes.com/svc/movies/v2/reviews/search.json?
  # Your parameters should include a "query" and an "api_key"
  # Note: the HTTR library will take care of spaces in the arguments
  # See the interactive console for more detail:https://developer.nytimes.com/movie_reviews_v2.json#/Console/GET/reviews/search.json
  base <- "https://api.nytimes.com/svc/movies/v2/reviews/search.json?"
  query.params <- list("query" = movie, "api_key" = "82c1c76ad0ab4dc0bb131a16558dad8a")
  
  # Request data using your search query
  response <- GET(base, query = query.params)
  body <- content(response, "text")
  body.data <- fromJSON(body)
  
  # What type of variable does this return?
  
  
  # Flatten the data stored in the `$results` key of the data returned to you
  flattened <- flatten(body.data$results)
  
  # From the most recent review, store the headline, short summary, and link to full article each in their own variables
  most.recent <- flattened %>%
    filter(date_updated == max(date_updated))
  headline <- most.recent$headline
  summary <- most.recent$summary_short
  link <- most.recent$link.url

  # Return an list of the three pieces of information from above
  list(headline = headline, summary <- summary, link = link) %>% return()
}

# Test that your function works with a movie of your choice
hunger.games.review <- GetReview("The Hunger Games")
