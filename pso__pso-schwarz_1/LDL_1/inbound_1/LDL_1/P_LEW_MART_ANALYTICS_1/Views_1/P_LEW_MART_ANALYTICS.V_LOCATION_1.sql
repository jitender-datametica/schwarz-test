CREATE OR REPLACE VIEW P_LEW_MART_ANALYTICS.V_LOCATION_1
(
    client_id
    , loc_sid
    , src_werks
    , src_orig_store_nr
    , src_orig_wh_nr
    , src_store_id
    , src_wh_id
    , loc_name
    , loc_name2
    , loc_sid_successor_act
    , country_pol_sid
    , country_pol_cd
    , wh_store_mark
    , wh_store_label
    , storetype_mark
    , storetype_label
    , customer_cd
    , global_loc_ctry_cd
    , global_loc_id
    , global_loc_id_length
    , global_loc_type_cd
    , opening_dt
    , real_opening_dt
    , closing_dt
    , longitude
    , latitude
    , sap_creation_wrf1_dt
    , dwh_load_id
    , dwh_created
    , dwh_updated
)
AS
   SELECT
       client_id,
   loc_sid,
   src_werks,
   src_orig_store_nr,
   src_orig_wh_nr,
   src_store_id,
   src_wh_id,
   loc_name,
   loc_name2,
   loc_sid_successor_act,
   country_pol_sid,
   country_pol_cd,
   wh_store_mark,
   wh_store_label,
   storetype_mark,
   storetype_label,
   customer_cd,
   global_loc_ctry_cd,
   global_loc_id,
   global_loc_id_length,
   global_loc_type_cd,
   opening_dt,
   real_opening_dt,
   closing_dt,
   longitude,
   latitude,
   sap_creation_wrf1_dt,
   dwh_load_id,
   dwh_created,
   dwh_updated
  FROM p_lew_core_ac.v_location_1
;