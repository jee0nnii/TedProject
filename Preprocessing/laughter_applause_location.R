
setwd("C:/Users/지현/Desktop/ted-talks")
dat <- read.csv("scriptSet.csv", header = T, stringsAsFactors = F)
script <- dat$transcript

clean_words <- list()
laugh_loc_list <- list()
laugh_freq_list <- list()
appl_loc_list <- list()
appl_freq_list <- list()


for (i in 1:length(script)) {
  # 전처리
  words <- unlist(strsplit(script[i], "\\s+(?=[(])", perl=T))
  words <- unlist(strsplit(words, "[.]+(?=[(])", perl=T))
  words <- unlist(strsplit(words, "[?]+(?=[(])", perl=T))
  words <- unlist(strsplit(words, "\"+(?=[(])", perl=T))
  words <- unlist(strsplit(words, "[)]", perl=T))
  words <- unlist(strsplit(words, "[.]|[?]|\"|,|!|:|;", perl=T))
  words <- unlist(strsplit(words, " "))
  words <- words[nchar(words)>0]
  clean_words[[i]] <- tolower(words)
  # 웃음 빈도 및 위치
  laugh_loc_index <- which(clean_words[[i]] == "(laughter")
  laugh_freq_list[[i]] <- length(laugh_loc_index)
  laugh_loc_list[[i]] <- laugh_loc_index / length(words)
  # 박수 빈도 및 위치
  appl_loc_index <- which(clean_words[[i]] == "(applause")
  appl_freq_list[[i]] <- length(appl_loc_index)
  appl_loc_list[[i]] <- appl_loc_index / length(words)
}

# 원하는 인덱스 번호 넣어서 결과 출력해보세요...
clean_words[[70]]
laugh_loc_list[[70]]
laugh_freq_list[[70]]
appl_loc_list[[70]]
appl_freq_list[[70]]


