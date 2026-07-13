{{
  config(
    materialized = 'ephemeral',
    )
}}
WITH raw_airports AS (
    SELECT * FROM {{source('airstats', 'airports')}}
)
SELECT 
    ident AS airport_ident,
    type AS airport_type,
    name AS airport_name,
    latitude_deg AS airport_lat,
    longitude_deg AS airport_long,
    continent AS continent,
    iso_country AS iso_country,
    iso_region AS iso_region
FROM
    raw_airports