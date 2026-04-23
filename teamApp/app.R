library(shiny)
# other libraries here
library(tidyverse)


# data loading and one-time processing here
load("../data_from_SNP_lab.Rdata")
pheno.geno.pca.pop <- left_join(geno.pca.pop, data.pheno, by=c("ID" = "ID"))

#get rid of spaces in the phenotype names with "make.names()"
colnames(pheno.geno.pca.pop) <- make.names(colnames(pheno.geno.pca.pop))


# Define UI for application 
ui <- fluidPage( #create the overall page
    #UI code here
  #application titles
  titlePanel(),
  #descriptions
  helpText("This application creates a Principle Component Analysis (PCA) plot ",
           "to show differences between different PCs and different labeling.  ",
           "Please use the boxes below to choose a PC for each axis, and the label",
           "for plotting."),
  # Sidebar with a radio box to input which species will be plotted
  pageWithSidebar(
    headerPanel('Iris k-means clustering'),
    sidebarPanel(
      selectInput('xcol', 'X Variable', c("PC1", "PC2", "PC3", "PC4", "PC5")),
      selectInput('ycol', 'Y Variable', c("PC1", "PC2", "PC3", "PC4", "PC5"),
      radioButtons('label',
                   'Choose to color by region or admixture assigned population:',
                   c("Region", "assignedPop"))
    ),
    
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("boxPlot")
    )
  ))
)

  





# Define server logic 
server <- function(input, output) {
  # server code here
}

# Run the application 
shinyApp(ui = ui, server = server)
