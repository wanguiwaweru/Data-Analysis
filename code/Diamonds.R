#install.packages("tidyverse")

#library(tidyverse)

?diamonds
View(diamonds)
glimpse(diamonds)
colnames(diamonds)

# Subset by row with filter()
cheaper_diamonds <- filter(diamonds,price > 10000)

ideal_diamonds <- filter(diamonds, cut=="Ideal")


ideal_and_cheaper_diamonds <- filter(diamonds,
                                 cut == "Ideal",
                                 price > 10000)

ideal_or_cheaper_diamonds <- filter(diamonds,
                                    cut == "Ideal" |
                                    price > 10000)


# Subset by column with select()
?select
diamonds_by_color_and_cut <- select(diamonds, color, cut)

select_columns <- select(diamonds, starts_with("c"))
select_columns <- select(diamonds, contains("c"))

select_columns_price_first <- select(diamonds,
                                     price,
                                     everything())

select_columns_without_price <- select(diamonds, -price)

select_columns_without_price_using_pipe <- diamonds %>% 
  select(-price)

# reorder rows with arrange()
sort_rows_by_color <- diamonds %>% arrange(color)
sort_rows_by_carats <- diamonds %>% arrange(carat)
sort_rows_by_color_and_carat <- diamonds %>% arrange(color,carat)

sort_rows_by_carats_descending <- diamonds %>% arrange(desc(carat))

# add or modify columns with mutate()

#

diamonds_new <- diamonds %>% 
  mutate(mass_g = .20 * carat)
glimpse(diamonds_new)

diamonds_new <- diamonds %>% 
  mutate(mass_g = .20 * carat,
         price_per_carat = price / carat)
glimpse(diamonds_new)

diamonds_new <- diamonds %>% 
  mutate(mass_g = .20 * carat,
         price_per_carat = price / carat,
         cut = tolower(cut))
glimpse(diamonds_new)

diamonds_new <- diamonds %>% 
  mutate(mass_g = .20 * carat,
         price_per_carat = price / carat,
         cut = tolower(cut),
         expensive_TF = price > 10000)
glimpse(diamonds_new)

# other smaller verbs -----------------------------------------------------

?slice_max
?bind_rows
?left_join
?rename
?case_when

# grouped summaries with group_by() and summarize() -----------------------

diamonds %>% 
  group_by(cut) %>% 
  summarize(mean(price))

diamonds %>% 
  group_by(cut) %>% 
  summarize(avg_price = mean(price),
            sd_price = sd(price))

diamonds %>% 
  group_by(cut,
           color) %>% 
  summarize(avg_price = mean(price),
            sd_price = sd(price),
            count = n())

diamonds %>% 
  count(cut,
        color) # counts only. 

diamonds %>% 
  group_by(price > 10000) %>% 
  summarize(avg_price = mean(price),
            sd_price = sd(price),
            count = n())  

diamonds %>% 
  group_by(expensive = price > 10000) %>% 
  summarize(avg_price = mean(price),
            sd_price = sd(price),
            count = n())  