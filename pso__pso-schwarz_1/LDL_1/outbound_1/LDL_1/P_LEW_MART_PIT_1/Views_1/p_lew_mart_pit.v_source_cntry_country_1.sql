/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : View for V_SOURCE_CNTRY_COUNTRY_1
#-------------------------------------------------------------------------------
# Describtion: Create View for V_SOURCE_CNTRY_COUNTRY_1
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-08-16 Massimo Morelli	   Initial version
#  1.1  2021-09-29 Dirk Hering         Use example role added, data types added, column order, formatting
#  1.2  2021-10-11 Dirk Hering         Deduplication from source (Qualify Row Number = 1) descending; ctr.DWH_UPDATED 
#-------------------------------------------------------------------------------
*/

/*
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R51501;
USE SCHEMA 		P_LEW_MART_PIT_1;
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_pit.v_source_cntry_country_1
OPTIONS(DESCRIPTION = `PIT SOURCE VIEW FOR LIDL COUNTRIES`) AS SELECT CAST(t1.country_sid AS BIGNUMERIC) AS client_id,
 CAST(t1.country_name AS STRING) AS country_descr,
 CAST(t1.lang_sid AS BIGNUMERIC) AS lang_sid,
 CAST(t1.src_country_lidl_cd AS STRING) AS country_iso_cd,
 COALESCE(cur.curr_sid, - 2) AS curr_sid,
 CAST(COALESCE(cur.curr_cd, 'n/A') AS STRING) AS curr_cd,
 cur.x_rate_type_sid,
 CAST(COALESCE(cur.exchange_rate_to_eur, 1.0) AS BIGNUMERIC) AS exchange_rate_to_eur,
 DATE(COALESCE(clm.migration_dat_valid_from, DATE('8888-12-31'))) AS ctr_ex_elvis_country_migration_date_from,
 DATE(COALESCE(clm.migration_dat_valid_to, DATE('8888-12-31'))) AS ctr_ex_elvis_country_migration_date_to,
 IF(clm.client_id IS NOT NULL, 1, 0) AS ctr_ex_elvis_country_fg,
 DATE(COALESCE(DATE(t1.dwh_created), DATE('1900-01-01'))) AS valid_from_dt,
 PARSE_DATE('%F', '9999-12-31') AS valid_to_dt,
 0 AS deleted_fg,
 t1.dwh_updated AS dwh_updated_ts
FROM (SELECT country_sid,
   country_name,
   lang_sid,
   src_country_lidl_cd,
   dwh_created,
   dwh_updated
  FROM ldl_p_lew_core.t_country_1
  WHERE country_sid > 0
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(country_sid AS STRING) ORDER BY dwh_updated IS NULL DESC, dwh_updated
        DESC)) = 1) AS t1_1
 LEFT JOIN (SELECT loc_cur.client_id,
   loc_cur.curr_sid,
   loc_cur.curr_cd,
   loc_cur.x_rate_type_sid,
   t8.exchange_rate_to_eur,
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
          , active_from_dt ORDER BY dwh_updated IS NULL DESC, dwh_updated DESC)) = 1) AS t8 ON loc_cur.client_id = t8.client_id
         AND loc_cur.curr_sid = t8.curr_sid AND loc_cur.x_rate_type_sid = t8.x_rate_type_sid AND loc_cur.active_from_dt
      <= t8.active_from_dt AND loc_cur.active_to_dt >= t8.active_to_dt
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(loc_cur.client_id AS STRING), CAST(loc_cur.curr_sid AS STRING) ORDER BY
        loc_cur.active_from_dt IS NULL DESC, loc_cur.active_from_dt DESC)) = 1) AS cur ON t1.country_sid = cur.client_id
  
 LEFT JOIN (SELECT client_id,
   migration_dat_valid_from,
   migration_dat_valid_to
  FROM ldl_p_lew_core.t_client_migration_per_1
  WHERE migration_dat_valid_from <> DATE('9999-12-31')
   AND active_fg = 0) AS clm ON t1.country_sid = clm.client_id AND CURRENT_DATE BETWEEN cur.valid_from_dt AND cur.valid_to_dt;