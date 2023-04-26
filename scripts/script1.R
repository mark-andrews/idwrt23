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
