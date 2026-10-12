/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : View for v_source_sfo_delivery_store_1
#-------------------------------------------------------------------------------
# Describtion: Create View for v_source_sfo_delivery_store_1
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2022-07-95 Massimo Morelli	   	Initial version
#  2.0	2022-07-16 Nikolai Toknov  Changing the script for DevOps
#-------------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_pit.v_source_sfo_delivery_store_1
OPTIONS(DESCRIPTION = `SOURCE VIEW FOR SFO (DELIVERY TO STORE)`) AS SELECT CAST(client_id AS BIGNUMERIC) AS client_id,
 CAST(item_sid AS BIGNUMERIC) AS item_sid,
 CAST(loc_sid_store AS BIGNUMERIC) AS store_sid,
 DATE(booking_dat) AS day_dt,
 CAST(sfo_total_qty AS BIGNUMERIC) AS sfo_total_qty,
 DATE('1900-01-01') AS valid_from_dt,
 DATE('9999-12-31') AS valid_to_dt,
 0 AS deleted_fg,
 dwh_updated AS dwh_updated_ts
FROM ldl_p_lew_bil.t_agg_store_day_item_sfo_1
WHERE sfotype_id IN (135, 145)
 AND booking_dat >= DATE '2019-01-01'
 AND booking_dat <= CURRENT_DATE
 AND client_id IN (SELECT client_id
   FROM ldl_p_lew_mart_pit.t_dim_client_1
   WHERE pit_country_fg = 1
    AND deleted_fg = 0
    AND reject_fg = 0
    AND current_fg = 1
   GROUP BY client_id);