/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : View for V_SOURCE_DELIV_AGG_DELIV_BASE
#-------------------------------------------------------------------------------
# Describtion: Create View for V_SOURCE_DELIV_AGG_DELIV_BASE
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-08-13 Massimo Morelli     Initial version
#  1.1  2021-09-29 Dirk Hering         Use example role added, data types added, column order, formatting
#  1.2  2021-10-13 Massimo Morelli	   Added delivery type, requested for business rule
#-------------------------------------------------------------------------------
*/

/* 
---------------------------------------------------------------------
0. Create View Table in V_SOURCE_DELIV_AGG_DELIV_BASE
------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_pit.v_source_deliv_agg_deliv_base
OPTIONS(DESCRIPTION = `V_SOURCE_DELIV_AGG_DELIV_BASE`) AS SELECT CAST(client_id AS BIGNUMERIC) AS client_id,
 CAST(item_sid AS BIGNUMERIC) AS item_sid,
 DATE(dat_formdate) AS dat_formdate,
 CAST(loc_sid_store AS BIGNUMERIC) AS store_sid,
 CAST(qty_total_del AS BIGNUMERIC) AS item_delivery_to_store_qty,
 CAST(deliverytype_id AS BIGNUMERIC) AS deliverytype_id,
 PARSE_DATE('%F', '1900-01-01') AS valid_from_dt,
 PARSE_DATE('%F', '9999-12-31') AS valid_to_dt,
 0 AS deleted_fg,
 dwh_updated AS dwh_updated_ts
FROM ldl_p_lew_bil.t_agg_deliv_base
WHERE client_id IN (SELECT client_id
   FROM ldl_p_lew_mart_pit.t_dim_client
   WHERE pit_country_fg = 1
    AND deleted_fg = 0
    AND reject_fg = 0
    AND current_fg = 1
   GROUP BY client_id);