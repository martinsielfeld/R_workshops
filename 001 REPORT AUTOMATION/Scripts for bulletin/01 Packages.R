
pack <- c('data.table','dplyr','ggplot2','scales','flextable','officer','lubridate')
install.packages(setdiff(pack, rownames(installed.packages())))
sapply(pack,require,character.only=TRUE)
