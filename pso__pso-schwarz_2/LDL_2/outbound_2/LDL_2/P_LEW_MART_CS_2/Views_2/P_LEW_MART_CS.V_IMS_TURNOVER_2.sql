/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_IMS_TURNOVER_2
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_ims_turnover_2 (client_id, country_iso_cd, orig_store_nr, valid_from,
valid_until, receipt_dt, customer_cnt, turnover_val, turnover_net_val) AS SELECT A.client_id,
 B.country_cd AS country_iso_cd,
 A.orig_store_nr,
 A.dat_formdate AS valid_from,
 DATE '9999-12-31' AS valid_until,
 A.dat_formdate AS receipt_dt,
 A.cnt_customer AS customer_cnt,
 A.val_retail AS turnover_val,
 A.val_retail_net AS turnover_net_val
FROM ldl_p_lew_bil_ac.v_agg_sales_store_day_2 AS A
 INNER JOIN ldl_p_lew_core_ac.v_client_2 AS B ON A.client_id = B.client_id
WHERE A.cnt_customer IS NOT NULL;