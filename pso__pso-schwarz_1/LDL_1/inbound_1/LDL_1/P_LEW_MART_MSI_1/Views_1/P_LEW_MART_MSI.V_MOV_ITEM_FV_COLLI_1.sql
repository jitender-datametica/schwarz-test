CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_MOV_ITEM_FV_COLLI_1
/* 
#DescStart# 
#$Revision: 13364 $, $LastChangedBy: umeister $ 
#SubjectAreas#: Anliefermenge 
#DescEnd# 
*/
(client_id
  ,store_id
  ,item_id
  ,dat_formdate
  ,case_size_real
)
AS
SELECT
v.client_id,
v.loc_sid_store AS store_id,
v.item_sid AS item_id,
v.last_delivery_dt AS dat_formdate,
v.min_case_size_dec AS case_size_real
FROM p_lew_core_ac.v_item_fruits_vegetables_store_info_1 AS v
;

/**** WARNING: MISSING DEPENDENT OBJECTS "p_lew_core_ac.v_item_fruits_vegetables_delivery_1", "p_lew_mart_msi.v_itm_item_1", "p_lew_bil_ac.v_store_to_warehouse_lastknown_1", "p_lew_core_ac.v_item_group_1", "p_lew_core_ac.v_location_1", "p_lew_core_ac.v_exchange_rate_known_hist_1", "p_lew_core_ac.v_exchange_rate_type_1" ****/

