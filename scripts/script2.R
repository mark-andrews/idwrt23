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
