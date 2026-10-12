/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_GEN_STORE_1
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_CS.V_GEN_STORE_1
(
      client_id
    , loc_sid_store
    , src_orig_store_nr
    , src_wh_id
    , opening_dt
    , real_opening_dt
    , closing_dt
    , dwh_valid_from
    , dwh_valid_to
    , mde_print_cd
    , mde_lang_cd
    , dat_rec_start
    , qty_min_dflt
    , ord_unit_valid_store_cd
    , object_nr
    , licence_nr
    , wh_type_id
    , store_desc
    , street
    , city
    , postbox
    , zip_code
    , phone_number
    , fax_number
    , country_iso_cd
    , closed_fg
    , test_store_fg
    , dummy_store_fg
    , pseudo_store_fg
    , dwh_actual_fg
    , active_fg
)
AS
   SELECT
   loc.client_id,
   loc.loc_sid_store,
   loc.src_orig_store_nr,
   s2wlk.src_wh_id,
   loc.opening_dt,
   loc.real_opening_dt,
   loc.closing_dt,
   loc.dwh_valid_from,
   loc.dwh_valid_to,
   wawi_st.mde_print_cd,
   wawi_st.mde_lang_cd,
   wawi_st.dat_rec_start,
   wawi_st.qty_min_dflt,
   wawi_st.ord_unit_valid_store_cd,
   wawi_st.object_nr,
   wawi_st.licence_nr,
   wawi_sw.wh_type_id,
   Coalesce(loc.loc_name2,loc.loc_name) AS store_desc,
   adr.street,
   adr.city,
   adr.postbox,
   adr.zip_code,
   adr.phone_number,
   adr.fax_number,
   loc.country_iso_cd,
   wawi_st.closed_fg,
   loc.test_store_fg,
   loc.dummy_store_fg,
   loc.pseudo_store_fg,
   loc.dwh_actual_fg,
   loc.active_fg
   FROM p_lew_bil_ac.v_store_1 AS loc
   INNER JOIN p_lew_core_ac.v_location_hist_1 loc_h
   ON loc.client_id = loc_h.client_id
   AND loc.loc_sid_store = loc_h.loc_sid
   AND CURRENT_DATE BETWEEN loc_h.dwh_valid_from AND loc_h.dwh_valid_to
   AND loc_h.deleted_fg = 0
   LEFT OUTER JOIN p_lew_bil_ac.v_store_to_warehouse_lastknown_1 AS s2wlk
   ON loc.client_id = s2wlk.client_id
   AND loc.loc_sid_store = s2wlk.loc_sid_store
   LEFT OUTER JOIN p_lew_core_ac.v_wawi_org_store_1 AS wawi_st
   ON loc.client_id = wawi_st.client_id
   AND loc.loc_sid_store = wawi_st.st_loc_sid
   AND CURRENT_DATE BETWEEN wawi_st.dat_rec_start AND wawi_st.dat_rec_end
   LEFT OUTER JOIN p_lew_core_ac.v_address_1 adr
   ON loc.client_id = adr.client_id
   AND loc_h.addr_sid = adr.addr_sid
   LEFT OUTER JOIN p_lew_core_ac.v_wawi_org_wh_store_1 wawi_sw
   ON loc.client_id = wawi_sw.client_id
   AND loc.loc_sid_store = wawi_sw.st_loc_sid
   AND CURRENT_DATE BETWEEN wawi_sw.dat_rec_start AND wawi_sw.dat_rec_end
;