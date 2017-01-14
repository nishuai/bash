get_os <- function(){
    sysinf <- Sys.info()
    if (!is.null(sysinf)){
        os <- sysinf['sysname']
        if (os == 'Darwin')
            os <- "Mac OS"
    } else { ## mystery machine
        os <- .Platform$OS.type
        if (grepl("^darwin", R.version$os))
            os <- "Mac OS"
        if (grepl("linux-gnu", R.version$os))
            os <- "Linux"
    }
    os
}

Syname=as.character(get_os())
print(paste0("Hellow, ", as.character(Sys.info()[8]), ", "user of ", Syname, "system, you have successfully loaded me into your environment, good job!")
