library(shiny)
library(shinydashboard)
ui <- dashboardPage(
  
  dashboardHeader(title = "ABS"),
  
  dashboardSidebar(
    sidebarMenu(
      img(src="p.png",width="95%"),
    menuItem("Data Set", tabName = "dataset",icon = icon("dashboard")),
    menuItem("Select Student", tabName = "selectstd",icon = icon("dashboard")),
    menuItem("Students Coursewise GPA", tabName = "stdGPA",icon = icon("dashboard")),
    menuItem("Predicted BE GPA", tabName = "BEprediction",icon = icon("dashboard")),
    menuItem("Histogram", tabName = "histogram",icon = icon("dashboard")),
    
    h5(textOutput("name")),
    h5(textOutput("rollNo"))),
    imageOutput("myImage")
    ),
  dashboardBody(
    titlePanel(title= h3("STUDENT'S PERFORMANCE PREDICTOR", align="center")),
    tabItems(
      tabItem(tabName = "dataset",tableOutput("mydataframe")),
      tabItem(tabName = "BEprediction", 
              
              box(width=12,status = "primary",solidHeader = TRUE,collapsible = FALSE,title = " Final Year Predicted GPA ",verbatimTextOutput("be"))),
      tabItem(tabName = "histogram",plotOutput("myhist")),
      tabItem(tabName = "stdGPA",
              tableOutput("selstd" ),
              tableOutput("selstda" ),
              tableOutput("selstdb" )
              
      ),
      tabItem(tabName = "selectstd",
              box(width=4,status = "primary",solidHeader = TRUE,collapsible = FALSE,title = "Selection ",selectInput("std", " Select the Student", choices = c("CS-15001", "CS-15002", "CS-15003" ,"CS-15004" ,"CS-15005" ,"CS-15006", "CS-15007", "CS-15008" ,"CS-15009", "CS-15010", "CS-15011", "CS-15012", "CS-15013", "CS-15014", "CS-15015", "CS-15016", "CS-15017", "CS-15018", "CS-15019", "CS-15020", "CS-15021","CS-15022","CS-15022","CS-15023","CS-15024","CS-15025","CS-15026","CS-15027","CS-15028","CS-15029","CS-15030","CS-15031","CS-15032","CS-15033","CS-15034","CS-15035","CS-15306","CS-15307"))),
              box(width = 5,status = "primary",solidHeader = TRUE,collapsible = FALSE,title = "Details",tableOutput("selstddetail" )),
              box(width = 3,status = "primary",solidHeader = TRUE,collapsible = FALSE,title = "GPA ",h6(textOutput("fe")) ,h6(textOutput("se")) ,h6(textOutput("te")),h6(textOutput("meanCGPA"))),
              br(),
              br(),br(),
              #tableOutput("selstda" ),
              #tableOutput("selstdb" ),
              
              box(width = 6,status = "primary",solidHeader = TRUE,collapsible = FALSE,title = "GPA vs Course Plot",plotOutput("myplot")),
              
              box(width = 6,status = "primary",solidHeader = TRUE,collapsible = FALSE,title = " Linear Model(Mean Horizontal Line Plot) ",plotOutput("prediction")),
              
              box(width = 6,status = "primary",solidHeader = TRUE,collapsible = FALSE,title = " Linear Model(Residuals VS Leverage) ",plotOutput("model")),
              
              box(width = 6,status = "primary",solidHeader = TRUE,collapsible = FALSE,title = " Best Fitted Line For Linear Model ",plotOutput("bestline"))
              )
      )
      
    )
  )