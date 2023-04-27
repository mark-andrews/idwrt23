library(tidyverse)

# Load up the data --------------------------------------------------------

blp_df <- read_csv("https://raw.githubusercontent.com/mark-andrews/idwrt23/main/data/blp-trials-short.txt")



# Summary statistics with summarize ---------------------------------------

summarise(blp_df, mean(rt, na.rm = TRUE))

blp_df %>% 
  drop_na() %>% 
  summarise(avg = mean(rt),
            med_rt_raw = median(rt.raw))


blp_df %>% 
  mutate(accuracy = lex == resp) %>%  
  drop_na() %>% 
  group_by(lex, accuracy) %>% 
  summarise(avg = mean(rt))

blp_df %>% 
  drop_na() %>% 
  group_by(lex) %>% 
  summarise(across(rt:rt.raw, median))

blp_df %>% 
  drop_na() %>% 
  group_by(lex) %>% 
  summarise(across(rt:rt.raw, list(median = median, mad = mad)))

blp_df %>% 
  drop_na() %>% 
  summarise(across(rt:rt.raw, list(median = median, mad = mad)))


# Merging data frames -----------------------------------------------------

bind_rows(Df_1, Df_2)
bind_rows(Df_2, Df_1)
bind_cols(Df_1, Df_3)

Df_a
Df_b

inner_join(Df_a, Df_b)
left_join(Df_a, Df_b)
right_join(Df_a, Df_b)
left_join(Df_b, Df_a)
full_join(Df_a, Df_b)

anti_join(Df_a, Df_b)
anti_join(Df_b, Df_a)

# let's get real
blp_stimuli <- read_csv("https://raw.githubusercontent.com/mark-andrews/idwrt23/main/data/blp_stimuli.csv")


left_join(blp_df, blp_stimuli)

filter(blp_stimuli, spell == 'staud')


right_join(blp_df, blp_stimuli)


inner_join(blp_df, blp_stimuli)

all.equal(inner_join(blp_df, blp_stimuli),
          left_join(blp_df, blp_stimuli))


Df_9 <- tibble(spell = c('cat', 'dog'),
               rt = c(100, 200))
Df_10 <- tibble(spell = c('cat', 'cat', 'dog'),
                old20 = c(5, 10, 20))

left_join(Df_9, Df_10)


Df_11 <- tibble(x = c(1, 2), y = c(42, 52))
Df_12 <- tibble(x = c('1', '2'), z = c('foo', 'bar'))

left_join(Df_11, Df_12)


Df_13 <- tibble(x = as.factor(c(1, 2)), y = c(42, 52))
Df_14 <- tibble(x = c('1', '2'), z = c('foo', 'bar'))

left_join(Df_13, Df_14)


inner_join(Df_4, Df_5)
inner_join(Df_4, rename(Df_5, x = a))
inner_join(Df_4, Df_5, by = c("x" = "a"))


# Reading in multiple files etc -------------------------------------------

library(fs)
dir_ls('exp_data') %>% map(read_csv) %>% bind_rows()
dir_ls('exp_data') %>% map_dfr(read_csv, .id = 'subject')


# Reshaping with pivots ---------------------------------------------------

recall_df <- read_csv("https://raw.githubusercontent.com/mark-andrews/idwrt23/main/data/repeated_measured_a.csv")

recall_df_long <- 
  pivot_longer(recall_df,
               -Subject,
               names_to = 'condition',
               values_to = 'memory')


pivot_wider(recall_df_long,
            names_from = condition,
            values_from = memory)

recall_df_b <- read_csv("https://raw.githubusercontent.com/mark-andrews/idwrt23/main/data/repeated_measured_b.csv")

# this pipeline 
pivot_longer(recall_df_b,
             -Subject,
             names_to = 'condition',
             values_to = 'memory') %>% 
  separate(col = condition, 
           into = c("cue", "emotion"),
           sep = '_')

# is equivalent to this one command
pivot_longer(recall_df_b,
             -Subject,
             names_to = c("cue", "emotion"),
             names_sep = '_',
             values_to = 'memory')

# and also it is equivalent to this 
pivot_longer(recall_df_b,
             -Subject,
             names_to = c("cue", "emotion"),
             names_pattern = "(.*)_(.*)",
             values_to = 'memory')


blp_df_summ <- 
  blp_df %>% 
  drop_na() %>%
  summarise(across(rt:rt.raw,
                   list(median = median, mad = mad)
  )
  )
      
# this pipeline ....
pivot_longer(blp_df_summ,
             everything(),
             names_to = 'summary',
             values_to = 'value') %>% 
  separate(summary, into = c("var", "descriptive"), sep = '_') %>% 
  pivot_wider(names_from = descriptive,
              values_from = value)


# is equivalent to this ....
pivot_longer(blp_df_summ,
             everything(),
             names_to = c("var", ".value"),
             names_sep = '_') 


# Nesting -----------------------------------------------------------------


tidy_df <- read_csv("https://raw.githubusercontent.com/mark-andrews/idwrt23/main/data/example_1_tidy.csv")

group_by(tidy_df, subject) %>% 
  summarise(accuracy = mean(accuracy))

group_by(tidy_df, subject) %>% 
  nest() %>% 
  mutate(number_of_rows = map_int(data, nrow)) %>% 
  select(-data)


# using `tidy_df` do a linear regression predicting `rt` from `delta`
# and return the slope coefficents (which is second value of coef)
coef(lm(rt ~ delta, data = tidy_df))[2]

# Now do that same thing for each subject in the data set
tidy_df %>% 
  group_by(subject) %>% 
  nest() %>% 
  mutate(slope = map_dbl(data, ~coef(lm(rt ~ delta, data = .))[2])) %>% 
  ungroup() %>% 
  select(-data)
