#load libraries
library(shiny)
library(tidyverse)

#data loading and one-time processing here
load("../data_from_SNP_lab.Rdata")
pheno.geno.pca.pop <- left_join(geno.pca.pop, data.pheno, by=c("ID" = "ID"))

#get rid of spaces in the phenotype names with "make.names()"
colnames(pheno.geno.pca.pop) <- make.names(colnames(pheno.geno.pca.pop))


#UI: fluid page
ui <- fluidPage(

  #application title
  titlePanel(),
  
  #description of Shiny app
  helpText("This application creates a Principle Component Analysis (PCA) plot ",
           "to show differences between different PCs and different labeling.  ",
           "Please use the boxes below to choose a PC for each axis, and the label",
           "for plotting."),
  
  #input: sidebar with 2 drop downs (PCs) and 1 radio box (Region or assignedPop)
  pageWithSidebar(
    headerPanel('Iris k-means clustering'),
    sidebarPanel(
      selectInput('xcol', 'X Variable', c("PC1", "PC2", "PC3", "PC4", "PC5")),
      selectInput('ycol', 'Y Variable', c("PC1", "PC2", "PC3", "PC4", "PC5"),
      radioButtons('label',
                   'Choose to color by region or admixture assigned population:',
                   c("Region", "assignedPop"))
    ),
    
    #output: plot based on user input
    mainPanel(
      plotOutput("boxPlot")
    )
  ))
)


#server: change input into output
server <- function(input, output) {
  
  # server code here
  
}


#run Shiny app
shinyApp(ui = ui, server = server)