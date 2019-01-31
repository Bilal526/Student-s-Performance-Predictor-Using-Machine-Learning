library(shiny)
library(shinydashboard)

library(shinythemes)
shinyServer(
  function(input, output) ({
    
    output$tabset1Selected <- renderText({
      input$tabset1})
    
    output$myImage <- renderImage({
      if(aa() == 307){                           #condition for roll number 306 and 307
        list(src = "www/m.jpg",
             contentType = 'image/png',
             width = 225,
             height = 225,
             alt = "")
      }else if(aa()== 1 || aa()== 2 || aa()== 3 || aa()== 4 || aa()== 5 || aa()== 6 || aa()== 7 || aa()== 8 || aa()== 9 || aa()== 10
               || aa()== 11 || aa()== 12 || aa()== 13 || aa()== 14 || aa()== 15 || aa()== 16 || aa()== 17 || aa()== 18 || aa()== 19 || aa()== 20
               || aa()== 21 || aa()== 25 
               )
      {
        list(src = "www/f.jpg",
             contentType = 'image/png',
             width = 225,
             height = 225,
             alt = "")
      }else{
        
        list(src = "www/m.jpg",
             contentType = 'image/png',
             width = 225,
             height = 225,
             alt = "")
      }
    },deleteFile = FALSE)
    
    output$mystd <- renderText(
      paste ("You selected quantitive variable: ", input$std))
    mydataframe <- data.frame(data)                               #making the dataframe
    
    aa <- reactive ({ as.numeric(substr(input$std,6,9))})         #slicing the string e.g from CS-15004 to 004
    seca <- reactive({ if(aa() == 307){                           #condition for roll number 306 and 307
      aa <- 37;
    }else if(aa()== 306)
    {
      aa<- 36;
    }else{
      
      aa <- aa();
    }
    } )
    
    output$selstd <- renderTable({   
      azb <-  mydataframe[seca(),] 
      azb[,1:15]    
    })
    
    output$mydataframe <- renderTable({
      mydataframe})
    
    output$selstddetail <- renderTable({   
      azb <-  mydataframe[seca(),] 
      azb[,1:3]    
      })
    output$selstda <- renderTable({   
      azb <-  mydataframe[seca(),] 
      azb[,16:32]    
    })
    output$selstdb <- renderTable({   
      azb <-  mydataframe[seca(),] 
      azb[,33:39]    
    })
    
    output$selstd1 <- renderTable({                          
      t(mydataframe[seca(),] )
    })
    output$mydataframe <- renderTable({                #printing all the student's information
      mydataframe})
    
    toplot1 <- reactive  ({toplot()[4:35,1]})
    
    output$myhist <- renderPlot({
      #hist(mydataframe$CGPA,xlab = "GPA",ylab = "frequency",col='blue',main= "Histogram")
      hist(as.numeric(toplot1()),breaks = seq(0, max(8,l=6)), col='blue', main="Histogram of CGPA",
           xlab="CGPA")
    })
    
    datadatatext.features <- mydataframe
    datadatatext.features$NAME <- NULL
    datadatatext.features$ROLL.NO. <- NULL
    datadatatext.features$ENRL <- NULL
    results <- kmeans(datadatatext.features,4)
    
    d<-reactive({
      d<-t(mydataframe[seca(),])
      d<-data.frame(d)
      names(d)<-c("GPA")
      d$GPA<-as.numeric(as.character(d$GPA))
      library(tibble)
      add_column(d,courses=as.numeric(c(NA,NA,NA,1:36)),.after = 1)
      
      #d$GPA<-as.numeric(as.character(d$GPA))
      #d$courses<-as.numeric(as.character(d$courses))
    })
    
    output$dd <- renderTable({
      d() })
    
    
    output$prediction <- renderPlot({
      plot(GPA~courses,data=d()[4:35,],col=results$cluster)
      mean.GPA=mean(d()$GPA,na.rm = T)
      abline(h=mean.GPA)
      model1=lm(GPA~courses,data=d())
      summary(model1)
    })
    
    output$bestline <- renderPlot({
      plot(GPA~courses,data=d()[4:35,],col=results$cluster)
      mean.GPA=mean(d()$GPA,na.rm = T)
      model1=lm(GPA~courses,data=d())
      abline(model1)
      summary(model1)
    })
    
    toplot  <- reactive  ({ t(mydataframe[seca(),])})
    
    name <- reactive({ toplot()[1,1]})
    output$name <- renderText(
      paste ("Name : ", name()))
    
    rollNo <- reactive({ toplot()[2,1]})
    output$rollNo <- renderText(
      paste ("Roll No. : ", rollNo()))
  
    fe <- reactive  ({toplot()[36,1]})
    output$fe <- renderText(
      paste ("FE GPA : ", fe()))
    
    se <- reactive  ({toplot()[37,1]})
    output$se <- renderText(
      paste ("SE GPA : ", se()))
    
    te <- reactive  ({toplot()[38,1]})
    output$te <- renderText(
      paste ("TE GPA : ", te()))
    
    gpa_mean <- reactive({
      mean(d()$GPA,na.rm = T)
    })
    output$meanCGPA <- renderText(
      paste ("Mean CGPA : ", gpa_mean()))
    
    cgpa <- reactive  ({toplot()[39,1]})
    output$be <- renderPrint ({
      model2=lm(GPA~courses,data=d())
      summary(model2)
    })
    
    output$model <- renderPlot({
      model1=lm(GPA~courses,data=d())
      plot(model1)
    })
    
    output$myplot <- renderPlot({
      plot(toplot1(), col=results$cluster ,main = input$std ,xlab = "Courses",ylab = "GPA")
    })
  }
  ))

