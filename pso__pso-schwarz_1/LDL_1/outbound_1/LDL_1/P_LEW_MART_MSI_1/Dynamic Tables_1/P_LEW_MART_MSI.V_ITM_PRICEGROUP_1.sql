CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_msi.v_itm_pricegroup_1
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
-- Auflösung WH
 SELECT A.client_id,
 WH.src_wh_id AS wh_id,
 A.st_loc_sid AS store_id,
 A.pricegroup_id,
 A.dat_valid_from AS dat_rec_start,
 A.dat_valid_until AS dat_rec_end,
 A.priority,
 A.pricegroup_desc
FROM ldl_p_lew_core_ac.v_wawi_itm_pricegroup_1 AS A
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse_1 AS WH ON A.client_id = WH.client_id AND A.wh_loc_sid = WH.loc_sid_wh AND WH.dwh_actual_fg
    = 1;