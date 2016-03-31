##Blog data
##
blog_con <- file("final/en_US/en_US.blogs.txt", "r")
blog_sample <- readLines(blog_con)
#sample2 <- scan("final/en_US/en_US.blogs.txt", what=character(), nlines=10)
close(blog_con)

number_of_characters <- sapply(blog_sample, nchar)



##Twitter data
##
twitter_con <- file("final/en_US/en_US.twitter.txt", "r")
twitter_sample <- readLines(twitter_con)
close(twitter_con)

love <- sum(grepl("love", twitter_sample))
hate <- sum(grepl("hate", twitter_sample))

grep("biostats", twitter_sample, value=TRUE)

grep("A computer once beat me at chess, but it was no match for me at kickboxing",
     twitter_sample)





##News data
##
news_con <- file("final/en_US/en_US.news.txt", "r")
news_sample <- readLines(news_con)
close(news_con)
