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
