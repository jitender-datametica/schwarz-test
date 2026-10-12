/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_KZP_FILIALSTAMM_2
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#  1.1  31.07.2023    Ulrich Ross                  Add opening flag per weekday
#                                                  https://dev.azure.com/schwarzit/schwarzit.biaid/_workitems/edit/493379
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_CS.V_KZP_FILIALSTAMM_2
(
    client_id
  , country_iso_cd
  , src_wh_id
  , closed_store_fg
  , src_orig_store_nr
  , mde_lang_cd
  , qty_min_dflt
  , loc_name
  , region_cd
  , opening_dt
  , closing_dt
  , dat_valid_from
  , dat_valid_until
  , dat_opening_ovis
  , dat_closing_ovis
  , real_opening_dt
  , is_mon_open
  , is_tue_open
  , is_wed_open
  , is_thu_open
  , is_fri_open
  , is_sat_open
  , is_sun_open  
  , load_id
)
AS
  SELECT
      store.client_id
    , store.country_iso_cd
    , store.src_wh_id
    , store.closed_store_fg
    , store.src_orig_store_nr
    , store.mde_lang_cd
    , store.qty_min_dflt
    , store.loc_name
    , store.region_cd
    , store.opening_dt
    , store.closing_dt
    , store.dat_valid_from
    , store.dat_valid_until
    , store.dat_opening_ovis
    , store.dat_closing_ovis
    , store.real_opening_dt
    , store.is_mon_open
    , store.is_tue_open
    , store.is_wed_open
    , store.is_thu_open
    , store.is_fri_open
    , store.is_sat_open
    , store.is_sun_open
    , store.dwh_load_id
  FROM p_lew_mart_cs.v_gen_kzp_store_2 AS store
   ;