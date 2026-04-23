#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
library(tidyverse)

data(iris)

# Define UI for application that draws a box plot
ui <- fluidPage( #create the overall page
    
    # Application title
    titlePanel("Iris Data"),
    
    # Some helpful information
    helpText("This application creates a boxplot to show difference between",
             "iris species.  Please use the radio box below to choose a trait",
             "for plotting"),
    
    # Sidebar with a radio box to input which trait will be plotted
    sidebarLayout(
      sidebarPanel(
        radioButtons("trait", #the input variable that the value will go into
                     "Choose a trait to display:",
                     c("Sepal.Length",
                       "Sepal.Width",
                       "Petal.Length",
                       "Petal.Width")
        )),
      
      # Show a plot of the generated distribution
      mainPanel(
        plotOutput("boxPlot")
      )
    )
  )


# Define server logic required to draw a box. plot
server <- function(input, output) {
  
  # Expression that generates a boxplot. The expression is
  # wrapped in a call to renderPlot to indicate that:
  #
  #  1) It is "reactive" and therefore should re-execute automatically
  #     when inputs change
  #  2) Its output type is a plot
  
  output$boxPlot <- renderPlot({
    
    plotTrait <- as.name(input$trait) # convert string to name
    
    # set up the plot
    pl <- ggplot(data = iris,
                 aes(x=Species,
                     y= !! plotTrait, # !! to use the column names contained in plotTrait
                     fill=Species
                 )
    )
    
    # draw the violin for the specified trait
    pl + geom_violin()
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
