CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_LEAD.V_ORG_STORE_MERGE_WH_2
( store_id
, client_id
, country_cd
, dat_opening
, dat_real_opening
, dat_closing
, dat_valid_from
, region_cd
, object_nr
, licence_nr
, pst_lang_cd
, mde_print_cd
, closed_fg
, mde_lang_cd
, ord_unit_valid_store_cd
, test_store_fg
, transfer_fg
, store_desc
, orig_store_nr
, wh_id
, cnt_open_days
, qty_min_dflt
, dat_calc_start_py
, dat_calc_end_py
, dat_calc_start_ppy
, dat_opening_ovis
, dat_closing_ovis
, objectstatus_id
, mis_store_active_fg
, move_to_store_id
, move_fg
, aspect_id
)

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_LEAD

AS
   SELECT
   osm.loc_sid_store                       AS store_id,
   osm.client_id,
   osm.country_cd,
   osm.dat_opening,
   osm.dat_real_opening,
   osm.dat_closing,
   osm.dat_valid_from,
   osm.region_cd,
   osm.object_nr,
   osm.licence_nr,
   osm.pst_lang_cd,
   osm.mde_print_cd,
   osm.closed_fg,
   osm.mde_lang_cd,
   osm.ord_unit_valid_store_cd,
   osm.test_store_fg,
   osm.transfer_fg,
   osm.store_desc,
   osm.src_orig_store_nr                 AS orig_store_nr,
   wh.src_wh_id                          AS wh_id,
   osm.cnt_open_days,
   osm.qty_min_dflt,
   osm.dat_calc_start_py,
   osm.dat_calc_end_py,
   osm.dat_calc_start_ppy,
   osm.dat_opening_ovis,
   osm.dat_closing_ovis,
   osm.objectstatus_id,
   osm.mis_store_active_fg,
   osm.loc_sid_store_move_to             AS move_to_store_id,
   osm.move_fg,
   osm.aspect_id
   FROM p_lew_bil_ac.v_org_store_merge_2 osm
   INNER JOIN p_lew_bil_ac.v_warehouse_2 wh
   ON osm.loc_sid_wh = wh.loc_sid_wh
   AND osm.client_id = wh.client_id
   AND wh.dwh_actual_fg = 1;
