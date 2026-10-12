CREATE OR REPLACE VIEW P_LEW_PRECORE.V_LOCATION_MAP_KEY
AS
   SELECT
    loc.client_id,
   loc.loc_sid,
   loc.src_werks,
   loc.src_orig_store_nr,
   loc.src_orig_wh_nr,
   loc.src_store_id,
   loc.src_wh_id,
   loc.loc_name,
   loc.loc_name2,
   loc.loc_sid_successor_act,
   loc.country_pol_sid,
   loc.country_pol_cd,
   loc.wh_store_mark,
   loc.wh_store_label,
   loc.storetype_mark,
   loc.storetype_label,
   loc.customer_cd,
   loc.global_loc_ctry_cd,
   loc.global_loc_id,
   loc.global_loc_id_length,
   loc.global_loc_type_cd,
   loc.opening_dt,
   loc.real_opening_dt,
   loc.closing_dt,
   loc.longitude,
   loc.latitude,
   loc.sap_creation_wrf1_dt,
   loc.dwh_load_id,
   loc.dwh_created,
   loc.dwh_updated

   FROM p_lew_core_ac.v_location loc
   JOIN p_lew_core_ac.v_location_hist loc_hist
   ON loc.loc_sid = loc_hist.loc_sid
   WHERE--  test_store_fg = 0 AND 
   wh_store_label = 'Store'  -- Taking only Stores and Filtering Test Stores out
   AND CURRENT_DATE between dwh_valid_from and dwh_valid_to
   ;