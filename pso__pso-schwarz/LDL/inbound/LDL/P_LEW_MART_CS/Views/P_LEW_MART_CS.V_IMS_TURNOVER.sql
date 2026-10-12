/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_IMS_TURNOVER
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_CS.V_IMS_TURNOVER
(
      client_id
    , country_iso_cd
    , orig_store_nr
    , valid_from
    , valid_until
    , receipt_dt
    , customer_cnt
    , turnover_val
    , turnover_net_val
)
AS
   SELECT
   a.client_id,
   b.country_cd          AS country_iso_cd,
   a.orig_store_nr,
   a.dat_formdate        AS valid_from,
   DATE'9999-12-31'      AS valid_until,
   a.dat_formdate        AS receipt_dt,
   a.cnt_customer        AS customer_cnt,
   a.val_retail          AS turnover_val,
   a.val_retail_net      AS turnover_net_val
   FROM p_lew_bil_ac.v_agg_sales_store_day AS a
   INNER JOIN p_lew_core_ac.v_client AS b
   ON b.client_id = a.client_id
   WHERE a.cnt_customer IS NOT NULL
;