library(tm)
library(stringr)

blogs <- VCorpus(DirSource("training1", encoding = "UTF-8"),
                readerControl=list(language="en"))
usableText <- str_replace_all(blogs[[1]]$content,"[^[:graph:]]", " ") 
write(usableText, "training2/blogs.txt")
rm(blogs)
rm(usableText)
