/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.v_mat_apt_vat_rates_1
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#  1.1  05.06.2025    Ross, Ulrich                 Deliver also VAT_ID 0
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_mat_apt_vat_rates_1 (client_id, country_iso_cd, vat_id, pct_vat, dat_rec_start
, dat_rec_end, dwh_updated, dwh_created, dwh_load_id, load_id, src_id) AS SELECT V.client_id,
 T.src_country_lidl_cd AS country_iso_cd,
 V.vat_id,
 V.pct_vat,
 V.dat_rec_start,
 V.dat_rec_end,
 V.dwh_updated,
 V.dwh_created,
 V.dwh_load_id,
 V.load_id,
 V.src_id
FROM ldl_p_lew_mart_cs.v_gen_vat_hist_1 AS V
 INNER JOIN ldl_p_lew_core_ac.v_client_1 AS C ON V.client_id = C.client_id
 INNER JOIN ldl_p_lew_core_ac.v_country_1 AS T ON C.country_sid = T.country_sid
WHERE V.vat_id >= 0
 AND V.pct_vat IS NOT NULL;