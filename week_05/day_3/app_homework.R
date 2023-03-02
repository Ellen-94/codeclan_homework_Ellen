library(shiny)
library(tidyverse)
library(bslib)

beer <- CodeClanData::beer

 
# create vectors of the different beer types I like


ale_list <- c("Big Sky Moose Drool Brown Ale", 
              "Big Sky Scape Goat Pale Ale", 
              "Big Sky Summer Honey Ale (seasonal)", 
              "Big Sky Scape Goat Pale Ale", 
              "Big Sky Trout Slayer Ale", 
              "Breckenridge Brown Ale", 
              "Breckenridge Red Ale", 
              "Deschutes Twilight Summer Ale",  
              "Flying Dog Tire Bite Golden Ale" , 
              "Sam Adams Boston Ale", 
              "Sierra Nevada Anniversary Ale", 
              "Sierra Nevada Celebration Ale" ,  
              "Sierra Nevada Harvest Ale" , 
              "Sierra Nevada Pale Ale",  
              "Weinhard's Pale Ale",  
              "Yuengling Ale" )

ipa_list <- c("Deschutes Chainbreaker White IPA", 
              "Deschutes Pinedrops IPA" , 
              "Flying Dog Snake Dog IPA",  
              "Summit Horizon Red IPA" , 
              "Sierra Nevada India Pale Ale")

# create new column with type and change calories to numeric 

my_beer_types <- beer %>% 
  mutate(beer_type = case_when(brand %in% ale_list ~ "ale", brand %in% ipa_list ~ "ipa")) %>% 
  mutate(calories = as.numeric(calories))

# create app  


ui <- fluidPage(
  titlePanel(tags$h2(tags$b("Pick a Healthy Beer"))),
  theme = bs_theme(bootswatch = "cyborg"),
  sidebarPanel(
    radioButtons(
      inputId = "beer_input",
      label = tags$i("What type of beer are you in the mood for?"), 
      choices = c("ipa", "ale")
    ),
    radioButtons(
      inputId = "health_input",
      label = tags$i("What health metric are you intrested in?"), 
      choices = c("calories", "carbohydrates")
    ), 
  ),
  mainPanel(
    plotOutput("beer_plot")
  )
)

server <- function(input, output, session) {
  output$beer_plot <- renderPlot(expr = {
    my_beer_types %>% 
      filter(beer_type == input$beer_input) %>% 
      ggplot() +
      geom_col(aes(x=reorder(brand,!!sym(input$health_input)), y = !!sym(input$health_input))) +
      coord_flip()+
      theme_classic()+
      labs(x = "Beer")
    
  }
  )
}


shinyApp(ui, server)
