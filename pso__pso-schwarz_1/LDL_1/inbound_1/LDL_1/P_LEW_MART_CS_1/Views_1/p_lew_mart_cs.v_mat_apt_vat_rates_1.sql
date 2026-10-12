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
CREATE OR REPLACE VIEW p_lew_mart_cs.v_mat_apt_vat_rates_1
(
client_id
, country_iso_cd
, vat_id
, pct_vat
, dat_rec_start
, dat_rec_end
, dwh_updated
, dwh_created
, dwh_load_id
, load_id
, src_id
)
AS
   SELECT
    v.client_id
   ,t.src_country_lidl_cd AS country_iso_cd
   ,v.vat_id
   ,v.pct_vat
   ,v.dat_rec_start
   ,v.dat_rec_end
   ,v.dwh_updated
   ,v.dwh_created
   ,v.dwh_load_id
   ,v.load_id
   ,v.src_id
   FROM p_lew_mart_cs.v_gen_vat_hist_1 v
   INNER JOIN p_lew_core_ac.v_client_1 c
   ON v.client_id = c.client_id
   INNER JOIN p_lew_core_ac.v_country_1 t
   ON c.country_sid = t.country_sid

   WHERE v.vat_id >= 0
   AND v.pct_vat IS NOT NULL
   ;


