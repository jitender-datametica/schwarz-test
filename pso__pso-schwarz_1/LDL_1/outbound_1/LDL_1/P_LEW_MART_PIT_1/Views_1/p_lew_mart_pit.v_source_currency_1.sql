/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : View for v_source_sfo_store_form
#-------------------------------------------------------------------------------
# Describtion: Create View for v_source_currency_1
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2024-01-05 Andreas Kurz		   	Initial version 
#-------------------------------------------------------------------------------
*/

/*
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R51501;
USE SCHEMA 		P_LEW_MART_PIT_1;
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_pit.v_source_currency_1 OPTIONS(DESCRIPTION = `SOURCE VIEW FOR CURRENCY`) AS SELECT
 loc_cur.client_id,
 cl.country_iso_cd,
 cl.lang_sid,
 loc_cur.curr_sid,
 loc_cur.curr_cd,
 t5.x_rate_type_sid,
 t5.exchange_rate_to_eur,
 loc_cur.active_from_dt AS valid_from_dt,
 loc_cur.active_to_dt AS valid_to_dt
FROM (SELECT client_id,
   curr_sid_from AS curr_sid,
   curr_cd_from AS curr_cd,
   x_rate_type_sid,
   active_from_dt,
   active_to_dt
  FROM ldl_p_lew_core.t_exchange_rate_known_hist_1
  WHERE deleted_fg = 0
   AND curr_sid_from = curr_sid_to
   AND active_to_dt > DATE('2019-01-01')
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(client_id AS STRING), CAST(curr_sid_from AS STRING), CAST(x_rate_type_sid AS STRING)
        , active_from_dt ORDER BY dwh_updated IS NULL DESC, dwh_updated DESC)) = 1) AS loc_cur
 INNER JOIN (SELECT client_id,
   x_rate_type_sid,
   exchange_rate AS exchange_rate_to_eur,
   curr_sid_from AS curr_sid,
   active_from_dt,
   active_to_dt,
   curr_cd_to,
   dwh_updated
  FROM ldl_p_lew_core.t_exchange_rate_known_hist_1
  WHERE deleted_fg = 0
   AND curr_cd_to = 'EUR'
   AND active_to_dt > DATE('2019-01-01')
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(client_id AS STRING), CAST(curr_sid_from AS STRING), CAST(x_rate_type_sid AS STRING)
        , active_from_dt ORDER BY dwh_updated IS NULL DESC, dwh_updated DESC)) = 1) AS t5 ON loc_cur.client_id = t5.client_id
       AND loc_cur.curr_sid = t5.curr_sid AND loc_cur.x_rate_type_sid = t5.x_rate_type_sid AND loc_cur.active_from_dt <=
    t5.active_from_dt AND loc_cur.active_to_dt >= t5.active_to_dt
 INNER JOIN (SELECT DISTINCT client_id,
   country_orig_descr,
   country_int_descr,
   country_nat_descr,
   country_descr,
   country_iso_cd,
   lang_sid,
   curr_sid,
   curr_cd,
   exchange_rate_to_eur,
   valid_from_dt,
   ctr_ex_elvis_country_fg,
   ctr_ex_elvis_country_migration_date_from,
   ctr_ex_elvis_country_migration_date_to,
   ctr_adv_week_start_weekday_id
  FROM ldl_p_lew_mart_pit.t_dim_client_1
  WHERE pit_country_fg = 1
   AND deleted_fg = 0
   AND reject_fg = 0
   AND current_fg = 1) AS cl ON t5.client_id = cl.client_id
QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(loc_cur.client_id AS STRING), CAST(loc_cur.curr_sid AS STRING) ORDER BY
      loc_cur.active_from_dt IS NULL DESC, loc_cur.active_from_dt DESC)) = 1;