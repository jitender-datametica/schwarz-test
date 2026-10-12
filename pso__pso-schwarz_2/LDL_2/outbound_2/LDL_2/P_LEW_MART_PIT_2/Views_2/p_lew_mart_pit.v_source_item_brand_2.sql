/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : View for V_SOURCE_ITEM_BRAND_2
#-------------------------------------------------------------------------------
# Describtion: Create View for V_SOURCE_ITEM_BRAND_2
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-08-16 Massimo Morelli     Initial version
#  1.1  2021-09-08 Mike Davis          Minor adjustments
#                                      Note: brand_type_cd only non-Null for client 7 (INTEGER )
#  1.2  2021-09-29 Dirk Hering         Use example role added, data types added, column order, formatting
#  1.3  2021-10-11 Dirk Hering         Deduplication from source (Qualify Row Number = 1); T.DWH_UPDATED
#-------------------------------------------------------------------------------
*/


/* 
---------------------------------------------------------------------
0. Create View Table in V_SOURCE_ITEM_BRAND_2
------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_pit.v_source_item_brand_2 OPTIONS(DESCRIPTION = `V_SOURCE_ITEM_BRAND_2`) AS
-- brand_2 information
 -- technical versioning
 -- PIT Country_2

-- Deduplication on the source PK (Snowflake does not enforce unique constraints. Just as a precaution here.)
 SELECT
 -- keys (also see version)
 client_id,
 brand_sid,
 CAST(brand_name AS STRING) AS brand_name,
 CAST(brand_type_cd AS STRING) AS brand_type_cd,
 PARSE_DATE('%F', '1900-01-01') AS valid_from_dt,
 PARSE_DATE('%F', '9999-12-31') AS valid_to_dt,
 0 AS deleted_fg,
 dwh_updated AS dwh_updated_ts
FROM ldl_p_lew_core.t_brand_2
WHERE client_id IN (SELECT client_id
   FROM ldl_p_lew_mart_pit.t_dim_client_2
   WHERE pit_country_fg = 1
    AND deleted_fg = 0
    AND reject_fg = 0
    AND current_fg = 1
   GROUP BY client_id)
QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(brand_sid AS STRING) ORDER BY dwh_updated IS NULL DESC, dwh_updated DESC)
   ) = 1;