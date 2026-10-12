/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : View for V_SOURCE_STD_WAWI_ITEM_ADVERTISING_1
#-------------------------------------------------------------------------------
# Describtion: Create View for V_SOURCE_STD_WAWI_ITEM_ADVERTISING_1
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-08-16 Massimo Morelli     Initial version
#  1.1  2021-09-29 Dirk Hering         Use example role added, data types added, column order, formatting
#  1.2  2021-10-08 Dirk Hering         New target names: warehouse_sid
#  1.3  2021-10-12 Dirk Hering         Deduplication from source (Qualify Row Number = 1)
#-------------------------------------------------------------------------------
*/


/* 
---------------------------------------------------------------------
0. Create View Table in V_SOURCE_STD_WAWI_ITEM_ADVERTISING_1
------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_pit.v_source_std_wawi_item_advertising_1
OPTIONS(DESCRIPTION = `V_SOURCE_STD_WAWI_ITEM_ADVERTISING_1`) AS SELECT CAST(client_id AS BIGNUMERIC) AS client_id,
 CAST(wh_loc_sid AS BIGNUMERIC) AS warehouse_sid,
 DATE(dat_dayend) AS dat_dayend,
 CAST(item_sid AS BIGNUMERIC) AS item_sid,
 CAST(price_retail_adv AS BIGNUMERIC) AS price_retail_adv,
 DATE(dat_adv) AS dat_adv,
 PARSE_DATE('%F', '1900-01-01') AS valid_from_dt,
 PARSE_DATE('%F', '9999-12-31') AS valid_to_dt,
 0 AS deleted_fg,
 CAST(CURRENT_TIMESTAMP() AS DATETIME) AS dwh_updated_ts
FROM ldl_p_lew_core.t_wawi_adv_item_advertising_1
WHERE client_id IN (SELECT client_id
   FROM ldl_p_lew_mart_pit.t_dim_client_1
   WHERE pit_country_fg = 1
    AND deleted_fg = 0
    AND reject_fg = 0
    AND current_fg = 1
   GROUP BY client_id)
QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_loc_sid AS STRING), CAST(item_sid AS STRING)
      , dat_adv ORDER BY dat_dayend IS NULL, dat_dayend, load_id IS NULL DESC, load_id DESC)) = 1;