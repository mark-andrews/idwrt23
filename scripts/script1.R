library(tidyverse)


# Load up the data --------------------------------------------------------

blp_df <- read_csv("https://raw.githubusercontent.com/mark-andrews/idwrt23/main/data/blp-trials-short.txt")

# look at the data frame
blp_df

# look at the first 50 rows of the data frame
print(blp_df, n = 50)

# look at ALL rows
print(blp_df, n = Inf)

# glimpsing
glimpse(blp_df)


# look at the data as a base R data frame
blp_df_base <- read.csv("https://raw.githubusercontent.com/mark-andrews/idwrt23/main/data/blp-trials-short.txt")


# The dplyr verbs ---------------------------------------------------------

# select
# relocate
# rename
# slice
# filter 
# mutate 
# transmute
# arrange

# Selecting columns with select -------------------------------------------

select(blp_df, participant, lex, resp, rt)

# save the returned data frame as blp_df2
blp_df2 <- select(blp_df, participant, lex, resp, rt)
# overwrite the original data frame
#blp_df <- select(blp_df, participant, lex, resp, rt)

select(blp_df, participant, lex, resp, reaction_time = rt)

select(blp_df, 1, 2, 7)

# instead of this 
select(blp_df, lex, spell, resp, rt)
# do this
select(blp_df, lex:rt)

select(blp_df, 2:5)

select(blp_df, participant:resp, rt.raw)

select(blp_df, 2:4, rt.raw)

select(blp_df, starts_with('r'))

select(blp_df, starts_with('rt'))

select(blp_df, ends_with('t'))

select(blp_df, contains('rt'))

select(blp_df, matches('^rt')) # equivalent to starts_with
select(blp_df, matches('rt$')) # equivalent to ends_with
select(blp_df, matches('^rt|rt$'))

# all but `participant`
select(blp_df, -participant)
select(blp_df, -participant, -rt)
select(blp_df, -c(participant, rt))

select(blp_df, lex:rt)
select(blp_df, -(lex:rt))

select(blp_df, -(2:5))

# select the numeric variables
select(blp_df, where(is.numeric))
select(blp_df, -where(is.numeric))

has_high_mean <- function(x) {
  is.numeric(x) && mean(x, na.rm = TRUE) > 500
}

select(blp_df, where(has_high_mean))

# has_high_mean(participant)
# has_high_mean(lex)

# anonymous function
select(blp_df, where(function(x) {
  is.numeric(x) && mean(x, na.rm = TRUE) > 500
}))

# purrr style lambda anonymous function
select(blp_df, where(~{
  is.numeric(.) && mean(., na.rm = TRUE) > 500
}))

# ~ <=> function(.)

# select "everything"
select(blp_df, everything())

select(blp_df, rt, everything())
