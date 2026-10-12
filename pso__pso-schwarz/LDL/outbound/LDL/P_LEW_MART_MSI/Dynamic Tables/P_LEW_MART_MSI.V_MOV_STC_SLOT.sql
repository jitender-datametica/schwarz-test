CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_msi.v_mov_stc_slot
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true) AS
SELECT A.client_id,
 WH.src_wh_id AS wh_id,
 A.stc_slot_area_nr AS stc_slot_area,
 A.stc_slot_nr AS stc_slot_id,
 CAST(A.stc_slot_nr / 1000 AS BIGNUMERIC) AS stc_slot_aisle,
 CAST(MOD(CAST(A.stc_slot_nr AS BIGNUMERIC), 1000) AS BIGNUMERIC) AS stc_slot_location
FROM ldl_p_lew_core_ac.v_item_delivery AS A
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse AS WH ON A.client_id = WH.client_id AND A.loc_sid_wh = WH.loc_sid_wh AND WH.dwh_actual_fg
    = 1
WHERE A.dwh_cal_dt >= DATE '2013-03-01'
GROUP BY A.client_id,
 wh_id,
 stc_slot_area,
 stc_slot_id
UNION DISTINCT
SELECT B.client_id,
 WH.src_wh_id AS wh_id,
 - 1 AS stc_slot_area,
 B.slot_nr AS stc_slot_id,
 CAST(B.slot_nr / 1000 AS BIGNUMERIC) AS stc_slot_aisle,
 CAST(MOD(CAST(B.slot_nr AS BIGNUMERIC), 1000) AS BIGNUMERIC) AS stc_slot_location
FROM ldl_p_lew_core_ac.v_item_fruits_vegetables_delivery AS B
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse AS WH ON B.client_id = WH.client_id AND B.loc_sid_wh = WH.loc_sid_wh AND WH.dwh_actual_fg
    = 1
WHERE B.dwh_cal_dt >= DATE '2013-03-01'
GROUP BY B.client_id,
 wh_id,
 stc_slot_id;


/**** WARNING: MISSING DEPENDENT OBJECTS "p_lew_core_ac.v_store_form", "p_lew_bil_ac.v_warehouse", "p_lew_core_ac.v_wawi_ref_client_currency_rate", "p_lew_core_ac.v_item_map_key" ****/