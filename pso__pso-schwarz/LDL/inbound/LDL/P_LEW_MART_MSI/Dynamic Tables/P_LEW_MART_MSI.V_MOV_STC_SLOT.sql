
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_MOV_STC_SLOT

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
/*
#DescStart#
#$Revision: 13364 $, $LastChangedBy: umeister $
#SubjectAreas#: Anliefermenge
#DescEnd#
*/
SELECT
a.client_id,
wh.src_wh_id AS wh_id,
a.stc_slot_area_nr AS stc_slot_area,
a.stc_slot_nr AS stc_slot_id,
CAST(a.stc_slot_nr / 1000 AS DECIMAL(6,0)) AS stc_slot_aisle,
CAST(MOD(a.stc_slot_nr, 1000) AS DECIMAL(4,0)) AS stc_slot_location
FROM p_lew_core_ac.v_item_delivery AS a
INNER JOIN p_lew_bil_ac.v_warehouse AS wh
ON wh.client_id = a.client_id
AND wh.loc_sid_wh = a.loc_sid_wh
AND wh.dwh_actual_fg = 1
WHERE  a.dwh_cal_dt >= DATE '2013-03-01'
GROUP BY a.client_id
    , wh.src_wh_id
    ,a.stc_slot_area_nr
    ,a.stc_slot_nr
UNION
SELECT
b.client_id,
wh.src_wh_id AS wh_id,
-1::INTEGER AS stc_slot_area,
b.slot_nr AS stc_slot_id,
CAST(b.slot_nr / 1000 AS DECIMAL(6,0)) AS stc_slot_aisle,
CAST(MOD(b.slot_nr, 1000) AS DECIMAL(4,0)) AS stc_slot_location
FROM p_lew_core_ac.v_item_fruits_vegetables_delivery AS b
INNER JOIN p_lew_bil_ac.v_warehouse AS wh
ON wh.client_id = b.client_id
AND wh.loc_sid_wh = b.loc_sid_wh
AND wh.dwh_actual_fg = 1
WHERE  b.dwh_cal_dt >= DATE '2013-03-01'
GROUP BY b.client_id
    , wh.src_wh_id
    ,b.slot_nr
;
/**** WARNING: MISSING DEPENDENT OBJECTS "p_lew_core_ac.v_store_form", "p_lew_bil_ac.v_warehouse", "p_lew_core_ac.v_wawi_ref_client_currency_rate", "p_lew_core_ac.v_item_map_key" ****/
