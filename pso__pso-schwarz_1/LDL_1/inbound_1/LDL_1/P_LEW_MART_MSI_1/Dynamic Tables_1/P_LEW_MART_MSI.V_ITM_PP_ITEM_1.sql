
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_ITM_PP_ITEM_1

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
   SELECT
   a.client_id                                                  AS client_id,
   wh.src_wh_id                                                 AS wh_id_pp,
   a.pick_area_id                                               AS picking_area_nr_pp,
   COALESCE(itmp.dwh_orig_item_nr, itmp.wawi_dwh_orig_item_nr)  AS orig_item_nr_pp,
   COALESCE(itmp.dwh_case_size, itmp.wawi_dwh_case_size)        AS case_size_pp,
   itmp.item_sid_map                                            AS item_id,
   a.missing_status_start_tmsp                                  AS timestamp_from_pp,
   a.missing_status_end_tmsp                                    AS timestamp_until_pp,
   a.dwh_cal_dt                                                 AS dat_sys,
   a.missing_status_cd                       AS end_cd_pp,
   a.missing_item_status_cd                  AS item_status_pp
   FROM p_lew_core_ac.v_missing_item_wh_day_status_1 AS a
   INNER JOIN p_lew_bil_ac.v_warehouse_1 AS wh
   ON  wh.client_id      = a.client_id
   AND wh.loc_sid_wh     = a.loc_sid
   AND wh.dwh_actual_fg  = 1
   INNER JOIN p_lew_core_ac.v_item_map_key_1 AS itmp
   ON  itmp.client_id    = a.client_id
   AND itmp.item_sid     = a.item_sid
   ;
