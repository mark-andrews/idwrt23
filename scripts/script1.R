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


# Reordering columns with relocate ----------------------------------------

relocate(blp_df, rt)
relocate(blp_df, starts_with('r'))

relocate(blp_df, rt, .after = lex)
relocate(blp_df, rt, .before = lex)

relocate(blp_df, rt, .after = rt.raw)
relocate(blp_df, rt, .after = last_col())
relocate(blp_df, rt, .before = last_col())

relocate(blp_df, where(is.numeric))

relocate(blp_df, where(is.numeric), .after = last_col())



# Renaming with rename ----------------------------------------------------

select(blp_df, reaction_time = rt)
select(blp_df, reaction_time = rt, everything())

rename(blp_df, reaction_time = rt)

rename(blp_df, reaction_time = rt, lexical = lex)

rename_with(blp_df, toupper)
rename_with(blp_df, tolower)

# rename all numeric variables to uppercase
rename_with(.data = blp_df, .fn = toupper, .cols = where(is.numeric))

# let's look at `str_replace`
y <- c('hello', 'world')
str_replace(y, 'he', 'xx')

# ~str_replace(., 'rt', 'reaction_time')

rename_with(.data = blp_df, 
            .fn = ~str_replace(., 'rt', 'reaction_time'),
            .cols = matches('^rt|rt$'))

rename_with(.fn = ~str_replace(., 'rt', 'reaction_time'),
            .data = blp_df,
            .cols = matches('^rt|rt$'))


# Slicing with slice ------------------------------------------------------

slice(blp_df, 5)

slice(blp_df, 5:15)

slice(blp_df, c(10, 20, 50, 100, 500, 800))

slice(blp_df, seq(10, 1000, by = 10))

slice(blp_df, -10)

slice(blp_df, -(1:3))

slice(blp_df, 990:1000)
slice(blp_df, 990:n())
slice(blp_df, (n()-10):n())


# Filtering with filter ---------------------------------------------------

filter(blp_df, participant == 20)

filter(blp_df, lex == 'W', resp == 'W')
filter(blp_df, rt < 500)
filter(blp_df, rt <= 500)

# the following 
filter(blp_df, lex == 'W', resp == 'W', rt <= 500)
# is equivalent to this:
filter(blp_df, (lex == 'W') & (resp == 'W') & (rt <= 500))

# disjunction of conditions
filter(blp_df, lex == 'W' | rt <= 500)

filter(blp_df, (lex == 'W') & (resp == 'W') | (rt <= 500))
filter(blp_df, (lex == 'W') & (resp == 'W') | !(rt <= 500))

# filter where their response correct
filter(blp_df, lex == resp)

filter()
