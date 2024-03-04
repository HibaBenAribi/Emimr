library(shiny)
library(shinythemes)
library(shinycssloaders)
library(shinyWidgets)
library(shinydashboard) 
library(shinyFiles)
library(DT) 
library(dplyr)
library(ggplot2) 
library(clusterProfiler)
library(enrichplot)

species_list <- c(
  "Homo sapiens",
  "Mus musculus",
  "Arabidopsis thaliana",
  "Drosophila melanogaster",
  "Danio rerio",
  "Rattus norvegicus",
  "Saccharomyces cerevisiae",
  "Caenorhabditis elegans"
)

ui <- fluidPage(
  theme = shinytheme("flatly"),
  titlePanel("EMIMR: Transcriptomic and Epigenomic Changes Identification"),
  sidebarLayout(
    sidebarPanel(
      # Checkbox for data selection
      h3("Select Data Type"),
      checkboxGroupInput("data_selection", "Select Data to Analyze:", 
                         choices = c("Methylation" = "methylation", "MicroRNA" = "microRNA")),
      
      # Species selection
      h3("Select Species"),
      selectInput("species", "Species", choices = species_list),
      # Section to import files
      fileInput("Expression_data", "Import Expression data CSV File"),
      

      # Methylation file input (visible only if Methylation checkbox is selected)
      conditionalPanel(
        condition = "input.data_selection.includes('methylation')",
        fileInput("Methylation_data", "Import Methylation data CSV File")
      ),
      
      # MicroRNA file input (visible only if MicroRNA checkbox is selected)
      conditionalPanel(
        condition = "input.data_selection.includes('microRNA')",
        fileInput("MicroRNA_data", "Import MicroRNA data CSV File")
      ),
      
      # Section with six inputs
      h3("DEGs filtering parameters"),
      sliderInput("pval",
                  "p-value:",
                  min = 0,
                  max = 1,
                  value=0.05
      ),
      sliderInput("log",
                  "log2FoldChange value:",
                  min = 0,
                  max = 2,
                  value=0.5
      ),
      # Methylation parameters (visible only if Methylation checkbox is selected)
      conditionalPanel(
        condition = "input.data_selection.includes('methylation')",
        h4("DMGs filtering parameters"),
        sliderInput("mpval",
                    "p-value:",
                    min = 0,
                    max = 1,
                    value=0.05
        ),
        sliderInput("mlog",
                    "log2FoldChange value:",
                    min = 0,
                    max = 2,
                    value=0.5
        ),
      ),
      
      # MicroRNA parameters (visible only if MicroRNA checkbox is selected)
      conditionalPanel(
        condition = "input.data_selection.includes('microRNA')",
        h4("DEImRs filtering parameters"),
        sliderInput("micpval",
                    "p-value:",
                    min = 0,
                    max = 1,
                    value=0.05
        ),
        sliderInput("miclog",
                    "log2FoldChange value:",
                    min = 0,
                    max = 5,
                    value=2
        ),
      ),
      
      # Submit button
      actionButton("submit_button", "Submit")
    ),

    mainPanel(
      conditionalPanel(
        condition = "!(input.submit_button > 0)",
        h2("Import files and define parametres"),
      ),
      conditionalPanel(
        condition = "input.submit_button > 0 ",
        
      tabsetPanel(
        tabPanel("DEGs", width = 6,
                 conditionalPanel(
                   condition = "input.submit_button > 0",
                   h2("DEGs"),
                   h3("Volcano Plot"),
                   shinycssloaders::withSpinner(plotOutput("volcano_plot", height = 300, width = 1000))
                 ),
        ),

        tabPanel("intersection DEGs and DMGs",
                 conditionalPanel(
                   condition = "input.submit_button > 0 && input.data_selection.includes('methylation')",
                   # upreg hypo
                   h3("Up-Regulated and Hypo-Methylated Genes"),
                   shinycssloaders::withSpinner(DTOutput('inter_upexp_met')),
                   h3("Ontology analysis"),
                   textInput("show1", label=  span(shiny::tags$i(h6("Top Ontologies")), style="color:#045a8d")
                             ,value = "10"), br(),
                   pickerInput("plottype1", label= span(shiny::tags$i(h6("Define the Plot type")), style="color:#045a8d"),
                               choices = c("Dotplot","Barplot",  "Cnetplot" ), multiple = FALSE), br(),
                   pickerInput("GOtype1", label= span(shiny::tags$i(h6("Define the Ontology category")), style="color:#045a8d"),
                               choices = c("Biological Processes","Cellular Compenant",  "Molecular Function" ),
                               multiple = FALSE),
                   shinycssloaders::withSpinner(plotOutput("ontology_plot_upexp_met")),
                   
                   # downreg hyper
                   h3("Down-Regulated and Hyper-Methylated Genes"),
                   shinycssloaders::withSpinner(DTOutput('inter_downexp_met')),
                   # affected ontologies 
                  h3("Ontology analysis"),
                  textInput("show2", label=  span(shiny::tags$i(h6("Top Ontologies")), style="color:#045a8d")
                                      ,value = "10"), br(),
                  pickerInput("plottype2", label= span(shiny::tags$i(h6("Define the Plot type")), style="color:#045a8d"),
                                   choices = c("Dotplot","Barplot",  "Cnetplot" ), multiple = FALSE), br(),
                  pickerInput("GOtype2", label= span(shiny::tags$i(h6("Define the Ontology category")), style="color:#045a8d"),
                                       choices = c("Biological Processes","Cellular Compenant",  "Molecular Function" ),
                                        multiple = FALSE),
                  shinycssloaders::withSpinner(plotOutput("ontology_plot_downexp_met"))
                 )),

        tabPanel("intersection DEGs and DEImR",
                 conditionalPanel(
                  condition = "input.submit_button > 0 && input.data_selection.includes('microRNA')"
                  h3("Up-Regulated Genes 'associated with' Down-Regulated MicroRNAs"),
                  shinycssloaders::withSpinner(DTOutput('inter_upexp_mic')),
                  h3("Ontology analysis"),
                  textInput("show3", label=  span(shiny::tags$i(h6("Top Ontologies")), style="color:#045a8d")
                            ,value = "10"), br(),
                  pickerInput("plottype3", label= span(shiny::tags$i(h6("Define the Plot type")), style="color:#045a8d"),
                              
                              choices = c("Dotplot","Barplot",  "Cnetplot" ), multiple = FALSE), br(),
                  pickerInput("GOtype3", label= span(shiny::tags$i(h6("Define the Ontology category")), style="color:#045a8d"),
                              choices = c("Biological Processes","Cellular Compenant",  "Molecular Function" ),
                              multiple = FALSE),
                  shinycssloaders::withSpinner(plotOutput("ontology_plot_upexp_mic")),
                  
                  # downreg hyper
                  h3("Down-Regulated Genes 'associated with' Up-Regulated MicroRNAs"),
                  shinycssloaders::withSpinner(DTOutput('inter_downexp_mic')),
                  # affected ontologies 
                  h3("Ontology analysis"),
                  textInput("show4", label=  span(shiny::tags$i(h6("Top Ontologies")), style="color:#045a8d")
                            ,value = "10"), br(),
                  pickerInput("plottype4", label= span(shiny::tags$i(h6("Define the Plot type")), style="color:#045a8d"),
                              choices = c("Dotplot","Barplot",  "Cnetplot" ), multiple = FALSE), br(),
                  pickerInput("GOtype4", label= span(shiny::tags$i(h6("Define the Ontology category")), style="color:#045a8d"),
                              choices = c("Biological Processes","Cellular Compenant",  "Molecular Function" ),
                              multiple = FALSE),
                  shinycssloaders::withSpinner(plotOutput("ontology_plot_downexp_mic"))
                 ),
        
        )))
    )
  )
)

# Define server logic
server <- function(input, output) {
  observeEvent(input$submit_button, {
    # volcano plot
    output$volcano_plot <- renderPlot({
      req(input$Expression_data)
      expression  <- read.csv(input$Expression_data$datapath)
      expression$diffexpressed <- "Not Significant"
      #define degs
     expression$diffexpressed[expression$log2FoldChange  > as.numeric(input$log ) & expression$pvalue < as.numeric(input$pval) ] <- "Upregulated genes"
     expression$diffexpressed[expression$log2FoldChange  < -(as.numeric(input$log ))  & expression$pvalue < as.numeric(input$pval) ] <- "Downregulated genes"
      #plot
      ggplot(data=expression, aes(x=log2FoldChange, y=-log10(pvalue), col=diffexpressed)) +
        geom_point() + theme_minimal() + theme(text = element_text(size = 15))  
      
    })
    # Intersection exp met  
      inter_upexp_met_data <- reactive({
        req(input$Expression_data)
        req(input$Methylation_data)
        
        expdata <- read.csv(input$Expression_data$datapath)
        upregulated <- expdata %>%
          filter(pvalue < as.numeric(input$pval), log2FoldChange > as.numeric(input$log)) # upregulated
        
        colnames(upregulated)[colnames(upregulated) == "pvalue"] <- "expression_pvalue"
        colnames(upregulated)[colnames(upregulated) == "log2FoldChange"] <- "expression_log2FoldChange"
        
        metdata <- read.csv(input$Methylation_data$datapath)
        hypomethylated <- metdata %>%
          filter(pvalue < as.numeric(input$mpval), log2FoldChange < as.numeric(-input$mlog)) # hypomethylated
        
        colnames(hypomethylated)[colnames(hypomethylated) == "pvalue"] <- "methylation_pvalue"
        colnames(hypomethylated)[colnames(hypomethylated) == "log2FoldChange"] <- "methylation_log2FoldChange"
        
        upexp_met <- merge(upregulated, hypomethylated, by.x = "gene", by.y = "gene")
        upexp_met <-unique(upexp_met)
       
      })
    output$inter_upexp_met <- renderDT({
      inter_upexp_met_data <- inter_upexp_met_data()
      datatable(inter_upexp_met_data())
    })
    

    ### OA
    output$ontology_plot_upexp_met<- renderPlot({
      # Get data from the reactive expression
      inter_upexp_met <- inter_upexp_met_data()
      exp_met <- inter_upexp_met 
      # filter genes m e
      group_gene  <- unique(c(exp_met$gene))
      
      #ontology type
      if (input$GOtype1 == "Biological Processes"){
        GO_type1 <- "BP"
      }else if (input$GOtype1 == "Cellular Compenant"){
        GO_type1 <- "CC"
      }else if (input$GOtype1 == "Molecular Function"){ 
        GO_type1 <- "MF"
      }
      #specie
      if (input$species == "Homo sapiens") {
        library(org.Hs.eg.db)
        specie1 <- "org.Hs.eg.db"
      } else if (input$species == "Mus musculus") {
        library(org.Mm.eg.db)
        specie1 <- "org.Mm.eg.db"
      } else if (input$species == "Arabidopsis thaliana") {
        library(org.At.tair.db)
        specie1 <- "org.At.tair.db"
      } else if (input$species == "Drosophila melanogaster") {
        library(org.Dm.eg.db)
        specie1 <- "org.Dm.eg.db"
      } else if (input$species == "Danio rerio") {
        library(org.Dr.eg.db)
        specie1 <- "org.Dr.eg.db"
      } else if (input$species == "Rattus norvegicus") {
        library(org.Rn.eg.db)
        specie1 <- "org.Rn.eg.db"
      } else if (input$species == "Saccharomyces cerevisiae") {
        library(org.Sc.sgd.db)
        specie1 <- "org.Sc.sgd.db"
      } else if (input$species == "Caenorhabditis elegans") {
        library(org.Ce.eg.db)
        specie1 <- "org.Ce.eg.db"
      } else {
        # Handle the case when no species is selected or handle an unknown species
        specie1 <- NULL
      }
      # analysis
      ontology <- enrichGO(gene = group_gene, OrgDb=specie1, keyType="SYMBOL", ont=GO_type1)
      s_ontology <- simplify(ontology)
      #plot
      if (input$plottype1 == "Dotplot"){
        dotplot(ontology, showCategory=as.numeric(input$show1))
      }else if (input$plottype1 == "Barplot"){
        barplot(ontology, showCategory=as.numeric(input$show1))
      }else{
        cnetplot(s_ontology, foldChange=group_gene, circular = TRUE, colorEdge = TRUE)
      }
      #barplot(ontology, showCategory=10)
    })
    
    inter_downexp_met <- reactive({
      req(input$Expression_data)
      req(input$Methylation_data)
      
      expdata <- read.csv(input$Expression_data$datapath)
      downregulated <- expdata %>%
        filter(pvalue < as.numeric(input$pval), log2FoldChange < as.numeric(-input$log)) # downregulated
      
      colnames(downregulated)[colnames(downregulated) == "pvalue"] <- "expression_pvalue"
      colnames(downregulated)[colnames(downregulated) == "log2FoldChange"] <- "expression_log2FoldChange"

      metdata <- read.csv(input$Methylation_data$datapath)
      hypermethylated <- metdata %>%
        filter(pvalue < as.numeric(input$mpval), log2FoldChange > as.numeric(input$mlog)) # hypermethylated
      
      colnames(hypermethylated)[colnames(hypermethylated) == "pvalue"] <- "methylation_pvalue"
      colnames(hypermethylated)[colnames(hypermethylated) == "log2FoldChange"] <- "methylation_log2FoldChange"
      
      
      downexp_met <- merge(downregulated, hypermethylated, by.x = "gene", by.y = "gene")
      downexp_met <- unique(downexp_met)
      
    })
    output$inter_downexp_met <- renderDT({
      inter_downexp_met_data <- inter_downexp_met()
      datatable(inter_downexp_met())
    })

    ### OA
    output$ontology_plot_downexp_met<- renderPlot({
      exp_met <- inter_downexp_met()

      # filter genes m e
      group_gene  <- unique(c(exp_met$gene))
      
      #ontology type
      if (input$GOtype2 == "Biological Processes"){
        GO_type2 <- "BP"
      }else if (input$GOtype2 == "Cellular Compenant"){
        GO_type2 <- "CC"
      }else{
        GO_type2 <- "MF"
      }
      #specie
      if (input$species == "Homo sapiens") {
        library(org.Hs.eg.db)
        specie1 <- "org.Hs.eg.db"
      } else if (input$species == "Mus musculus") {
        library(org.Mm.eg.db)
        specie1 <- "org.Mm.eg.db"
      } else if (input$species == "Arabidopsis thaliana") {
        library(org.At.tair.db)
        specie1 <- "org.At.tair.db"
      } else if (input$species == "Drosophila melanogaster") {
        library(org.Dm.eg.db)
        specie1 <- "org.Dm.eg.db"
      } else if (input$species == "Danio rerio") {
        library(org.Dr.eg.db)
        specie1 <- "org.Dr.eg.db"
      } else if (input$species == "Rattus norvegicus") {
        library(org.Rn.eg.db)
        specie1 <- "org.Rn.eg.db"
      } else if (input$species == "Saccharomyces cerevisiae") {
        library(org.Sc.sgd.db)
        specie1 <- "org.Sc.sgd.db"
      } else if (input$species == "Caenorhabditis elegans") {
        library(org.Ce.eg.db)
        specie1 <- "org.Ce.eg.db"
      } else {
        # Handle the case when no species is selected or handle an unknown species
        specie1 <- NULL
      }
      # analysis
      ontology <- enrichGO(gene = group_gene, OrgDb=specie1, keyType="SYMBOL", ont=GO_type2)
      s_ontology <- simplify(ontology)
      #plot
      if (input$plottype2 == "Dotplot"){
        dotplot(ontology, showCategory=as.numeric(input$show2))
      }else if (input$plottype2 == "Barplot"){
        barplot(ontology, showCategory=as.numeric(input$show2))
      }else{
        cnetplot(s_ontology, foldChange=group_gene, circular = TRUE, colorEdge = TRUE)
      }
      
    })
    # Intersection exp micro  
    inter_upexp_mic <- reactive({
      req(input$Expression_data)
      req(input$MicroRNA_data)
      
      expdata <- read.csv(input$Expression_data$datapath)
      upregulated <- expdata %>%
        filter(pvalue < as.numeric(input$pval), log2FoldChange > as.numeric(input$log)) # upregulated
      
      colnames(upregulated)[colnames(upregulated) == "pvalue"] <- "expression_pvalue"
      colnames(upregulated )[colnames(upregulated) == "log2FoldChange"] <- "expression_log2FoldChange"
      
      micdata <- read.csv(input$MicroRNA_data$datapath)

      downmic <- micdata %>%
        filter(pvalue < as.numeric(input$micpval), log2FoldChange < as.numeric(-input$miclog)) # hypomethylated
      colnames(downmic)[colnames(downmic) == "pvalue"] <- "miRNA_pvalue"
      colnames(downmic)[colnames(downmic) == "log2FoldChange"] <- "miRNA_log2FoldChange"
      
      upexp_mic <- merge(upregulated, downmic, by.x = "gene", by.y = "gene")
      upexp_mic <- unique(upexp_mic)
      
    })
    output$inter_upexp_mic <- renderDT({
      inter_upexp_mic<-  inter_upexp_mic()
      datatable( inter_upexp_mic())
    })
    
    
    ### OA
    output$ontology_plot_upexp_mic<- renderPlot({
      # Get data from the reactive expression
      inter_upexp_mic<-  inter_upexp_mic()
      exp_mic <- inter_upexp_mic
      # filter genes m e
      group_gene  <- unique(c(exp_mic$gene))
      
      #ontology type
      if (input$GOtype3 == "Biological Processes"){
        GO_type3 <- "BP"
      }else if (input$GOtype3 == "Cellular Compenant"){
        GO_type3 <- "CC"
      }else{
        GO_type3 <- "MF"
      }
      #specie
      if (input$species == "Homo sapiens") {
        library(org.Hs.eg.db)
        specie1 <- "org.Hs.eg.db"
      } else if (input$species == "Mus musculus") {
        library(org.Mm.eg.db)
        specie1 <- "org.Mm.eg.db"
      } else if (input$species == "Arabidopsis thaliana") {
        library(org.At.tair.db)
        specie1 <- "org.At.tair.db"
      } else if (input$species == "Drosophila melanogaster") {
        library(org.Dm.eg.db)
        specie1 <- "org.Dm.eg.db"
      } else if (input$species == "Danio rerio") {
        library(org.Dr.eg.db)
        specie1 <- "org.Dr.eg.db"
      } else if (input$species == "Rattus norvegicus") {
        library(org.Rn.eg.db)
        specie1 <- "org.Rn.eg.db"
      } else if (input$species == "Saccharomyces cerevisiae") {
        library(org.Sc.sgd.db)
        specie1 <- "org.Sc.sgd.db"
      } else if (input$species == "Caenorhabditis elegans") {
        library(org.Ce.eg.db)
        specie1 <- "org.Ce.eg.db"
      } else {
        # Handle the case when no species is selected or handle an unknown species
        specie1 <- NULL
      }
      # analysis
      ontology <- enrichGO(gene = group_gene, OrgDb=specie1, keyType="SYMBOL", ont=GO_type3)
      s_ontology <- simplify(ontology)
      #plot
      if (input$plottype3 == "Dotplot"){
        dotplot(ontology, showCategory=as.numeric(input$show3))
      }else if (input$plottype3 == "Barplot"){
        barplot(ontology, showCategory=as.numeric(input$show3))
      }else{
        cnetplot(s_ontology, foldChange=group_gene, circular = TRUE, colorEdge = TRUE)
      }
      
    })
    
    inter_downexp_mic <- reactive({
      req(input$Expression_data)
      req(input$MicroRNA_data)
      
      expdata <- read.csv(input$Expression_data$datapath)
      downregulated <- expdata %>%
        filter(pvalue < as.numeric(input$pval), log2FoldChange < as.numeric(-input$log)) # downregulated
      
      colnames(downregulated)[colnames(downregulated) == "pvalue"] <- "expression_pvalue"
      colnames(downregulated)[colnames(downregulated) == "log2FoldChange"] <- "expression_log2FoldChange"
      
      micdata <- read.csv(input$MicroRNA_data$datapath)
      upmic <- micdata %>%
        filter(pvalue < as.numeric(input$micpval), log2FoldChange > as.numeric(input$miclog)) # hypermethylated
      
      colnames(upmic )[colnames(upmic ) == "pvalue"] <- "miRNA_pvalue"
      colnames(upmic )[colnames(upmic ) == "log2FoldChange"] <- "miRNA_log2FoldChange"
      
      downexp_mic <- merge(downregulated, upmic, by.x = "gene", by.y = "gene")
      downexp_mic <- unique(downexp_mic)
      
    })
    output$inter_downexp_mic <- renderDT({
      inter_downexp_mic_data <- inter_downexp_mic()
      datatable(inter_downexp_mic())
    })
    
    ### OA
    output$ontology_plot_downexp_mic<- renderPlot({
      exp_mic <- inter_downexp_mic()
      
      # filter genes m e
      group_gene  <- unique(c(exp_mic$gene))
      
      #ontology type
      if (input$GOtype4 == "Biological Processes"){
        GO_type4 <- "BP"
      }else if (input$GOtype4 == "Cellular Compenant"){
        GO_type4 <- "CC"
      }else{
        GO_type4 <- "MF"
      }
      #specie
      if (input$species == "Homo sapiens") {
        library(org.Hs.eg.db)
        specie1 <- "org.Hs.eg.db"
      } else if (input$species == "Mus musculus") {
        library(org.Mm.eg.db)
        specie1 <- "org.Mm.eg.db"
      } else if (input$species == "Arabidopsis thaliana") {
        library(org.At.tair.db)
        specie1 <- "org.At.tair.db"
      } else if (input$species == "Drosophila melanogaster") {
        library(org.Dm.eg.db)
        specie1 <- "org.Dm.eg.db"
      } else if (input$species == "Danio rerio") {
        library(org.Dr.eg.db)
        specie1 <- "org.Dr.eg.db"
      } else if (input$species == "Rattus norvegicus") {
        library(org.Rn.eg.db)
        specie1 <- "org.Rn.eg.db"
      } else if (input$species == "Saccharomyces cerevisiae") {
        library(org.Sc.sgd.db)
        specie1 <- "org.Sc.sgd.db"
      } else if (input$species == "Caenorhabditis elegans") {
        library(org.Ce.eg.db)
        specie1 <- "org.Ce.eg.db"
      } else {
        # Handle the case when no species is selected or handle an unknown species
        specie1 <- NULL
      }
      # analysis
      ontology <- enrichGO(gene = group_gene, OrgDb=specie1, keyType="SYMBOL", ont=GO_type4)
      s_ontology <- simplify(ontology)
      #plot
      if (input$plottype4 == "Dotplot"){
        dotplot(ontology, showCategory=as.numeric(input$show4))
      }else if (input$plottype4 == "Barplot"){
        barplot(ontology, showCategory=as.numeric(input$show4))
      }else{
        cnetplot(s_ontology, foldChange=group_gene, circular = TRUE, colorEdge = TRUE)
      }
      
    })
    
  })
}

# Run the application
shinyApp(ui, server)
