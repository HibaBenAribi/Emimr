Ui <- shinyUI({
 fluidPage(
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
    #######################################################################
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
          ###############
          tabPanel("intersection DEGs and DMGs",
                   conditionalPanel(
                     condition = "input.submit_button > 0 && input.data_selection.includes('methylation')",
                     #h3("Intersection between DEGs and DMGs"),
                     #shinycssloaders::withSpinner(verbatimTextOutput("gene_met")),
                     
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
          #########################
          tabPanel("intersection DEGs and DEImR",
                   conditionalPanel(
                     condition = "input.submit_button > 0 && input.data_selection.includes('microRNA')",
                     ##
                     h3("Intersection between DEGs and DEImR"),
                     #verbatimTextOutput("gene_micro"), #table
                     # 
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
                     ##
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
})