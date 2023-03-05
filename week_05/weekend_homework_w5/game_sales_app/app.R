# libraries 

library(shiny)
library(tidyverse)
library(ggplot2)
library(bslib)

# load data 

game_sales <- CodeClanData::game_sales

# create a list of years 

year_list <- game_sales %>% 
distinct(year_of_release) %>% 
  pull()

# create a list of genres 
genre_list <- game_sales %>% 
  distinct(genre) %>% 
  pull()

# Define UI for application 
ui <- fluidPage(
  theme = bs_theme(bootswatch = "sketchy"),

    # Application title
    titlePanel(h1(tags$b("Best Rated Games by Critics in Given Year"))),
  
  HTML("<br><br><br>"),
  
  HTML("<h3>Pick a year and your favourite genre, to see what game the critics recommend!<h3>"),
  
  HTML("<br><br><br>"),
  
    # Select boxes for year and genre 
    sidebarLayout(
        sidebarPanel(
          selectInput("year", label = h3("Select Year"), 
                      choices = year_list),
          
        selectInput("genre", label = h3("Select Genre"), 
                    choices = genre_list)
        ),

        # the plot  
        mainPanel(
           plotOutput("games_plot")
        )
    )
)


# Define server logic required to draw the plot. The plot shows how highly rated each game were by critics
# in a particular year and for a particular genre. 

server <- function(input, output) {

    output$games_plot <- renderPlot({
      game_sales %>% 
        filter(year_of_release == input$year, genre == input$genre) %>% 
        mutate(name = as.factor(name)) %>% 
        drop_na() %>% 
        ggplot()+
        geom_col(aes(x = reorder(name,critic_score), y = critic_score, fill = "orange3")) +
        scale_fill_manual(values = "orange3")+
        coord_flip()+
        theme_classic()+
        labs(y = "Critic Score", x = "Game")+
        guides(fill = FALSE)
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
