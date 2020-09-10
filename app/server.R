library(shiny)


function(input,output,session) {
  
  observeEvent(input$i_go_find_drinks,{
    
    print(input$i_frugt)
    
    
    
  })
  
  observeEvent(input$i_go_find_drinks,{
    output$ui_suggestion = renderUI({
      tagList(
        h2("drink suggestion"),
        h6(
          paste0(
            "you should make a drink with:",
            paste(sample(input$i_ingredients),collapse = ", ")
          )
        )
      )
    })
  })
  
}