

library(retrosheet)
library(tidyverse)

## get game logs for Cardinals home games in 1998
foo = getRetrosheet("play", year =1998, team="SLN")
length(foo)
## play contains the game logs
names(foo[[1]])

## loop through teams and isolate McGwire plays
TEAMS = c("ANA", "ARI", "ATL", "BAL", "BOS", "CHA", "CHN", "CIN", 
          "CLE", "COL", "DET", "FLO", "HOU", "KCA", "LAN", "MIL", 
          "MIN", "MON", "NYA", "NYN", "OAK", "PHI", "PIT", "SDN", 
          "SEA", "SFN", "SLN", "TBA", "TEX", "TOR")
bar = do.call(rbind, lapply(TEAMS, function(tm){
  foo = getRetrosheet(type = "play", year = 1998, team = tm)
  do.call(rbind, lapply(foo, function(xx) as.data.frame(xx$play) %>% 
                          filter(retroID == "mcgwm001")))
}))

## isolate home run events
baz = bar[grep("HR", bar$play), ]
nrow(baz)

## get number of homeruns with runners on
length(grep("-H", baz$play))
