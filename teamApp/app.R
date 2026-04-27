#load libraries
library(ggplot2)
library(shiny)
library(tidyverse)

#data loading and one-time processing here
load("data/data_from_SNP_lab.Rdata")
pheno.geno.pca.pop <- left_join(geno.pca.pop, data.pheno, by=c("ID" = "ID"))

#get rid of spaces in the phenotype names with "make.names()"
colnames(pheno.geno.pca.pop) <- make.names(colnames(pheno.geno.pca.pop))


#UI: fluid page
ui <- fluidPage(

  #application title
  titlePanel("App"),
  
  #description of Shiny app
  helpText("This application creates a Principle Component Analysis (PCA) plot ",
           "to show differences between different PCs and different labeling.  ",
           "Please use the boxes below to choose a PC for each axis, and the label",
           "for plotting."),
  
  #input: sidebar with 2 drop downs (PCs) and 1 radio box (Region or assignedPop)
  pageWithSidebar(
    headerPanel(""),
    sidebarPanel(
      selectInput('xcol', 'X Variable:', c("PC1", "PC2", "PC3", "PC4", "PC5")),
      selectInput('ycol', 'Y Variable:', c("PC1", "PC2", "PC3", "PC4", "PC5")),
      radioButtons('label',
                   'Choose to color by region or admixture assigned population:',
                   c("Region", "assignedPop"))
    ),
    
    #output: plot based on user input
    mainPanel(
      plotOutput("scatterPlot")
    )
  )
)


#server: convert input to output
server <- function(input, output) {
  
  #output: create scatterPlot object
  output$scatterPlot <- renderPlot({
  
    #convert input to name objects for plotting
    X <- as.name(input$xcol)
    Y <- as.name(input$ycol)
    colorBy <- as.name(input$label)
    
    #save plot in object based on input
    plt <- ggplot(data = pheno.geno.pca.pop %>%
                    #remove NAs based on color input
                    filter(!! colorBy != "NA"),
                 aes(x = !! X,
                     y = !! Y,
                     color = !! colorBy
                 )
    )
    
    #save plot labels in object based on input
    if(colorBy == "assignedPop"){
      plotLabels <- labs(x = X, y = Y, color = "Assigned Population")
    }else{
      plotLabels <- labs(x = X, y = Y, color = "Region")
    }
  
    #display plot
    plt + geom_point() + plotLabels
    
  })

}


#run Shiny app
shinyApp(ui = ui, server = server)