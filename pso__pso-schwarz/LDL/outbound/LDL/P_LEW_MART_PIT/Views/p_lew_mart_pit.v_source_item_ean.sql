/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : VIEW FOR V_SOURCE_ITEM_EAN
#-------------------------------------------------------------------------------
# Description: CREATE VIEW FOR V_SOURCE_ITEM_EAN (item sub group)
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2024-02-07 Andreas Kurz     Initial version
#-------------------------------------------------------------------------------
*/
/*
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R60001;
USE SCHEMA 		P_LEW_MART_PIT;
 */
/*
---------------------------------------------------------------------
0.   CREATE VIEW in V_SOURCE_ITEM_EAN
     EAN | BARCODE (ejr)
     DESC VIEW P_LEW_MART_PIT.V_SOURCE_ITEM_EAN
------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_pit.v_source_item_ean OPTIONS(DESCRIPTION = `V_SOURCE_ITEM_EAN`) AS SELECT CAST(client_id AS BIGNUMERIC)
 AS client_id,
 CAST(item_sid AS BIGNUMERIC) AS item_sid,
 CAST(ean AS STRING) AS ean,
 CAST(ean_item_desc AS STRING) AS ean_item_descr,
 TO_HEX(MD5(COALESCE(ean, '') || COALESCE(ean_item_desc, ''))) AS scd_key_md,
 DATE(dat_rec_start) AS valid_from_dt,
 DATE(dat_rec_end) AS valid_to_dt,
 0 AS deleted_fg,
 CAST(CURRENT_TIMESTAMP() AS DATETIME) AS dwh_updated_ts
FROM ldl_p_lew_core.t_wawi_itm_ean
WHERE client_id = language_id
 AND client_id IN (SELECT client_id
   FROM ldl_p_lew_mart_pit.t_dim_client
   WHERE pit_country_fg = 1
    AND deleted_fg = 0
    AND reject_fg = 0
    AND current_fg = 1
   GROUP BY client_id)
QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(client_id AS STRING), CAST(item_sid AS STRING), ean ORDER BY dat_rec_start
      IS NULL DESC, dat_rec_start DESC)) = 1;