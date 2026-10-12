/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_GEN_STORE_2
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_gen_store_2 (client_id, loc_sid_store, src_orig_store_nr, src_wh_id, opening_dt
, real_opening_dt, closing_dt, dwh_valid_from, dwh_valid_to, mde_print_cd, mde_lang_cd, dat_rec_start, qty_min_dflt,
ord_unit_valid_store_cd, object_nr, licence_nr, wh_type_id, store_desc, street, city, postbox, zip_code, phone_number,
fax_number, country_iso_cd, closed_fg, test_store_fg, dummy_store_fg, pseudo_store_fg, dwh_actual_fg, active_fg) AS
SELECT LOC.client_id,
 LOC.loc_sid_store,
 LOC.src_orig_store_nr,
 S2WLK.src_wh_id,
 LOC.opening_dt,
 LOC.real_opening_dt,
 LOC.closing_dt,
 LOC.dwh_valid_from,
 LOC.dwh_valid_to,
 WAWI_ST.mde_print_cd,
 WAWI_ST.mde_lang_cd,
 WAWI_ST.dat_rec_start,
 WAWI_ST.qty_min_dflt,
 WAWI_ST.ord_unit_valid_store_cd,
 WAWI_ST.object_nr,
 WAWI_ST.licence_nr,
 WAWI_SW.wh_type_id,
 COALESCE(LOC.loc_name2, LOC.loc_name) AS store_desc,
 ADR.street,
 ADR.city,
 ADR.postbox,
 ADR.zip_code,
 ADR.phone_number,
 ADR.fax_number,
 LOC.country_iso_cd,
 WAWI_ST.closed_fg,
 LOC.test_store_fg,
 LOC.dummy_store_fg,
 LOC.pseudo_store_fg,
 LOC.dwh_actual_fg,
 LOC.active_fg
FROM ldl_p_lew_bil_ac.v_store_2 AS LOC
 INNER JOIN ldl_p_lew_core_ac.v_location_hist_2 AS LOC_H ON LOC.client_id = LOC_H.client_id AND LOC.loc_sid_store = LOC_H
     .loc_sid AND CURRENT_DATE BETWEEN LOC_H.dwh_valid_from AND LOC_H.dwh_valid_to AND LOC_H.deleted_fg = 0
 LEFT JOIN ldl_p_lew_bil_ac.v_store_to_warehouse_lastknown_2 AS S2WLK ON LOC.client_id = S2WLK.client_id AND LOC.loc_sid_store
    = S2WLK.loc_sid_store
 LEFT JOIN ldl_p_lew_core_ac.v_wawi_org_store_2 AS WAWI_ST ON LOC.client_id = WAWI_ST.client_id AND LOC.loc_sid_store =
    WAWI_ST.st_loc_sid AND CURRENT_DATE BETWEEN WAWI_ST.dat_rec_start AND WAWI_ST.dat_rec_end
 LEFT JOIN ldl_p_lew_core_ac.v_address_2 AS ADR ON LOC.client_id = ADR.client_id AND LOC_H.addr_sid = ADR.addr_sid
 LEFT JOIN ldl_p_lew_core_ac.v_wawi_org_wh_store_2 AS WAWI_SW ON LOC.client_id = WAWI_SW.client_id AND LOC.loc_sid_store =
    WAWI_SW.st_loc_sid AND CURRENT_DATE BETWEEN WAWI_SW.dat_rec_start AND WAWI_SW.dat_rec_end;