## SENTIMENT ANALYSIS ##

library(rtweet)
library(httpuv)
library(syuzhet)
library(ggplot2)


#cerchiamo tweet su un tema

Tesla <- search_tweets("#Tesla", n = 1500, lang = "en", include_rts = FALSE)

teslavalue <- get_nrc_sentiment(Tesla$text)

#controlliamo risultati

teslavalue[1:5, 1:7]


punteggio <- colSums(teslavalue[,])

#convertiamo punteggio in dataframe

punteggio_df <- data.frame(punteggio)

head(punteggio_df)


punteggioDEF <- cbind(sentiment = row.names(punteggio_df), punteggio_df, row.names = NULL)

punteggioDEF


#visualizziamo il punteggio

ggplot(punteggioDEF, aes(x = sentiment, y = punteggio, fill = sentiment)) +
  geom_bar(stat = "identity") + theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  theme(plot.title = element_text("Sentiment Analysis Tesla"), text = element_text(family = "serif")) +
  ggtitle("Sentimental Analysis Tesla")

##       EXTRA    ##
# scaricare il punteggio della sentiment analysis su file Excel

library(writexl)

write_xlsx(punteggioDEF, "Percorso_PC//nomefile.xlsx")
