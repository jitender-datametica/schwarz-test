/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.v_gen_vat_hist
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_gen_vat_hist AS SELECT client_id,
 vat_id,
 CAST(pct_vat AS NUMERIC) AS pct_vat,
 vat_desc,
 dat_rec_start,
 dat_rec_end,
 7 AS language_id,
 CAST('1900-01-01 00:00:00' AS DATETIME) AS dwh_updated,
 CAST('1900-01-01 00:00:00' AS DATETIME) AS dwh_created,
 CAST(- 1 AS BIGNUMERIC) AS dwh_load_id,
 load_id,
 1 AS src_id
FROM ldl_p_lew_core_ac.v_wawi_ref_wawi_vat_values AS T1
UNION DISTINCT
SELECT T2.client_id,
 T2.vat_id,
 T2.pct_vat,
 T2.vat_desc,
 T2.dat_rec_start,
 T2.dat_rec_end,
 T2.language_id,
 CAST('1900-01-01 00:00:00' AS DATETIME) AS dwh_updated,
 CAST('1900-01-01 00:00:00' AS DATETIME) AS dwh_created,
 CAST(- 1 AS BIGNUMERIC) AS dwh_load_id,
 T2.load_id,
 1 AS src_id
FROM ldl_p_lew_core_ac.v_wawi_ref_vat AS T2
 LEFT JOIN (SELECT client_id
  FROM ldl_p_lew_core_ac.v_wawi_ref_wawi_vat_values AS TCK1
  WHERE vat_id > 0
  GROUP BY client_id) AS tck2 ON T2.client_id = tck2.client_id
WHERE T2.client_id = T2.language_id
 AND tck2.client_id IS NULL;