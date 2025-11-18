# UN Member States 2024 Dataset

This dataset contains information on 193 United Nations member states as
of 2024. It includes various attributes such as country names, ISO
codes, official state names, geographic and demographic data, economic
indicators, and participation in the Olympic Games. The data is designed
for use in statistical analysis, data visualization, and educational
purposes.

## Usage

``` r
un_member_states_2024
```

## Format

A data frame with 193 rows and 39 columns:

- country:

  `character`. Name of the country.

- iso:

  `character`. ISO 3166-1 alpha-3 country code. See:
  <https://en.wikipedia.org/wiki/ISO_3166-1_alpha-3>

- official_state_name:

  `character`. Official name of the country. See:
  <https://en.wikipedia.org/wiki/List_of_countries_and_dependencies_and_their_capitals_in_native_languages>

- continent:

  `factor`. Continent where the country is located. See:
  <https://en.wikipedia.org/wiki/Continent>

- region:

  `character`. Specific region within the continent.

- capital_city:

  `character`. Name of the capital city. See:
  <https://en.wikipedia.org/wiki/List_of_national_capitals_by_population>

- capital_population:

  `numeric`. Population of the capital city.

- capital_perc_of_country:

  `numeric`. Percentage of the country’s population living in the
  capital.

- capital_data_year:

  `integer`. Year the capital population data was collected.

- gdp_per_capita:

  `numeric`. GDP per capita in USD. See:
  <https://data.worldbank.org/indicator/NY.GDP.PCAP.CD>

- gdp_per_capita_year:

  `numeric`. Year the GDP per capita data was collected.

- summers_competed_in:

  `numeric`. Number of times the country has competed in the Summer
  Olympics

- summer_golds:

  `integer`. Number of gold medals won in the Summer Olympics.

- summer_silvers:

  `integer`. Number of silver medals won in the Summer Olympics.

- summer_bronzes:

  `integer`. Number of bronze medals won in the Summer Olympics.

- summer_total:

  `integer`. Total number of medals won in the Summer Olympics.

- winters_competed_in:

  `integer`. Number of times the country has competed in the Winter
  Olympics

- winter_golds:

  `integer`. Number of gold medals won in the Winter Olympics.

- winter_silvers:

  `integer`. Number of silver medals won in the Winter Olympics.

- winter_bronzes:

  `integer`. Number of bronze medals won in the Winter Olympics.

- winter_total:

  `integer`. Total number of medals won in the Winter Olympics.

- combined_competed_ins:

  `integer`. Total number of times the country has competed in both
  Summer and Winter Olympics. See:
  <https://en.wikipedia.org/wiki/All-time_Olympic_Games_medal_table>

- combined_golds:

  `integer`. Total number of gold medals won in both Summer and Winter
  Olympics.

- combined_silvers:

  `integer`. Total number of silver medals won in both Summer and Winter
  Olympics.

- combined_bronzes:

  `integer`. Total number of bronze medals won in both Summer and Winter
  Olympics.

- combined_total:

  `integer`. Total number of medals won in both Summer and Winter
  Olympics.

- driving_side:

  `character`. Indicates whether the country drives on the left or right
  side of the road. See:
  <https://en.wikipedia.org/wiki/Left-_and_right-hand_traffic>

- obesity_rate_2024:

  `numeric`. Percentage of the population classified as obese in 2024.
  See: <https://en.wikipedia.org/wiki/List_of_countries_by_obesity_rate>

- obesity_rate_2016:

  `numeric`. Percentage of the population classified as obese in 2016.

- has_nuclear_weapons_2024:

  `logical`. Indicates whether the country has nuclear weapons as
  of 2024. See:
  <https://en.wikipedia.org/wiki/List_of_states_with_nuclear_weapons>

- population_2024:

  `numeric`. Population of the country in 2024. See:
  <https://data.worldbank.org/indicator/SP.POP.TOTL>

- area_in_square_km:

  `numeric`. Area of the country in square kilometers. See:
  <https://en.wikipedia.org/wiki/List_of_countries_and_dependencies_by_area>

- area_in_square_miles:

  `numeric`. Area of the country in square miles.

- population_density_in_square_km:

  `numeric`. Population density in square kilometers.

- population_density_in_square_miles:

  `numeric`. Population density in square miles.

- income_group_2024:

  `factor`. World Bank income group classification in 2024. See:
  <https://data.worldbank.org/indicator/NY.GNP.PCAP.CD>

- life_expectancy_2022:

  `numeric`. Life expectancy at birth in 2022. See:
  <https://en.wikipedia.org/wiki/List_of_countries_by_life_expectancy>

- fertility_rate_2022:

  `numeric`. Fertility rate in 2022 (average number of children per
  woman). See:
  <https://en.wikipedia.org/wiki/List_of_countries_by_total_fertility_rate>

- hdi_2022:

  `numeric`. Human Development Index in 2022. See:
  <https://en.wikipedia.org/wiki/List_of_countries_by_Human_Development_Index>

## Examples

``` r
data(un_member_states_2024)
head(un_member_states_2024)
#> # A tibble: 6 × 39
#>   country             iso   official_state_name    continent region capital_city
#>   <chr>               <chr> <chr>                  <fct>     <chr>  <chr>       
#> 1 Afghanistan         AFG   The Islamic Republic … Asia      South… Kabul       
#> 2 Albania             ALB   The Republic of Alban… Europe    South… Tirana      
#> 3 Algeria             DZA   The People's Democrat… Africa    North… Algiers     
#> 4 Andorra             AND   The Principality of A… Europe    South… Andorra la …
#> 5 Angola              AGO   The Republic of Angola Africa    Centr… Luanda      
#> 6 Antigua and Barbuda ATG   Antigua and Barbuda    North Am… Carib… St. John's  
#> # ℹ 33 more variables: capital_population <dbl>, capital_perc_of_country <dbl>,
#> #   capital_data_year <int>, gdp_per_capita <dbl>, gdp_per_capita_year <dbl>,
#> #   summers_competed_in <dbl>, summer_golds <int>, summer_silvers <int>,
#> #   summer_bronzes <int>, summer_total <int>, winters_competed_in <int>,
#> #   winter_golds <int>, winter_silvers <int>, winter_bronzes <int>,
#> #   winter_total <int>, combined_competed_ins <int>, combined_golds <int>,
#> #   combined_silvers <int>, combined_bronzes <int>, combined_total <int>, …
```
