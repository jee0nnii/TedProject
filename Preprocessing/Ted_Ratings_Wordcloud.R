setwd("C:/Users/Sohyeon/Desktop/데잇걸즈/Jupyter")
rm(list=ls())

main <- read.csv("cleaned_ted_main.csv", header=TRUE)

colnames(main)[15] <- "courageous"

View(main)

# rating -> 임시 데이터 프레임

rating <- main[ ,c(14:27)]
dim(rating) # 2550행, 14열


# 열 별로 top과 bottom의 rating 항목 구하기

top_rating <- character()

for(i in 1:nrow(rating)) {
  sorted_rating <- sort(rating[i, ], decreasing = TRUE)
  
  top_rating <- c(top_rating, names(sorted_rating[1]))
  
}

bottom_rating <- character()

for(i in 1:nrow(rating)) {
  sorted_rating <- sort(rating[i, ], decreasing = FALSE)
  
  bottom_rating <- c(bottom_rating, names(sorted_rating[1]))
}


main$top_rating <- top_rating
main$bottom_rating <- bottom_rating


# 각 rating별로 가장 높게 나온 TED의 제목
top_informative <- as.character(main[which((main$top_rating == "informative") == TRUE), 2])
top_funny <- as.character(main[which((main$top_rating == "funny") == TRUE), 2])
top_courageous <- as.character(main[which((main$top_rating == "courageous") == TRUE), 2]) # 0개
top_confusing <- as.character(main[which((main$top_rating == "confusing") == TRUE), 2])
top_beautiful <- as.character(main[which((main$top_rating == "beautiful") == TRUE), 2])
top_unconvincing <- as.character(main[which((main$top_rating == "unconvincing") == TRUE), 2])
top_longwinded <- as.character(main[which((main$top_rating == "longwinded") == TRUE), 2])
top_inspiring <- as.character(main[which((main$top_rating == "inspiring") == TRUE), 2])
top_fascinating <- as.character(main[which((main$top_rating == "fascinating") == TRUE), 2])
top_ingenious <- as.character(main[which((main$top_rating == "ingenious") == TRUE), 2])
top_persuasive <- as.character(main[which((main$top_rating == "persuasive") == TRUE), 2])
top_jawdrop <- as.character(main[which((main$top_rating == "jawdrop") == TRUE), 2])
top_obnoxious <- as.character(main[which((main$top_rating == "obnoxious") == TRUE), 2])
top_OK <- as.character(main[which((main$top_rating == "OK") == TRUE), 2])


# 해당 top_rating별 개수
length(top_informative)   # 63
length(top_funny)         # 752
length(top_courageous)    # 629
length(top_beautiful)     # 272
length(top_unconvincing)  # 176
length(top_longwinded)    # 110
length(top_inspiring)     # 31
length(top_fascinating)   # 26
length(top_ingenious)     # 10
length(top_persuasive)    # 28
length(top_jawdrop)       # 1
length(top_obnoxious)     # 1
length(top_OK)            # 5

View(dat)

#### top_rating의 결과로 나온 TED의 title의 스크립트를 모두 모아 워드클라우드로 비교분석 ####

# 0. 환경설정 -------------------------------------------------------
# install.packages("tm")
# install.packages("tidytext")
install.packages("qdap")
library(tm)
library(tidytext)
library(qdap)
library(tidyverse)
library(wordcloud)
library(tibble)
library(plotrix)
library(stringr)

clean_text <- function(text){
  text <- tolower(text)
  text <- removeNumbers(text)
  # text <- bracketX(text)
  # text <- replace_number(text)
  # text <- replace_abbreviation(text)
  # text <- replace_contraction(text)
  # text <- replace_symbol(text)
  text <- removePunctuation(text)
  text <- stripWhitespace(text)
  # text <- str_replace_all(text, "americans", "america")
  
  indexes <- which(text == "")
  if(length(indexes) > 0){
    text <- text[-indexes]
  } 
  return(text)
}


clean_corpus <- function(corpus){
  # corpus <- tm_map(corpus, content_transformer(replace_abbreviation))
  corpus <- tm_map(corpus, stripWhitespace)
  corpus <- tm_map(corpus, removePunctuation)
  corpus <- tm_map(corpus, removeNumbers)
  corpus <- tm_map(corpus, removeWords, c(stopwords("en"), "Top200Words"))
  corpus <- tm_map(corpus, content_transformer(tolower))
  return(corpus)
}


# 1. 데이터 불러오기 -------------------------------------------------------
setwd("C:/Users/Sohyeon/Desktop/데잇걸즈/Jupyter")
rm(list=ls())

dat <- read.csv("scriptSet.csv", header=TRUE, stringsAsFactors = FALSE)


View(dat)

grep("\\D", dat$X)
dat <- dat[-c(350, 2309, 2342), ]
dat <- dat[ , c(2:5)]


# 2. 데이터 전처리 -------------------------------------------------------

# 불용어 추출기
stopwords("en")


# 불용어 사전에 단어 추가

# stop_words_lst <- c("the", "and", "for", "that", "this", "how", "about", "can",
#                     "with", "you", "from", "his", "what", "was", "your", "but",
#                     "could", "one", "our", "they", "when", "them", stopwords("english"))
# removeWords(text, stop_words_lst)

dat$transcript <- removeWords(dat$transcript, stopwords("english"))  
stop_words_lst <- c("said", "say", "just", "like", "now", stopwords("english"))
dat$transcript <- removeWords(dat$transcript, stop_words_lst)  


dat$transcript <- stripWhitespace(dat$transcript) # 불용어 제거한 후 공백 제거


source("code/clean_fun.R")

make_corpus <- function(text) {
  text_clean <- clean_text(text)
  text_source <- VectorSource(text_clean)
  text_corpus <- VCorpus(text_source)
  corpus <- clean_corpus(text_corpus)
}

# top_informative의 title과 일치하는 스크립트 골라오기
informative_script <- dat[which((dat$title %in% top_informative) == TRUE), 4]
funny_script <- dat[which((dat$title %in% top_funny) == TRUE), 4]
persuasive_script <- dat[which((dat$title %in% top_persuasive) == TRUE), 4]

informative_corpus <- make_corpus(informative_script)
funny_corpus <- make_corpus(funny_script)
persuasive_corpus <- make_corpus(persuasive_script)


# 3. 말뭉치를 데이터프레임으로 변환 --------------------------------------

word_freq <- function(corpus) {
  doc_tdm <- TermDocumentMatrix(corpus)
  doc_m <- as.matrix(doc_tdm)
  doc_term_freq <- rowSums(doc_m)
  doc_word_freqs <- data.frame(term = names(doc_term_freq),
                               num = doc_term_freq) %>% arrange(desc(num))
  return(doc_word_freqs)
}

informative_word_freqs <- word_freq(informative_corpus)
funny_word_freqs <- word_freq(funny_corpus)
persuasive_word_freqs <- word_freq(persuasive_corpus)

# 4. 시각화 --------------------------------------------------------------
## 4.1. 단어구름----------------------------------------------------------
par(mfrow=c(1,1))
wordcloud(informative_word_freqs$term, informative_word_freqs$num, max.words=100)
wordcloud(funny_word_freqs$term, funny_word_freqs$num, max.words=100)
wordcloud(persuasive_word_freqs$term, persuasive_word_freqs$num, max.words=100)



dat$transcript[1] <- gsub("and", "", dat$transcript[1])
dat$transcript[1] <- gsub("  ", " ", dat$transcript[1])

write.csv(main, file = "top_rating_added_TED_main.csv")

#### 이제 뭐하지 ####












