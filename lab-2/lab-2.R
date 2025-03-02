path = "D:\Documents\4 курс\R-labs\ExpImp.RData"
exp_imp_data <- local(get(load(path)))
library("stringr")

REGION_DELIMITER <- "федеральный"
MISC <- c("Российская Федерация", "в том числе:")
EMPTY_CELL_MARKER <- "-"
EMPTY_CELL_PLACEHOLDER <- 0

get_regions_df <- function(data) {
  for (i in 2:length(names(data))) {
    data[[i]] <- gsub(EMPTY_CELL_MARKER, EMPTY_CELL_PLACEHOLDER, data[[i]])
    data[[i]] <- as.numeric(data[[i]])
  }
  regions <- data.frame('', '')
  tmp_index <- 0
  tmp_region <- ""
  for (subject in data$'Регион') {
    tmp_index <- tmp_index + 1
    
    if (subject %in% MISC)
      next
    
    if (str_detect(subject, REGION_DELIMITER)) {
      tmp_region <- subject
      next
    }
    tmp_df <- data.frame()
    tmp_df <- rbind(tmp_df, tmp_region)
    tmp_df <- rbind(tmp_df, sum(data[tmp_index, 2:length(names(data))]))
    names(tmp_df) <- subject
    regions <- cbind(regions, tmp_df)
  }
  return(regions)
}

get_region_info <- function(subject, regions_df) {
  column <- regions_df[[subject]]
  if (length(column) == 0) {
    print("Введено неверное название субъекта")
  }
  else {
    print(str_c("Выбранный регион: ", subject))
    print(str_c("Принадлежит округу: ", column[[1]]))
    print(str_c("Суммарный импорт и экпорт: ", column[[2]]))
  }
  print("---------------------------------------------")
}

available_regions <- get_regions_df(exp_imp_data)
get_region_info('Алтайский край', get_regions_df(exp_imp_data))

