{{
  config(
    materialized = 'ephemeral',
    )
}}
WITH raw_comments AS (
    SELECT * FROM {{source('airstats', 'comments')}}
)
SELECT 
    id AS comment_id,
    airport_ident AS airport_ident,
    CAST(date as TIMESTAMP) AS comment_timestamp,
    member_nickname,
    subject AS comment_subject,
    body AS comment_body
FROM
    raw_comments