CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_miss_itm_store_day_asis_1 (client_id, loc_sid_store, item_sid, wh_loc_sid,
dat_formdate) AS SELECT ASIS.client_id,
 ASIS.loc_sid_store,
 ASIS.item_sid,
 ORG.loc_sid_wh AS wh_loc_sid,
 ASIS.dat_formdate
 -- , asis.cy_month -- All five columns are obsolete. These have been removed in the underlying table on 22.03.2022.

 -- , asis.cy_partial_week_id
 -- , asis.cy_week
 -- , asis.miss_item_fg
 -- , asis.busyear

FROM ldl_p_lew_mart_lead.t_miss_itm_store_day_asis_1 AS ASIS
 INNER JOIN ldl_p_lew_bil_ac.v_org_store_merge_1 AS ORG ON ASIS.client_id = ORG.client_id AND ASIS.loc_sid_store = ORG.loc_sid_store
     AND ORG.aspect_id = 1
 INNER JOIN (SELECT client_id,
    loc_sid AS wh_loc_sid,
    item_sid,
    dwh_valid_from,
    dwh_valid_to
   FROM ldl_p_lew_core_ac.v_item_info_per_location_hist_1
   WHERE item_status_cd IN ('40', '45', '50', 'S1', 'S4')
   UNION ALL
   SELECT client_id,
    wh_loc_sid,
    item_sid,
    dat_rec_start AS dwh_valid_from,
    dat_rec_end AS dwh_valid_to
   FROM ldl_p_lew_core_ac.v_wawi_itm_item_wh_1
   WHERE item_status IN (7, 8, 9)) AS wh ON ASIS.client_id = wh.client_id AND ORG.loc_sid_wh = wh.wh_loc_sid AND ASIS.item_sid
     = wh.item_sid AND ASIS.dat_formdate BETWEEN wh.dwh_valid_from AND wh.dwh_valid_to;