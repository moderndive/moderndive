# Coffee Quality Dataset

This dataset contains detailed information about coffee quality
evaluations from various origins. It includes data on the country and
continent of origin, farm name, lot number, and various quality metrics.
The dataset also includes attributes related to coffee processing,
grading, and specific sensory attributes.

## Usage

``` r
coffee_quality
```

## Format

A data frame with 207 rows and 30 variables:

- country_of_origin:

  `character`. The country where the coffee originated.

- continent_of_origin:

  `character`. The continent where the coffee originated.

- farm_name:

  `character`. The name of the farm where the coffee was grown.

- lot_number:

  `character`. The lot number assigned to the batch of coffee.

- mill:

  `character`. The name of the mill where the coffee was processed.

- company:

  `character`. The company associated with the coffee batch.

- altitude:

  `character`. The altitude range (in meters) where the coffee was
  grown.

- region:

  `character`. The specific region within the country where the coffee
  was grown.

- producer:

  `character`. The name of the coffee producer.

- in_country_partner:

  `character`. The in-country partner organization associated with the
  coffee batch.

- harvest_year:

  `character`. The year or range of years during which the coffee was
  harvested.

- grading_date:

  `date`. The date when the coffee was graded.

- owner:

  `character`. The owner of the coffee batch.

- variety:

  `character`. The variety of the coffee plant.

- processing_method:

  `character`. The method used to process the coffee beans.

- aroma:

  `numeric`. The aroma score of the coffee, on a scale from 0 to 10.

- flavor:

  `numeric`. The flavor score of the coffee, on a scale from 0 to 10.

- aftertaste:

  `numeric`. The aftertaste score of the coffee, on a scale from 0 to
  10.

- acidity:

  `numeric`. The acidity score of the coffee, on a scale from 0 to 10.

- body:

  `numeric`. The body score of the coffee, on a scale from 0 to 10.

- balance:

  `numeric`. The balance score of the coffee, on a scale from 0 to 10.

- uniformity:

  `numeric`. The uniformity score of the coffee, on a scale from 0 to
  10.

- clean_cup:

  `numeric`. The clean cup score of the coffee, on a scale from 0 to 10.

- sweetness:

  `numeric`. The sweetness score of the coffee, on a scale from 0 to 10.

- overall:

  `numeric`. The overall score of the coffee, on a scale from 0 to 10.

- total_cup_points:

  `numeric`. The total cup points awarded to the coffee, representing
  the sum of various quality metrics.

- moisture_percentage:

  `numeric`. The moisture percentage of the coffee beans.

- color:

  `character`. The color description of the coffee beans.

- expiration:

  `character`. The expiration date of the coffee batch.

- certification_body:

  `character`. The body that certified the coffee batch.

## Source

Coffee Quality Institute
