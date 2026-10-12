/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_CS_AC.V_KZP_FILIALSTAMM_2
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#  1.1 31.07.2023    Ulrich Ross                   Add opening flag per weekday
#                                                  https://dev.azure.com/schwarzit/schwarzit.biaid/_workitems/edit/493379
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_CS_AC.V_KZP_FILIALSTAMM_2
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
FROM p_lew_mart_cs.v_kzp_filialstamm_2
;


