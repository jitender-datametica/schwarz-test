
CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_lead.v_fact_lidl_country_currency_2
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true) AS
SELECT lidl_country_cd,
 curr_cd,
 client_id,
 lidl_country_name
FROM ldl_p_lew_bil_ac.v_dim_lidl_country_2
UNION DISTINCT
SELECT lidl_country_cd,
 'EUR',
 client_id,
 lidl_country_name
FROM ldl_p_lew_bil_ac.v_dim_lidl_country_2
WHERE lidl_country_cd <> '@';

