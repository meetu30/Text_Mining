# Text analysis using tidytext and dplyr in R using JEOPARDY_CSV.csv dataset

# install folowing packages and load the libraries
#     tidytext
#     dplyr
#     ggplot2

# Read the JEOPARDY_CSV.csv data, making sure to uncheck StringsAsFactors
# This dataset contains the Answer column which we will mine
library(tidytext)
library(dplyr)
library(ggplot2)
library(data.table)

getwd()
setwd("C:/Meetu/Fall2018/BigData/Project")


# read the data 
jeoData <- read.csv("C:/Meetu/Fall2018/BigData/Project/JEOPARDY_CSV.csv", stringsAsFactors=FALSE)
colnames(jeoData)

# count number of rows
ncount <- nrow(jeoData)
ncount

# extract only the Question column into a dataset
answerData <- jeoData$Answer

# convert the data to a data frame
text_df <- data_frame(line = 1:ncount, text = answerData)
head(text_df)

# tokenize with standard tokenization using unnest_tokens from tidytext
token_data <- unnest_tokens(text_df, word, text)

# remove stop-words using anti_join function from dplyr
# stop_words come from tidytext package
token_data <- anti_join(token_data, stop_words)

# use the count() function of dplyr to view most common words
wordcount <- count(token_data,word, sort = TRUE)

# filter for n > 500 using filter function from dplyr
wordcountfiltered <- filter(wordcount, n > 500)

# visualize with ggplot
ggplot(wordcountfiltered, aes(reorder(word, n), n)) +
  geom_bar(stat = "identity") +
  xlab(NULL) +
  coord_flip()

