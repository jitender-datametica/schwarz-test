CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_plan_year (client_id, plan_id, indicator_id, dat_dayend, dat_valid_from
, dat_valid_until, currency_iso_cd, cy_week, cy, wh_loc_sid, orig_store_nr, itemgroup_int_id, orig_item_nr,
pct_plan_year, val_plan_year, load_id) AS SELECT client_id,
 plan_id,
 indicator_id,
 dat_dayend,
 dat_valid_from,
 dat_valid_until,
 currency_iso_cd,
 cy_week,
 cy,
 wh_loc_sid,
 orig_store_nr,
 itemgroup_int_id,
 orig_item_nr,
 pct_plan_year,
 val_plan_year,
 load_id
FROM ldl_p_lew_core.t_wawi_plan_year;