############################
### Setting up workspace ###
############################

library(rvest)
library(jsonlite)
library(data.table)

####################################
### Creating scraping functions ###
###################################

get_image_links <- function(url) {
  image_links <- url %>% 
    read_html() %>%
    html_nodes('[class="col-sm-3"]') %>%
    html_nodes("img") %>%
    html_attr("src") %>%
    grep("https://www.thecocktaildb.com/images/media/drink/", ., value = T)
  return(image_links)
}

get_drink_ids <- function(url) {
  drink_ids <- url %>% 
    read_html() %>%
    html_nodes('[class="col-sm-3"]') %>%
    html_nodes("a") %>% 
    html_attr("href") %>%
    grep("^drink", .,value = T) %>%
    sub(".*=([0-9]+)-.*", "\\1", .)
  return(drink_ids)
}

get_drink_json <- function(url) {
  line <- readLines(url)
  drink_json <- fromJSON(line)
  return(drink_json)
}

nested_json_to_dataframe <- function(nested_list) {
  list_of_drinks <- unlist(unlist(nested_list, recursive = F), recursive = F)
  drinks_dataframe <- data.table::rbindlist(list_of_drinks, fill= TRUE)
  return(drinks_dataframe)
}

scrape_database <- function(sites_base_url, drink_base_url, pause=1) {
  jsons <- list()
  for (letter in letters) {
    print(paste0("Started scraping: ", letter))
    url <- paste0(sites_base_url, letter)
    drink_ids <- get_drink_ids(url)
    jsons[[letter]] <- list()
    if (length(drink_ids)==0) {
      next
    }
    for (i in 1:length(drink_ids)) {
      print(paste0("Scraping drink ", i, " of ", length(drink_ids)))
      drink_url <- paste0(drink_base_url, drink_ids[i])
      drink_json <- get_drink_json(drink_url)
      jsons[[letter]][[i]] <- drink_json
      Sys.sleep(pause)
    }
  }
  drinks_dataframe <- nested_json_to_dataframe(jsons)
  return(drinks_dataframe)
}

download_images <- function(list_of_links) {
  
}
#########################
### Scraping database ###
#########################

# Base urls
sites_base_url = "https://www.thecocktaildb.com/browse.php?b="
drink_base_url = "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i="

# Scraping all drinks
drinks_df <- scrape_database(sites_base_url, drink_base_url, pause = 1)
























