shinyServer(function(input,output,session){
  
  plot <- reactive({
    
    Plot <- SaudiLifeExpectancy %>%
      mutate(year = as.Date(paste0("01-01-",year),format = "%d-%m-%Y")) %>%
      rename(`Life Expectancy` = average) %>%
      
      ggplot(aes(x = year, y = `Life Expectancy`, color = gender)) +
      geom_line()+
      xlab("Year") +
      ylab("Life Expectancy (in years)") +
      theme_classic() +
      scale_x_date(date_breaks = "1 year",date_labels = "%Y") +
      theme(plot.margin = margin(0.8,0.5,0.5,0.5,"cm"),plot.title = element_text(size = 12)) +
      geom_point() +
      scale_color_manual(name = "Gender", values = c("#03045e","#0077b6","#00b4d8","#90e0ef"))
    
    ggplotly(Plot,tooltip = c("x", "y")) %>%
      layout(title = list(text = paste0("Life Expectancy of Saudi Population Between 2011 and 2022",
                                        '<br>',
                                        '<sup>',
                                        'Source: portal.saudicensus.sa','</sup>')))
  })
  
  # Arabic page
  output$plot1 <- renderPlotly({
    plot()
  })
  
  # English page
  output$plot2 <- renderPlotly({
    plot()
  })
  
})
  