library(shiny)
# other libraries here
library(tidyverse)
# data loading and one-time processing here

load("data_from_SNP_lab.Rdata")
pheno.geno.pca.pop <- left_join(geno.pca.pop, data.pheno, by=c("ID" = "ID"))

#get rid of spaces in the phenotype names with "make.names()"
colnames(pheno.geno.pca.pop) <- make.names(colnames(pheno.geno.pca.pop))

head(pheno.geno.pca.pop)
# Define UI for application 
ui <- fluidPage( #create the overall page
    #UI code here
  )


# Define server logic 
server <- function(input, output) {
  # server code here
}

# Run the application 
shinyApp(ui = ui, server = server)
