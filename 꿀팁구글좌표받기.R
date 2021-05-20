data <- read.csv(data.file)
data
library(dplyr)
library(ggmap)
register_google(key="AIzaSyD1HJZt6ywR4ugFTtBgosyJ8eiKEO2Hf8g ")

data

data$?ּ??? <- enc2utf8(data$?ּ???)
data$?ּ??? <- as.character(data$?ּ???)
adata_1 <- mutate_geocode(data,?ּ???, source="google")