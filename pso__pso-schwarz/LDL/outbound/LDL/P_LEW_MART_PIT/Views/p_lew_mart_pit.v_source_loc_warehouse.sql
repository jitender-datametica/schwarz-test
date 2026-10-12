/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : View for V_SOURCE_LOC_WAREHOUSE
#-------------------------------------------------------------------------------
# Describtion: Create View for V_SOURCE_LOC_WAREHOUSE
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2022-02-10 Nikolai Toknov	    Initial version
#  1.1  2023-06-27 Andreas Kurz			Improved Version, specail Formatting for DE (23)
#       								Aligned with APT Warehouse Name Logic
#										WAREHOUSE_NAME_SDESCR
#-------------------------------------------------------------------------------
*/

-- USE DATABASE LDL_PRODUCTION_CLONE_PIT_QS;
-- USE DATABASE LDL_PRODUCTION_CLONE_PIT_R51503;

/* 
---------------------------------------------------------------------
0. Create View Table in V_SOURCE_LOC_WAREHOUSE
------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_pit.v_source_loc_warehouse OPTIONS(DESCRIPTION = `SOURCE VIEW WAREHIOUSE`) AS
SELECT CAST(loc.client_id AS BIGNUMERIC) AS client_id,
 loc.loc_sid AS warehouse_sid,
 COALESCE(loc.loc_name, 'N/A') AS warehouse_name_descr,
 IF(loc.client_id = 23, IF(REGEXP_CONTAINS(SAFE_CAST(loc.loc_name as STRING), r'^(?:^\d{3}[a-zA-Z]{3}.*)$') AND LENGTH(loc
      .loc_name) = 6, SUBSTR(UPPER(loc.loc_name), 4, 3), SUBSTR(UPPER(loc.loc_name), 1, 3)), COALESCE(loc.loc_name,
   'N/A')) AS warehouse_name_sdescr,
 IF(loc.client_id = 23, IF(REGEXP_CONTAINS(SAFE_CAST(loc.loc_name as STRING), r'^(?:^\d{3}[a-zA-Z]{3}.*)$') AND LENGTH(loc
      .loc_name) = 6, SUBSTR(UPPER(loc.loc_name), 4, 3), SUBSTR(UPPER(loc.loc_name), 1, 3)), COALESCE(loc.loc_name,
   'N/A')) AS warehouse_name,
 CAST(loc.src_orig_wh_nr AS BIGNUMERIC) AS orig_warehouse_nr,
 TO_HEX(MD5(COALESCE(CAST(IF(loc.client_id = 23, IF(REGEXP_CONTAINS(SAFE_CAST(loc.loc_name as STRING), r'^(?:^\d{3}[a-zA-Z]{3}.*)$') AND LENGTH(loc.loc_name) = 6, SUBSTR(UPPER(loc.loc_name), 4, 3), SUBSTR(UPPER(loc.loc_name), 1, 3)), COALESCE(loc.loc_name, 'N/A')) AS STRING)
    , ''))) AS scd_key_md,
 COALESCE(t7.dwh_valid_from, PARSE_DATE('%F', '1900-01-01')) AS valid_from_dt,
 COALESCE(t7.dwh_valid_to, PARSE_DATE('%F', '9999-12-31')) AS valid_to_dt,
 COALESCE(CAST(t7.deleted_fg AS BIGNUMERIC), 0) AS deleted_fg,
 t7.dwh_updated AS dwh_updated_ts
FROM (SELECT client_id,
   loc_sid,
   src_orig_wh_nr,
   loc_name,
   wh_name,
   wh_add1_name,
   wh_txt,
   loc_status_cd,
   country_pol_sid,
   country_pol_cd,
   wh_store_mark
  FROM ldl_p_lew_core.t_location
  WHERE UPPER(wh_store_mark) = 'B'
   AND (src_orig_wh_nr > 0 AND src_orig_wh_nr < 999 OR src_orig_wh_nr > 999)
   AND client_id IN (SELECT client_id
     FROM ldl_p_lew_mart_pit.t_dim_client
     WHERE pit_country_fg = 1
      AND deleted_fg = 0
      AND reject_fg = 0
      AND current_fg = 1
     GROUP BY client_id)
   AND country_pol_sid IS NOT NULL
   AND country_pol_cd IS NOT NULL
   AND loc_name IS NOT NULL
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(loc_sid AS STRING) ORDER BY dwh_updated IS NULL DESC, dwh_updated DESC)
     ) = 1) AS loc
 INNER JOIN (SELECT client_id,
   loc_sid,
   deleted_fg,
   dwh_valid_from,
   dwh_valid_to,
   dwh_updated
  FROM ldl_p_lew_core.t_location_hist
  WHERE deleted_fg = 0
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(loc_sid AS STRING), dwh_valid_from ORDER BY dwh_updated IS NULL DESC,
        dwh_updated DESC)) = 1) AS t7 ON loc.loc_sid = t7.loc_sid AND loc.client_id = t7.client_id;