source('./r_files/flatten_HTML.r')

############### Library Declarations ###############
libraryRequireInstall("ggplot2");
libraryRequireInstall("plotly");
libraryRequireInstall("dplyr");
####################################################

################### Actual code ####################
#g = qplot(`Petal.Length`, data = iris, fill = `Species`, main = Sys.time());

#p <- Values %>%
#        plot_ly( x = ~wt, y = ~hp, z = ~qsec, color = ~cyl, colors = c('#BF382A', '#0C4B8E')) %>%
#        add_markers() %>%
#        layout(scene = list(xaxis = list(title = 'Weight'),
#                            yaxis = list(title = 'Gross horsepower'),
#                            zaxis = list(title = '1/4 mile time')));


if(!exists("x") || !exists("y") || !exists("z")) # invalid input

{
        validToPlot <- FALSE

        pbiWarning1 <- "X, Y AND Z values are required"

        #pbiWarning <- cutStr2Show(pbiWarning1, strCex = sizeWarn/6, partAvailable = 0.9)
        pbiWarning <- pbiWarning1

} else {

        validToPlot <- TRUE

        dataset <- cbind(x,y,z)
}


if(validToPlot)

{
        if(exists("size"))

        {

                dataset <- cbind(dataset,size)

        } else {
                dataset$size <- 1
        }

        if(exists("color"))

        {

                dataset <- cbind(dataset,color)

        } else {
                dataset$color <- NULL
        }

        if(exists("tooltips"))

        {

                dataset <- cbind(dataset,tooltips)

        }

        #
        # data(mtcars)
        # x <- mtcars$hp
        # y <- mtcars$wt
        # z <- mtcars$qsec
        # color <- mtcars$cyl

        p <- plot_ly() %>%
                add_markers(data = dataset,
                            x = ~x,
                            y = ~y,
                            z = ~z,
                            size=~size,
                            marker = list(sizemode = "diameter"),
                            sizes = c(5,20),
                            color = ~color ,
                            colors = c('#BF382A', '#0C4B8E'))
}
#p

####################################################

############# Create and save widget ###############
#p = ggplotly(g);
internalSaveWidget(p, 'out.html');
####################################################
