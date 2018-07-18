source('./r_files/flatten_HTML.r')

############### Library Declarations ###############
libraryRequireInstall("ggplot2");
libraryRequireInstall("plotly");
libraryRequireInstall("dplyr");
####################################################

################### Actual code ####################
#g = qplot(`Petal.Length`, data = iris, fill = `Species`, main = Sys.time());

p <- Values %>%
        plot_ly( x = ~wt, y = ~hp, z = ~qsec, color = ~cyl, colors = c('#BF382A', '#0C4B8E')) %>%
        add_markers() %>%
        layout(scene = list(xaxis = list(title = 'Weight'),
                            yaxis = list(title = 'Gross horsepower'),
                            zaxis = list(title = '1/4 mile time')));
####################################################

############# Create and save widget ###############
#p = ggplotly(g);
internalSaveWidget(p, 'out.html');
####################################################
