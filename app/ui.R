library(shiny)



shiny::fluidPage(
  h2("this is a drinks app"),
  selectizeInput("i_ingredients",choices=ingredients,multiple=TRUE,label="ingredients"),
  actionButton("i_go_find_drinks","find me some drinks"),
  uiOutput("ui_suggestion"),
  
  fluidRow(
    column(width = 2,
      checkboxGroupInput("i_frugt",choices=ingredients,label="frugt")
    ),
    column(width = 2,
           checkboxGroupInput("i_alkohol",choices=ingredients,label="base alkohol")
    ),
    column(width = 2,
           checkboxGroupInput("i_liqueur",choices=ingredients,label="likør")
    ),
    actionButton("i_go_find_drinks","find me some drinks")
  )
  
  
)