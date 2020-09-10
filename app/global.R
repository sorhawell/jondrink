library(magrittr)


put_penis_in <- function(df)(
  return("good times")
)

drinks_df = readRDS("../data/drinks_df.rds")
ingredients  = drinks_df[,paste0("strIngredient",1:15)] %>% unlist %>% unique %>% sort %>% summarize(ass = 1)



print_wuhu= function(f) {
  function(...) {
    print("wuhu")
    out  = f(...)
    return(out)
  }
}


mean_wuhu = print_wuhu(mean)
mean_wuhu(1:10)
