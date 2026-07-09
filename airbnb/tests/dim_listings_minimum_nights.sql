SELECT
    *
FROM
    {{ ref('dim_listings_cleansed') }}
-- WHERE minimum_nights < 1
WHERE minimum_nights < 0
LIMIT 10