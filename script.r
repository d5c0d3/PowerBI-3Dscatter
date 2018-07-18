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


        #droplines
        dl_set <- dataset
        names(dl_set) <- c("x", "y", "z")
        dl_set$id <- seq_len(nrow(dl_set))
        dl <- replicate(2, dl_set, simplify = F)
        dlz <- dl
        dlz[[2]]$z <- min(dl_set$z)
        dlz <- group2NA(bind_rows(dlz), "id")
        dlx <- dl
        dlx[[2]]$x <- min(dl_set$x)
        dlx <- group2NA(bind_rows(dlx), "id")
        dly <- dl
        dly[[2]]$y <- min(dl_set$y)
        dly <- group2NA(bind_rows(dly), "id")

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
                layout(margin=m) %>%
        add_paths(data = dlz, x = ~x, y = ~y, z = ~z, color=I("grey"), showlegend=F, text="test") %>%
        add_paths(data = dlx, x = ~x, y = ~y, z = ~z, color=I("grey"), showlegend=F, text="test") %>%
        add_paths(data = dly, x = ~x, y = ~y, z = ~z, color=I("grey"), showlegend=F, text="test")


};



####################################################

############# Create and save widget ###############
#p = ggplotly(g);
internalSaveWidget(p, 'out.html');
####################################################
