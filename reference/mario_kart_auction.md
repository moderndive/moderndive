# Data from Mario Kart Ebay auctions

Ebay auction data for the Nintendo Wii game Mario Kart.

## Usage

``` r
mario_kart_auction
```

## Format

A data frame of 143 auctions.

- id:

  Auction ID assigned by Ebay

- duration:

  Auction length in days

- n_bids:

  Number of bids

- cond:

  Game condition, either `new` or `used`

- start_pr:

  Price at the start of the auction

- ship_pr:

  Shipping price

- total_pr:

  Total price, equal to auction price plus shipping price

- ship_sp:

  Shipping speed or method

- seller_rate:

  Seller's rating on Ebay, equal to the number of positive ratings minus
  the number of negative ratings

- stock_photo:

  Whether the auction photo was a stock photo or not, pictures used in
  many options were considered stock photos

- wheels:

  Number of Wii wheels included in the auction

- title:

  The title of the auctions

## Source

This data is from
<https://www.openintro.org/data/index.php?data=mariokart>
