source('./r_files/flatten_HTML.r')

############### Library Declarations ###############
libraryRequireInstall("ggplot2");
libraryRequireInstall("plotly");
libraryRequireInstall("dplyr");
####################################################

################### Actual code ####################
#g = qplot(`Petal.Length`, data = iris, fill = `Species`, main = Sys.time());

if(!exists("x") || !exists("y") || !exists("z")) # invalid input

{
        validToPlot <- FALSE

        pbiWarning1 <- "X, Y AND Z values are required"

        #pbiWarning <- cutStr2Show(pbiWarning1, strCex = sizeWarn/6, partAvailable = 0.9)
        pbiWarning <- pbiWarning1

} else {

        validToPlot <- TRUE

        dataset <- data.frame(x,y,z)
        names(dataset) <- c(names(x), names(y), names(z))
}


if(validToPlot)

{
        size_var_exists <- FALSE
        if(exists("size"))

        {
                size_var_exists <- TRUE
                dataset <- data.frame(dataset,size)
                names(dataset)[ncol(dataset)] <- names(size)
        } else {
                dataset$size <- 1
        }

        color_var_exists <- FALSE
        if(exists("color"))

        {
                color_var_exists <- TRUE
                dataset <- data.frame(dataset,color)
                names(dataset)[ncol(dataset)] <- names(color)
        }

        colNames <- names(dataset)
        m <- list(
                l = 0,
                r = 0,
                b = 0,
                t = 0,
                pad = 1
        )
        p <- plot_ly() %>%
                add_markers(data = dataset,
                            x = as.formula(paste0("~`", colNames[1], "`")),
                            y = as.formula(paste0("~`", colNames[2], "`")),
                            z = as.formula(paste0("~`", colNames[3], "`")),
                            size = if (size_var_exists) as.formula(paste0("~`", colNames[4], "`")),
                            marker = list(sizemode = "diameter"),
                            sizes = c(5,20),
                            color = if (color_var_exists) as.formula(paste0("~`", colNames[5], "`")),
                            colors = c('#BF382A', '#0C4B8E')) %>%
                layout(margin=m)


};



####################################################

############# Create and save widget ###############
#p = ggplotly(g);
internalSaveWidget(p, 'out.html');
####################################################
