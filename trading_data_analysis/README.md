##Project description

This project used data obtained from AWS which includes 4 days' worth of tick data for 100 Scandinavian blue chip stocks. 

Download link: https://s3.eu-west-2.amazonaws.com/itarlepublic/scanditicks/scandi.csv.zip

The purpose of the project is to find out the following on a stock by stock basis: 

- Mean time between trades
- Median time between trades
- Mean time between tick changes
- Median time between tick changes
- Longest time between trades
- Longest time between tick changes
- Mean bid ask spread
- Median bid ask spread
- Examples of the round number effect - (both in traded values and traded volumes - i.e. is there an increased probability of the last digit on prices being a 0 compared to other last digits)

The CSV has the following fields / columns: 1 = Bloomberg Code/Stock identifier 3 = Bid Price 4 = Ask Price 5 = Trade Price 6 = Bid Volume 7 = Ask Volume 8 = Trade Volume 9 = Update type => 1=Trade; 2= Change to Bid (Px or Vol); 3=Change to Ask (Px or Vol) 11 = Date 12 = Time in seconds past midnight 13 = Opening price 15 = Condition codes

**Note**: This data is over several days and so when no trading occurs there are large time gaps to take into account so as not to skew the figures. So you need to exclude auctions from the analysis. There should be c. 2 auctions a day - morning and afternoon. During this period you will see crossed spreads (i.e. bid price is larger than ask price) along with specific condition codes. I should only include the XT condition code (along with no condition code).

The project is completed using *jupyter notebook*. 
