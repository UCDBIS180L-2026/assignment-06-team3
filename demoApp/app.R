library(shiny)
library(tidyverse)

data(iris)

iris_long <- iris %>%
  pivot_longer(-Species, #exclude this one
               names_to = "Trait",
               values_to = "Size.cm")

vars <- setdiff(names(iris), "Species")

# Define UI for application that draws a box plot
ui <- fluidPage( #create the overall page
  
  # Application title
  titlePanel("Iris Data"),
  
  # Some helpful information
  helpText("This application creates a violin plot to show differences between",
           "traits in the same iris species.  Please use the radio box below to choose a species",
           "for plotting"),
  
  # Sidebar with a radio box to input which species will be plotted
  sidebarLayout(
    sidebarPanel(
      radioButtons("species", #the input variable that the value will go into
                   "Choose a trait to display:",
                   c("setosa",
                     "versicolor",
                     "virginica")
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
    
    plotSpecies <- as.name(input$species) # convert string to name
    
    # set up the plot
    pl <- ggplot(data = iris_long %>%
                   filter(Species == plotSpecies) %>%
                   select(Species, Trait, Size.cm),
                 aes(x=Trait,
                     y= Size.cm,
                     fill=Trait
                 )
    )
    
    # draw the violin for the specified trait
    pl + geom_violin()
  })
}

# Run the application 
shinyApp(ui = ui, server = server)




