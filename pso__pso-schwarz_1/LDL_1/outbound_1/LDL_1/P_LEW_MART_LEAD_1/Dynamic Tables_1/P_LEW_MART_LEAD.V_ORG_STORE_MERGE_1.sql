CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_lead.v_org_store_merge_1
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT OSM.loc_sid_store AS store_id,
 OSM.client_id,
 OSM.country_cd,
 OSM.dat_opening,
 OSM.dat_real_opening,
 OSM.dat_closing,
 OSM.dat_valid_from,
 OSM.region_cd,
 OSM.object_nr,
 OSM.licence_nr,
 OSM.pst_lang_cd,
 OSM.mde_print_cd,
 OSM.closed_fg,
 OSM.mde_lang_cd,
 OSM.ord_unit_valid_store_cd,
 OSM.test_store_fg,
 OSM.transfer_fg,
 OSM.store_desc,
 OSM.src_orig_store_nr AS orig_store_nr,
 WH.src_wh_id AS wh_id,
 WH.loc_sid_wh,
 OSM.cnt_open_days,
 OSM.qty_min_dflt,
 OSM.dat_calc_start_py,
 OSM.dat_calc_end_py,
 OSM.dat_calc_start_ppy,
 OSM.dat_opening_ovis,
 OSM.dat_closing_ovis,
 OSM.objectstatus_id,
 OSM.mis_store_active_fg,
 OSM.loc_sid_store_move_to AS move_to_store_id,
 OSM.move_fg,
 OSM.aspect_id
FROM ldl_p_lew_bil_ac.v_org_store_merge_1 AS OSM
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse_1 AS WH ON OSM.loc_sid_wh = WH.loc_sid_wh AND OSM.client_id = WH.client_id AND WH
   .dwh_actual_fg = 1 /* analog MART_MSI */
WHERE OSM.client_id NOT IN (18)
 OR OSM.src_orig_store_nr <> 9988 AND NOT OSM.src_orig_store_nr BETWEEN 7501 AND 7599;