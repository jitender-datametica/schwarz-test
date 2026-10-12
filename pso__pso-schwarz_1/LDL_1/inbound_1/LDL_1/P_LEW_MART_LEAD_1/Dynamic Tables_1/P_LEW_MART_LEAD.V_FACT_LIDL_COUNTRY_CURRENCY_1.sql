CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_LEAD.V_FACT_LIDL_COUNTRY_CURRENCY_1

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_LEAD

AS
   SELECT
        lidl_country_cd,
   curr_cd,
   client_id,
   lidl_country_name
   FROM p_lew_bil_ac.v_dim_lidl_country_1
   UNION
   SELECT
        lidl_country_cd,
   'EUR',
   client_id,
   lidl_country_name
   FROM p_lew_bil_ac.v_dim_lidl_country_1
   WHERE lidl_country_cd <> '@';
