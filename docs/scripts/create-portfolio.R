### CREATE PORTFOLIO
### CREATE PORTFOLIO
### CREATE PORTFOLIO

# create portfolio positions as character list
positions_string <- c("BTC",
                      "ETH",
                      "XRP",
                      "ADA",
                      "HEX"
                      )

# create list of tickers for API call
position_tickers <- "BTC,ETH,XRP,ADA,HEX" # used in the API call

# define amounts of positions
amounts_string <- c(1.2, #BTC
                    4.5, #ETH
                    5000, #XRP
                    10000, #ADA
                    50000 #HEX
                    ) 


# create tibble of positions
positions <- tibble(id = positions_string, 
                    amount = amounts_string
                    ) 



### OBTAIN TICKER DATA
### OBTAIN TICKER DATA 
### OBTAIN TICKER DATA 

# create function to obtain data from an API endpoint and converts it into a usable format for R analysis
get_url <- function(full_url){
  fromJSON(content(GET(full_url), "text"))
}


# url components
base_url <- "https://api.nomics.com/v1/currencies/ticker"
tickers <- position_tickers
interval <- "1d,7d,30d,365d,ytd"

# create url
full_url <- paste0(base_url,
                   "?key=",Sys.getenv("nomics_demo_key"), #use your own API key instead of "Sys.getenv("nomics_api")
                   "&ids=",tickers,
                   "&interval=", interval,
                   "&convert=EUR")

# get ticker data, wrangle and manipulate data
ticker_data <- get_url(full_url) %>% 
  #mutate results
  mutate(rank = as.integer(rank),
         rank_delta = as.integer(rank_delta),
         price = as.numeric(price),
         price_date = as.Date(price_date),
         price_timestamp = as.Date(price_timestamp),
         num_pairs = as.integer(num_pairs),
         num_pairs_unmapped = as.integer(num_pairs_unmapped),
         num_exchanges = as.integer(num_exchanges),
         first_candle = as.Date(first_candle),
         first_trade = as.Date(first_trade),
         first_order_book = as.Date(first_order_book),
         #first_priced_at = as.Date(first_priced_at),
         #platform_currency = if_else(is.na(platform_currency) & rank <= 20, symbol, platform_currency), #for projects not based on ETH etc.
         circulating_supply = as.numeric(circulating_supply),
         max_supply = as.numeric(max_supply),
         market_cap = as.numeric(market_cap),
         market_cap_dominance = as.numeric(market_cap_dominance)*100,
         high = as.numeric(high),
         high_timestamp = as.Date(high_timestamp),
         price_pct_ath = as.numeric((price/high)*100),
         drop_pct_ath = as.numeric((1-(price/high))*100),
         days_ath = price_timestamp - high_timestamp
         )

# save the resulting ticker data as tibble
as_tibble(ticker_data) %>%
  # un-nest columns
  tidyr::unpack(cols=c(`1d`,`7d`,`30d`,`365d`,ytd), names_sep = "_") %>%
  # create/overwrite csv of cleaned data
  write_csv("data/pf-ticker-data.csv")


# authenticate with googlesheets
#gs4_auth("YOUR_EMAIL")

# write latest data to the "R" tab in personal portfolio tracker for further manipulation in GS
#googlesheets4::sheet_write(read.csv("data/pf-ticker-data-clean.csv"),"YOUR_GOOGLE_SHEET_URL", sheet = "R")

### MERGE PORTFOLIO WITH PRICE DATA
### MERGE PORTFOLIO WITH PRICE DATA
### MERGE PORTFOLIO WITH PRICE DATA

# merge the positions with the price data and make a final selection
pf_tracker <- merge(positions, 
                    read_csv("data/pf-ticker-data.csv"), 
                    by = "id") %>% 
  mutate(value = price*amount,
         share = value/sum(value)*100) %>% 
  select(logo_url,
         rank,
         rank_delta,
         name,
         id,
         price,
         amount,
         share,
         value,
         everything()
  )

#save as tibble
pf_tracker <- as_tibble(pf_tracker) %>% 
  mutate_at(vars(value, share), funs(round(., 3)))

pf_tracker %>% write_csv("data/pf-tracker.csv")



#total portfolio value
snapshot_today <- tibble(date_time = as.character(Sys.Date()), 
                         total_value = sum(pf_tracker$value)) 

#add daily snapshot to .csv 
snapshot_today %>% write_csv("data/pf_snapshot.csv", append = TRUE)

#print confimation
print("added row")
