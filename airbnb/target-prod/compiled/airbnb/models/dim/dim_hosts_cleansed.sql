
WITH  __dbt__cte__src_hosts as (
WITH raw_hosts AS (
    SELECT * FROM AIRBNB.raw.raw_hosts
)
SELECT 
    ID AS host_id,
    NAME AS host_name,
    IS_SUPERHOST,
    CREATED_AT,
    UPDATED_AT
FROM
    raw_hosts
), src_hosts AS (
    SELECT * FROM __dbt__cte__src_hosts
)
SELECT 
    HOST_ID,
    NVL(HOST_NAME,'Anonymous') AS HOST_NAME,
    IS_SUPERHOST,
    CREATED_AT,
    UPDATED_AT
FROM
    src_hosts