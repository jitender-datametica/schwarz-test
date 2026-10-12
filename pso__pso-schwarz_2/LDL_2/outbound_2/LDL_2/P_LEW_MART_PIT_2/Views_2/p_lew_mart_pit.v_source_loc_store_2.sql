/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : View for V_SOURCE_LOC_STORE_2
#-------------------------------------------------------------------------------
# Describtion: Create View for V_SOURCE_LOC_STORE_2
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2022-02-10 Nikolai Toknov	   Initial version
#  2.0  2022-07-12 Nikolai Toknov	   Add country_pol_cd
#-------------------------------------------------------------------------------
*/

/* 
---------------------------------------------------------------------
0. Create View Table in V_SOURCE_LOC_STORE_2
------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_pit.v_source_loc_store_2 OPTIONS(DESCRIPTION = `SOURCE VIEW STORE`) AS SELECT CAST(loc.client_id AS BIGNUMERIC)
 AS client_id,
 loc.loc_sid AS store_sid,
 ROUND(CAST(loc.longitude AS BIGNUMERIC), 5) AS store_longitude,
 ROUND(CAST(loc.latitude AS BIGNUMERIC), 5) AS store_latitude,
 IF(loc.longitude IS NOT NULL AND loc.latitude IS NOT NULL, 1, 0) AS geo_info_fg,
 COALESCE(loc.loc_name, 'N/A') AS store_name,
 CAST(loc.src_orig_store_nr AS BIGNUMERIC) AS orig_store_nr,
 COALESCE(loch.closed_fg, 0) AS closed_fg,
 COALESCE(loch.test_store_fg, 0) AS test_store_fg,
 COALESCE(loch.dummy_store_fg, 0) AS dummy_store_fg,
 COALESCE(loch.template_store_fg, 0) AS template_store_fg,
 loc.country_pol_cd,
 COALESCE(loc.real_opening_dt, PARSE_DATE('%F', '8888-12-31')) AS real_opening_dt,
 COALESCE(loc.opening_dt, PARSE_DATE('%F', '8888-12-31')) AS opening_dt,
 COALESCE(loc.closing_dt, PARSE_DATE('%F', '8888-12-31')) AS closing_dt,
 COALESCE(loch.dwh_valid_from, PARSE_DATE('%F', '1900-01-01')) AS valid_from_dt,
 COALESCE(loch.dwh_valid_to, PARSE_DATE('%F', '9999-12-31')) AS valid_to_dt,
 COALESCE(CAST(loch.deleted_fg AS BIGNUMERIC), 0) AS deleted_fg,
 loch.dwh_updated AS dwh_updated_ts
FROM (SELECT *
  FROM ldl_p_lew_core.t_location_2
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(loc_sid AS STRING) ORDER BY dwh_updated IS NULL DESC, dwh_updated DESC)
     ) = 1) AS loc
 INNER JOIN (SELECT *
  FROM ldl_p_lew_core.t_location_hist_2
  WHERE deleted_fg = 0
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(loc_sid AS STRING), dwh_valid_from ORDER BY dwh_updated IS NULL DESC,
        dwh_updated DESC)) = 1) AS loch ON loc.loc_sid = loch.loc_sid
WHERE UPPER(loc.wh_store_mark) = 'A'
 AND loc.src_orig_store_nr > 0;