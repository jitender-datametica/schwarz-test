
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_ITM_PP_PICKING_MAIN_AREA_2

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
   SELECT
   a.client_id,
   wh.src_wh_id AS wh_id_pp -- workaround
   ,
   a.pick_area_id AS picking_area_nr_pp,
   10 * TRUNC(picking_area_nr_pp / 10) AS picking_main_area_nr_pp,
   a.pick_main_area_descr AS picking_main_area_desc_pp
   FROM p_lew_core_ac.v_ref_pick_area_descr_2 a
   INNER JOIN p_lew_bil_ac.v_warehouse_2 AS wh
   ON wh.client_id = a.client_id
   AND wh.loc_sid_wh =  a.loc_sid
   AND wh.dwh_actual_fg = 1
   -- Stiftungssprache
   WHERE a.lang_sid = 2
;
