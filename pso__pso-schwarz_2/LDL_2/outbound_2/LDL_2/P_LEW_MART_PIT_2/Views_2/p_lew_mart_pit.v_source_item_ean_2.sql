/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : VIEW FOR V_SOURCE_ITEM_EAN_2
#-------------------------------------------------------------------------------
# Description: CREATE VIEW FOR V_SOURCE_ITEM_EAN_2 (item_2 sub group)
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
USE SCHEMA 		P_LEW_MART_PIT_2;
 */
/*
---------------------------------------------------------------------
0.   CREATE VIEW in V_SOURCE_ITEM_EAN_2
     EAN_2 | BARCODE (ejr)
     DESC VIEW P_LEW_MART_PIT.V_SOURCE_ITEM_EAN_2
------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_pit.v_source_item_ean_2 OPTIONS(DESCRIPTION = `V_SOURCE_ITEM_EAN_2`) AS SELECT CAST(client_id AS BIGNUMERIC)
 AS client_id,
 CAST(item_sid AS BIGNUMERIC) AS item_sid,
 CAST(ean_2 AS STRING) AS ean_2,
 CAST(ean_item_desc AS STRING) AS ean_item_descr,
 TO_HEX(MD5(COALESCE(ean_2, '') || COALESCE(ean_item_desc, ''))) AS scd_key_md,
 DATE(dat_rec_start) AS valid_from_dt,
 DATE(dat_rec_end) AS valid_to_dt,
 0 AS deleted_fg,
 CAST(CURRENT_TIMESTAMP() AS DATETIME) AS dwh_updated_ts
FROM ldl_p_lew_core.t_wawi_itm_ean_2
WHERE client_id = language_id
 AND client_id IN (SELECT client_id
   FROM ldl_p_lew_mart_pit.t_dim_client_2
   WHERE pit_country_fg = 1
    AND deleted_fg = 0
    AND reject_fg = 0
    AND current_fg = 1
   GROUP BY client_id)
QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(client_id AS STRING), CAST(item_sid AS STRING), ean_2 ORDER BY dat_rec_start
      IS NULL DESC, dat_rec_start DESC)) = 1;