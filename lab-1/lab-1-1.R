fix_column <- function(column) {
  column_without_spase <- as.numeric(sub(' ', '', column))
  if(any(is.na(column_without_spase))){
    return(column)
  }
  return(column_without_spase)
}

fix_data <- function(data) {
  for (i in colnames(data)) {
    data[[i]] <- fix_column(data[[i]])
  }
  return(data)
}

data <- read.csv("test_data_01.csv")
fix_data(data)






