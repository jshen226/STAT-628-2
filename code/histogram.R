multiplot <- function(..., plotlist=NULL, file, cols=1, layout=NULL) {
  library(grid)
  
  # Make a list from the ... arguments and plotlist
  plots <- c(list(...), plotlist)
  
  numPlots = length(plots)
  
  # If layout is NULL, then use 'cols' to determine layout
  if (is.null(layout)) {
    # Make the panel
    # ncol: Number of columns of plots
    # nrow: Number of rows needed, calculated from # of cols
    layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
                     ncol = cols, nrow = ceiling(numPlots/cols))
  }
  
  if (numPlots==1) {
    print(plots[[1]])
    
  } else {
    # Set up the page
    grid.newpage()
    pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))
    
    # Make each plot, in the correct location
    for (i in 1:numPlots) {
      # Get the i,j matrix positions of the regions that contain this subplot
      matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))
      
      print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
                                      layout.pos.col = matchidx$col))
    }
  }
}
require(ggplot2)
df <- data.frame(read.csv('star_count_info.csv', header = T))
df1 <- df[, 2:7]
df_positive <- df1[c(10, 143, 87, 39, 41, 4), ]
for (i in 1:6){
  df_tmp <- data.frame(t(df_positive[i, -1]))
  df_tmp <- cbind(c('1', '2', '3', '4', '5'), df_tmp)
  colnames(df_tmp) <- c('Star', 'Count')
  assign(paste0('p', i), ggplot(df_tmp, aes(x = Star, y = Count)) + 
           geom_bar(stat="identity", fill="darkred") + 
           theme_minimal() + 
           xlab(df_positive[i, 1]) + 
           ylab('') + 
           theme_grey(base_size = 22) + 
           ylim(c(0, max(df_positive[, -1]))) +
           theme(axis.text.y=element_blank()))
}
ggsave("positive.pdf", multiplot(p1, p2, p3, p4, p5, p6, cols = 3), width = 9, height = 6)

df_punctuation <- df1[c(3, 26, 164) - 1, ]
for (i in 1:3){
  df_tmp <- data.frame(t(df_punctuation[i, -1]))
  df_tmp <- cbind(c('1', '2', '3', '4', '5'), df_tmp)
  colnames(df_tmp) <- c('Star', 'Count')
  assign(paste0('p', i), ggplot(df_tmp, aes(x = Star, y = Count)) + 
           geom_bar(stat="identity", fill="darkred") + 
           theme_minimal() + 
           xlab(df_punctuation[i, 1]) + 
           ylab('') + 
           theme_grey(base_size = 22) + 
           ylim(c(0, max(df_punctuation[, -1]))) +
           theme(axis.text.y=element_blank()))
}
ggsave("punctuation.pdf", multiplot(p1, p2, p3, cols = 3), width = 9, height = 3)

df_negative <- df1[c(7, 9, 29, 17, 62, 6), ]
for (i in 1:6){
  df_tmp <- data.frame(t(df_negative[i, -1]))
  df_tmp <- cbind(c('1', '2', '3', '4', '5'), df_tmp)
  colnames(df_tmp) <- c('Star', 'Count')
  assign(paste0('p', i), ggplot(df_tmp, aes(x = Star, y = Count)) + 
           geom_bar(stat="identity", fill="darkred") + 
           theme_minimal() + 
           xlab(df_negative[i, 1]) + 
           ylab('') + 
           theme_grey(base_size = 22) + 
           ylim(c(0, max(df_negative[, -1]))) +
           theme(axis.text.y=element_blank()))
}
ggsave("negative.pdf", multiplot(p1, p2, p3, p4, p5, p6, cols = 3), width = 9, height = 6)

df <- data.frame(read.csv('star_noun.csv', header = T))
df1 <- df[, 2:7]
df_food <- df1[c(11, 21, 26, 34, 36, 39) - 1, ]
for (i in 1:6){
  df_tmp <- data.frame(t(df_food[i, -1]))
  df_tmp <- cbind(c('1', '2', '3', '4', '5'), df_tmp)
  colnames(df_tmp) <- c('Star', 'Count')
  assign(paste0('p', i), ggplot(df_tmp, aes(x = Star, y = Count)) + 
           geom_bar(stat="identity", fill="darkred") + 
           theme_minimal() + 
           xlab(df_food[i, 1]) + 
           ylab('') + 
           theme_grey(base_size = 22) + 
           ylim(c(0, max(df_food[, -1]))) +
           theme(axis.text.y=element_blank()))
}
ggsave("food.pdf", multiplot(p1, p2, p3, p4, p5, p6, cols = 3), width = 9, height = 6)
