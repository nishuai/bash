library(ggplot2)
f <- function(x) 1/(x^2-1)
x <- seq(-3,3, by=0.001)
y <- f(x)
d <- data.frame(x=x,y=y)

p <- ggplot()
p <- p+geom_rect(fill = "white",color="black",size=3,
                 aes(xmin=-3, xmax=3,
                     ymin=-3,ymax=3, alpha=0.1))

p <- p + geom_line(data=d, aes(x,y), size=3)+ylim(-3,3)
p <- p + theme_bw() +
    theme(axis.text.x=element_blank(),
          axis.text.y=element_blank(),
          legend.position="none",
          panel.grid.minor=element_blank(),
          panel.grid.major=element_blank(),
          panel.background=element_blank(),
          axis.ticks=element_blank(),
          panel.border=element_blank())

p <- p+xlab("")+ylab("")
print(p)
