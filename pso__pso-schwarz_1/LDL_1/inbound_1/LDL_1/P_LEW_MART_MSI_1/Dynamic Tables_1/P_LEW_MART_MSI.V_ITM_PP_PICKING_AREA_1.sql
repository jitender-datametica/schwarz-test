
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_ITM_PP_PICKING_AREA_1

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
   SELECT
   pa.client_id,
   pa.client_id AS language_id,
   pa.pick_area_descr AS     picking_area_desc_pp,
   pa.pick_area_id AS picking_area_nr_pp,
   wh.src_wh_id AS wh_id_pp
   FROM p_lew_core_ac.v_ref_pick_area_descr_1 AS pa
   INNER JOIN p_lew_bil_ac.v_warehouse_1 AS wh
   ON wh.client_id = pa.client_id
   AND wh.loc_sid_wh = pa.loc_sid
   AND wh.dwh_actual_fg = 1
   -- außer Stiftungssprache
   WHERE pa.lang_sid <> 2
;
