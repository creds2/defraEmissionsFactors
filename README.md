
<!-- README.md is generated from README.Rmd. Please edit that file -->

# defraEmissionsFactors

<!-- badges: start -->

<!-- badges: end -->

The goal of defraEmissionsFactors is to make emissions factors provided
by DEFRA more easily accessible and transparent.

## Emissions factors

The starting point is [Greenhouse gas reporting: conversion
factors 2018](https://www.gov.uk/government/publications/greenhouse-gas-reporting-conversion-factors-2018).
The following code chunk downloads and extracts relevant data, in this
case kg CO2 per km, for different car sizes:

``` r
source("code/defra-emissions.R")
knitr::kable(cars_size_co2, digits = 3)
```

| type        | co\_2\_petrol | co\_2\_diesel | co\_2\_hybrid | co\_2\_phev |
| :---------- | ------------: | ------------: | ------------: | ----------: |
| Small car   |         0.143 |         0.155 |         0.108 |       0.022 |
| Medium car  |         0.172 |         0.193 |         0.114 |       0.071 |
| Large car   |         0.213 |         0.283 |         0.160 |       0.077 |
| Average car |         0.176 |         0.183 |         0.124 |       0.071 |

This shows that cars typically emit around 180 g CO2/km, nearly double
the EU’s [2021
target](https://ec.europa.eu/clima/policies/transport/vehicles/cars_en)
of 95 g CO2/km. We can convert these into energy use values based on the
following conversion factors:

Burning diesel emits 73.6 gCO2/MJ
([source](https://enpos.weebly.com/uploads/3/6/7/2/3672459/co2_direct_combustion_jokiniemi.pdf)),
meaning that 1 KG of CO2 released from burning diesel is associated with
`1 / 0.0726` (13.6) MJ of energy use. This figure, and the associated
value of `0.0728` for petrol, means we can calculate energy use of
different types of cars as follows:

``` r
cars_energy = cars_size_co2 %>% 
  mutate(energy_diesel = co_2_diesel / 0.0726) %>% 
  mutate(energy_petrol = co_2_petrol / 0.0728) %>% 
  select(type, matches("energy"))
```

Crudely assuming an even petrol/diesel fuel mix, we can estimate the
average energy use per km driven as follows:

``` r
(cars_energy$energy_diesel[4] + cars_energy$energy_petrol[4]) / 2
#> [1] 2.466373
```

## Embodied energy of fuel

## Embodied energy of vehicles
